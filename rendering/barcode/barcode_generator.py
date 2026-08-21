"""
FR-04: Barcode Generation.

Dynamically generates optical-scanner-compliant SVG barcodes from raw
data strings, entirely locally (no external barcode API calls).

Symbologies: Code 39, Code 128, QR, PDF417.
Libraries: `python-barcode` (Code39/Code128), `qrcode` (QR),
`pdf417gen` (PDF417) — all pure-Python / no network dependency.
"""
from __future__ import annotations

import io

SUPPORTED = {"code39", "code128", "qr", "pdf417"}


def generate_barcode_svg(data: str, symbology: str = "code128") -> str:
    """Return an SVG string for the requested symbology."""
    symbology = symbology.lower()
    if symbology not in SUPPORTED:
        raise ValueError(f"Unsupported symbology '{symbology}'. Must be one of {SUPPORTED}")

    if symbology in ("code39", "code128"):
        return _linear_barcode_svg(data, symbology)
    if symbology == "qr":
        return _qr_svg(data)
    if symbology == "pdf417":
        return _pdf417_svg(data)


def _linear_barcode_svg(data: str, symbology: str) -> str:
    import barcode
    from barcode.writer import SVGWriter

    writer_options = {
        "module_height": 15.0,   # mm — tuned for optical scanner read rates
        "quiet_zone": 6.5,       # required silent margin per spec
        "write_text": False,     # CMS forms render human-readable text separately
    }
    cls = barcode.get_barcode_class(symbology)
    buf = io.BytesIO()
    cls(data, writer=SVGWriter()).write(buf, options=writer_options)
    return buf.getvalue().decode("utf-8")


def _qr_svg(data: str) -> str:
    import qrcode
    import qrcode.image.svg

    factory = qrcode.image.svg.SvgImage
    img = qrcode.make(data, image_factory=factory, box_size=10, border=4)
    buf = io.BytesIO()
    img.save(buf)
    return buf.getvalue().decode("utf-8")


def _pdf417_svg(data: str) -> str:
    """
    pdf417gen produces a bitmap; wrap it as an embedded SVG <image> so the
    output stays vector-container-compatible with the rest of the pipeline.
    TODO: swap for a native vector PDF417 encoder if scanner testing
    (Phase 6 load testing) shows the raster embed hurts read rates.
    """
    import base64

    from pdf417gen import encode, render_image

    # Use 4 columns by default; fallback to smaller if needed
    for cols in (4, 3, 2):
        try:
            codes = encode(data, columns=cols)
            break
        except ValueError:
            continue
    else:
        codes = encode(data, columns=2)

    image = render_image(codes, scale=3, ratio=3)
    buf = io.BytesIO()
    image.save(buf, format="PNG")
    b64 = base64.b64encode(buf.getvalue()).decode("ascii")
    width, height = image.size
    return (
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}">'
        f'<image width="{width}" height="{height}" xlink:href="data:image/png;base64,{b64}"/>'
        f"</svg>"
    )
