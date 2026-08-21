"""
Run with: pytest rendering/tests/ -q
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent.parent))

from rendering.barcode.barcode_generator import generate_barcode_svg  # noqa: E402


def test_code128_produces_svg():
    svg = generate_barcode_svg("M998877|REMITTANCE_ADVICE", symbology="code128")
    assert svg.strip().startswith("<?xml") or "<svg" in svg


def test_qr_produces_svg():
    svg = generate_barcode_svg("M998877", symbology="qr")
    assert "<svg" in svg


def test_unsupported_symbology_raises():
    import pytest
    with pytest.raises(ValueError):
        generate_barcode_svg("data", symbology="aztec")
