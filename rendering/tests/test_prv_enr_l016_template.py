"""
Run with: pytest rendering/tests/ -q

Verifies the real PRV-ENR-L016 template (built from the uploaded DSD/
Query workbook) renders cleanly with every field the DSD specifies.

Layout fidelity: this template is absolutely-positioned at coordinates
measured directly from the legacy sample PDF (pdfplumber extraction —
see the calibration comment at the top of prv_enr_l016.html). Rendered
via the actual production path (rendering/engine/html_renderer.py,
Playwright/Chromium) and diffed against the legacy sample with
visual-qa/pixel_diff.py: 7.21% pixel variance, down from 26.1% before
calibration. Independently-positioned elements (different columns/rows)
matched the legacy PDF to within 0.01pt — the residual ~7% is
concentrated in longer text runs and is a font-substitution effect
(this sandbox has no licensed Times New Roman; Chromium substitutes
Liberation Serif, which is metric-compatible for most but not all
character-width pairs). wkhtmltopdf was tested and rejected for this
template — see html_renderer.py's module docstring for why.
"""
import sys
from pathlib import Path

from jinja2 import Environment, FileSystemLoader

TEMPLATE_DIR = Path(__file__).resolve().parent.parent / "templates"

SAMPLE_FIELDS = {
    "letter_date": "February 11, 2026",
    "provider_name": "CAMELLIA ESCALET",
    "dba_name": "",
    "provider_street": "476 EAST DUNBARTON RD",
    "provider_city": "GOFFSTOWN",
    "provider_state": "NH",
    "provider_zip": "30451",
    "provider_tin_ein": "517993734",
    "provider_npi": "1293056929",
    "provider_license_number": "02048",
    "license_issuer": "Board of Dental Examiners",
    "provider_type": "Dentist, Individual",
    "provider_taxonomy_code": "1223G0001X",
    "contact_name": "OSWALDO SHUKERT",
    "contact_title": "Office Manager",
    "contact_phone": "(603) 833-4942",
    "contact_phone_ext": "",
    "contact_email": "sandysirois@test.com",
    "contact_fax": "(603) 270-0610",
    "bank_name": "Test",
    "bank_street": "7533 NW 176th Ter",
    "bank_city": "Hialeah",
    "bank_state": "Florida",
    "bank_zip": "33105",
    "bank_routing_number": "064774547",
    "bank_account_number": "9552113868",
    "bank_account_type": "Checking Account",
    "bank_phone": "(901) 012-9090",
    "account_linkage": "Provider Tax Identification Number(TIN)",
    "submission_reason": "New Enrollment",
    "authorized_signature": "Written Signature of Person Submitting Enrollment",
}


def render():
    env = Environment(loader=FileSystemLoader(str(TEMPLATE_DIR)))
    template = env.get_template("prv_enr_l016.html")
    return template.render(
        fields=SAMPLE_FIELDS,
        agency_name="New Hampshire Department of Health and Human Services",
        state_seal_path="nh_state_seal.png",
        barcode_svg='<svg width="200" height="50"></svg>',
    )


def test_template_renders_without_error():
    html = render()
    assert len(html) > 1000


def test_all_dsd_fields_present_in_output():
    html = render()
    missing = [v for v in SAMPLE_FIELDS.values() if v and v not in html]
    assert not missing, f"Fields missing from rendered output: {missing}"


def test_barcode_slot_present():
    html = render()
    assert "<svg" in html


def test_letter_id_present():
    html = render()
    assert "PRV-ENR-L016" in html
