"""
Rendering engine: XSL-FO → PDF via Apache FOP, used for the strictest
CMS forms requiring deterministic pagination (NFR 5.2).

Requires a local Apache FOP install (`fop` on PATH) — bundled into the
rendering-worker container image, no outbound internet needed.
"""
from __future__ import annotations

import subprocess
import tempfile
from pathlib import Path

from jinja2 import Environment, FileSystemLoader

TEMPLATE_DIR = Path(__file__).resolve().parent.parent / "templates"
FOP_BIN = "fop"  # resolved on PATH inside the container


def render_xslfo_to_pdf(payload: dict) -> bytes:
    """
    payload: a UnifiedPayload dict. Renders the matching .xsl template
    (Jinja-templated XSL-FO) to PDF via Apache FOP, entirely on-prem.
    """
    env = Environment(loader=FileSystemLoader(str(TEMPLATE_DIR)))
    template = env.get_template(f"{payload['letter_type'].lower()}.fo.xsl")
    fo_xml = template.render(**payload)

    with tempfile.TemporaryDirectory() as tmp:
        fo_path = Path(tmp) / "input.fo"
        pdf_path = Path(tmp) / "output.pdf"
        fo_path.write_text(fo_xml, encoding="utf-8")

        result = subprocess.run(
            [FOP_BIN, "-fo", str(fo_path), "-pdf", str(pdf_path)],
            capture_output=True,
            text=True,
            timeout=30,
        )
        if result.returncode != 0:
            raise RuntimeError(f"Apache FOP failed: {result.stderr}")

        return pdf_path.read_bytes()
