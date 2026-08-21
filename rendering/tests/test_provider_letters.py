"""
Run with: pytest rendering/tests/ -q

Covers PRV-MNT-L001, PRV-RVL-L006, PRV-RVL-L003 — the three
Provider-domain prose letters sharing _provider_letter_header.html /
_provider_letter_styles.html. Verified by rendering with sample data
matching each legacy PDF's own visible sample record, then visually
spot-checked against the legacy PDFs (see docs/ARCHITECTURE.md) —
not yet run against a real database (same status as PRV-ENR-L016's
FIELD_QUERIES; see docs/PENDING.md).
"""
from pathlib import Path

from jinja2 import Environment, FileSystemLoader

TEMPLATE_DIR = Path(__file__).resolve().parent.parent / "templates"

LETTERHEAD = {
    "division_name": "DIVISION OF MEDICAID SERVICES",
    "commissioner_name": "Lori A. Weaver",
    "medicaid_director_name": "Henry D. Lipman",
    "director_title": "Director",
    "agency_address_line1": "129 PLEASANT STREET, CONCORD, NH 03301",
    "toll_free_number": "1-844-ASK-DHHS (1-844-275-3447)",
    "fax_label_and_number": "Fax: 603-271-8431   TDD Access:1-800-735-2964",
    "website_address": "www.dhhs.nh.gov",
}


def _env():
    return Environment(loader=FileSystemLoader(str(TEMPLATE_DIR)))


def test_mnt_l001_renders_with_all_fields():
    fields = {
        "letter_date": "January 5, 2026", "letter_date_short": "01/05/2026",
        "provider_name": "CONDUENTGROUPNEW", "provider_address_line1": "30 GREENVIEW DR",
        "provider_address_line2": "APT 39", "provider_address_city": "MANCHESTER",
        "provider_address_state": "NH", "provider_address_zip": "03102-8912",
        "provider_id": "3129775", "license_expiration_date": "10/30/2025",
    }
    html = _env().get_template("prv_mnt_l001.html").render(
        fields=fields, letterhead=LETTERHEAD,
        state_seal_path="nh_state_seal.png", barcode_svg="<svg></svg>",
    )
    assert len(html) > 1000
    for v in fields.values():
        assert v in html
    assert "PRV-MNT-L001" in html
    assert "30-Day Recertification Notice" in html


def test_rvl_l006_renders_with_all_fields():
    fields = {
        "letter_date": "July 22, 2025", "letter_date_short": "07/22/2025",
        "provider_name": "JAMES S. FISHBEIN DDS", "provider_address_line1": "3570 LAFAYETTE RD",
        "provider_address_line2": "3570 LAFAYETTE RD", "provider_address_city": "PORTSMOUTH",
        "provider_address_state": "NH", "provider_address_zip": "3801-5615",
        "nh_medicaid_provider_id": "3004413",
    }
    shared = {
        "prov_rel_operation_hours": "8:00 a.m. to 5:00 p.m.",
        "provider_relations_number": "(603) 223-4774",
        "provider_relations_tollfree": "(866) 291-1674",
    }
    html = _env().get_template("prv_rvl_l006.html").render(
        fields=fields, shared=shared, letterhead=LETTERHEAD,
        state_seal_path="nh_state_seal.png", barcode_svg="<svg></svg>",
    )
    assert len(html) > 1000
    for v in fields.values():
        assert v in html
    assert "PROVIDER REVALIDATION RECEIVED" in html
    assert "PRV-RVL-L006" in html


def test_rvl_l003_renders_with_all_fields_and_three_pages_worth_of_content():
    fields = {
        "letter_date": "November 5, 2024", "letter_date_short": "11/05/2024",
        "provider_name": "EUGENIA E CORBISIERO D.V", "provider_address_line1": "54 WEST SHORE RD",
        "provider_address_line2": "54 WEST SHORE RD", "provider_address_city": "MARLOW",
        "provider_address_state": "NH", "provider_address_zip": "3456-5642",
        "nh_medicaid_provider_id": "3328740", "revalidation_due_date": "02/01/2025",
    }
    shared = {
        "provider_appeals_unit": "DHHS Administrative Appeals Unit",
        "prov_appeals_addr_line1": "105 Pleasant St", "prov_appeals_addr_line2": "Concord, NH 03301",
        "prov_appeals_number": "(603) 271-4292 Ext. 14292",
        "prov_rel_fax_number": "866-446-3318", "provider_relations_email": "NHProviderRelations@conduent.com",
        "prov_rel_operation_hours": "8:00 a.m. to 5:00 p.m.", "provider_relations_number": "(603) 223-4774",
        "provider_relations_tollfree": "(866) 291-1674",
    }
    html = _env().get_template("prv_rvl_l003.html").render(
        fields=fields, shared=shared, letterhead=LETTERHEAD,
        state_seal_path="nh_state_seal.png", barcode_svg="<svg></svg>",
    )
    assert len(html) > 2000
    for v in fields.values():
        assert v in html
    assert "PROVIDER REVALIDATION FINAL NOTICE" in html
    assert "Page 2" in html  # continuation page header
    assert "PRV-RVL-L003" in html


def test_shared_header_include_resolves():
    """Confirms _provider_letter_header.html is found via the shared
    FileSystemLoader — would raise TemplateNotFound otherwise."""
    html = _env().get_template("prv_rvl_l006.html").render(
        fields={"provider_name": "X", "provider_address_line1": "Y",
                "provider_address_city": "Z", "provider_address_state": "NH",
                "provider_address_zip": "00000", "letter_date": "d",
                "nh_medicaid_provider_id": "1"},
        shared={"prov_rel_operation_hours": "h", "provider_relations_number": "n",
                "provider_relations_tollfree": "t"},
        letterhead=LETTERHEAD, state_seal_path="nh_state_seal.png", barcode_svg="",
    )
    assert "STATE OF NEW HAMPSHIRE" in html
    assert LETTERHEAD["commissioner_name"] in html
