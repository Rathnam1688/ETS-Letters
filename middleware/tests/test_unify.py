"""
Run with: pytest middleware/tests/ -q
(from the middleware/ directory, since sql_ingest.py etc. use bare imports)
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "data_unification"))

from unify import unify_record  # noqa: E402


def test_unify_merges_all_three_sources():
    payload = unify_record(
        letter_id="LTR-TEST-1",
        letter_type="REMITTANCE_ADVICE",
        sql_key="claim_999",
        xml_blob="<record><field name='amount'>50.00</field></record>",
        json_blob='{"fields": {"provider_npi": "0000000000"}, "recipient": {"member_id": "M111"}}',
    )
    assert payload.letter_id == "LTR-TEST-1"
    assert set(payload.source_systems) == {"sql", "xml", "json"}
    # SQL is highest precedence and should have overwritten recipient.member_id
    assert payload.recipient["member_id"] == "M998877"  # from sql_ingest stub
    assert "amount" in payload.fields
    assert "provider_npi" in payload.fields


def test_unify_handles_missing_sources():
    payload = unify_record(letter_id="LTR-TEST-2", letter_type="REVALIDATION_NOTICE")
    assert payload.source_systems == []
    assert payload.fields == {}


def test_barcode_data_derivation():
    payload = unify_record(
        letter_id="LTR-TEST-3",
        letter_type="REMITTANCE_ADVICE",
        sql_key="claim_1",
    )
    assert payload.barcode_data == "M998877|REMITTANCE_ADVICE"


def test_to_json_serializes():
    payload = unify_record(letter_id="LTR-TEST-4", letter_type="REVALIDATION_NOTICE")
    import json
    parsed = json.loads(payload.to_json())
    assert parsed["letter_id"] == "LTR-TEST-4"
