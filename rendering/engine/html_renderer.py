"""
Rendering engine: HTML/CSS → pixel-perfect PDF via Playwright (headless
Chromium), used for templates authored as HTML/CSS instead of XSL-FO.

CONFIRMED (not just assumed) as the right engine choice for pixel-exact
work: wkhtmltopdf was tested against this exact use case and found to
apply an undocumented, content-height-dependent "shrink to fit one
page" scale to absolutely-positioned content on this build (unpatched
Qt — `--disable-smart-shrinking` is rejected outright, and even `--dpi`
doesn't override it). That distortion made precise CSS-coordinate
calibration impossible — position error compounded with every
adjustment because the scale factor itself depended on total content
height. Switching to Playwright/Chromium eliminated it entirely:
independently-positioned elements matched the target to within 0.01pt
in testing (see rendering/templates/prv_enr_l016.html's calibration
comment for the full methodology). Do not reintroduce wkhtmltopdf as
an alternative for any template requiring absolute positioning.

NFR 5.1: PHI must only exist in memory during rendering — this module
never writes the merged payload to disk, only the final PDF bytes are
returned for the caller to persist/stream.
"""
from __future__ import annotations

from pathlib import Path

from jinja2 import Environment, FileSystemLoader
from playwright.sync_api import sync_playwright

from rendering.barcode.barcode_generator import generate_barcode_svg

TEMPLATE_DIR = Path(__file__).resolve().parent.parent / "templates"


def render_html_to_pdf(payload: dict) -> bytes:
    """
    payload: a UnifiedPayload dict (see middleware/data_unification/unify.py)
    Returns raw PDF bytes.
    """
    env = Environment(loader=FileSystemLoader(str(TEMPLATE_DIR)))
    # Letter IDs use hyphens (PRV-ENR-L016) but template filenames use
    # underscores (prv_enr_l016.html) — .lower() alone doesn't reconcile
    # that; this was silently broken (TemplateNotFound) until caught by
    # actually running this function end-to-end rather than trusting it.
    template_name = payload["letter_type"].lower().replace("-", "_") + ".html"
    template = env.get_template(template_name)

    barcode_svg = ""
    if payload.get("barcode_data"):
        symbology = payload.get("barcode_symbology", "code128")
        barcode_svg = generate_barcode_svg(payload["barcode_data"], symbology=symbology)

    html = template.render(**payload, barcode_svg=barcode_svg)

    with sync_playwright() as p:
        browser = p.chromium.launch()
        page = browser.new_page()
        # page.set_content() has no base_url parameter in this Playwright
        # version (verified directly — an earlier version of this function
        # assumed one existed and would have failed at runtime). Relative
        # asset paths (the state seal image) only resolve with a real
        # document location, so write to a temp file under TEMPLATE_DIR
        # and page.goto() it instead.
        import tempfile
        with tempfile.NamedTemporaryFile(
            mode="w", suffix=".html", dir=str(TEMPLATE_DIR), delete=False, encoding="utf-8"
        ) as tmp:
            tmp.write(html)
            tmp_path = tmp.name
        try:
            page.goto(f"file://{tmp_path}", wait_until="networkidle")
            pdf_bytes = page.pdf(
                width="8.5in",
                height="11in",
                print_background=True,
                margin={"top": "0", "bottom": "0", "left": "0", "right": "0"},
                # NFR: exact pagination / widow-orphan control comes from the
                # template's CSS (@page rules, break-inside: avoid, etc.)
                # Margins are 0 here deliberately for templates (like
                # prv_enr_l016.html) that position content absolutely and
                # handle their own page geometry — a non-zero margin here
                # would double up with the template's own coordinates.
            )
        finally:
            Path(tmp_path).unlink(missing_ok=True)
        browser.close()

    return pdf_bytes
