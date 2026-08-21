# Visual QA Results — PRV-ENR-L016

`PRV-ENR-L016_diff_overlay.png` — pixel-diff output from
`visual-qa/pixel_diff.py`, comparing the legacy sample PDF against
`rendering/templates/prv_enr_l016.html` rendered through the real
production path (`rendering/engine/html_renderer.py`, Playwright).

**Result: 7.21% pixel variance** (down from 26.1% before the template
was recalibrated to exact PDF-measured coordinates — see the
calibration comment at the top of `prv_enr_l016.html`).

Red areas in the overlay are the actual remaining differences:
mostly longer text runs, traced to font substitution (this sandbox
has no licensed Times New Roman; Chromium substitutes Liberation
Serif — metric-compatible for most but not all character pairs).
Independently-positioned elements (separate columns/rows) matched the
legacy PDF to within 0.01pt in testing, confirming the coordinate
calibration itself is correct — the residual is a font-rendering
environment limitation, not a layout error.

**Likely next step to close most of the remaining gap:** render in an
environment with a licensed Times New Roman font installed (e.g. the
actual production server, if it has Microsoft core fonts available)
rather than relying on Chromium's Liberation Serif substitution.
