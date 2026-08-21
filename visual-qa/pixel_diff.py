"""
FR-07: Automated Visual QA.

Overlays a legacy xPression PDF against the new open-source PDF and
highlights exact pixel variances, page by page. Used during Phase 5/6
to validate the migrated templates before cutover.
"""
from __future__ import annotations

from pathlib import Path

import numpy as np
from PIL import Image, ImageChops

try:
    import pypdfium2 as pdfium
    def _render_pdf_pages(pdf_path: str | Path, dpi: int = 200) -> list[Image.Image]:
        pdf = pdfium.PdfDocument(str(pdf_path))
        # 72 points per inch default PDF scale
        scale = dpi / 72.0
        return [page.render(scale=scale).to_pil() for page in pdf]
except ImportError:
    from pdf2image import convert_from_path
    def _render_pdf_pages(pdf_path: str | Path, dpi: int = 200) -> list[Image.Image]:
        return convert_from_path(str(pdf_path), dpi=dpi)


def diff_pdfs(legacy_pdf: str | Path, new_pdf: str | Path, out_dir: str | Path,
               dpi: int = 200, threshold: int = 15) -> list[dict]:
    """
    Renders each PDF page-by-page to images, diffs them, and writes a
    highlighted overlay + a per-page variance summary the MFE's Visual QA
    tab can display.

    Returns a list of {"page": int, "diff_pixel_pct": float, "diff_image": str}
    """
    out_dir = Path(out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    legacy_pages = _render_pdf_pages(legacy_pdf, dpi=dpi)
    new_pages = _render_pdf_pages(new_pdf, dpi=dpi)

    if len(legacy_pages) != len(new_pages):
        raise ValueError(
            f"Page count mismatch: legacy={len(legacy_pages)} new={len(new_pages)}"
        )

    results = []
    for i, (legacy_img, new_img) in enumerate(zip(legacy_pages, new_pages), start=1):
        if legacy_img.size != new_img.size:
            new_img = new_img.resize(legacy_img.size)

        diff = ImageChops.difference(legacy_img.convert("RGB"), new_img.convert("RGB"))
        diff_arr = np.array(diff)
        mask = (diff_arr.max(axis=-1) > threshold)
        diff_pct = 100.0 * mask.sum() / mask.size

        # Build a red-highlight overlay on top of the new render
        overlay = new_img.convert("RGB").copy()
        overlay_arr = np.array(overlay)
        overlay_arr[mask] = [255, 0, 0]
        overlay_img = Image.fromarray(overlay_arr)

        out_path = out_dir / f"page_{i:03d}_diff.png"
        overlay_img.save(out_path)

        results.append({
            "page": i,
            "diff_pixel_pct": round(diff_pct, 4),
            "diff_image": str(out_path),
        })

    return results


if __name__ == "__main__":
    import json
    import sys

    if len(sys.argv) != 4:
        print("Usage: pixel_diff.py <legacy.pdf> <new.pdf> <out_dir>")
        sys.exit(1)

    report = diff_pdfs(sys.argv[1], sys.argv[2], sys.argv[3])
    print(json.dumps(report, indent=2))
