"""
FR-02: Data Unification Layer.

Ingests mixed sources (~70% relational SQL, 15% XML, 15% JSON) and flattens
them into a single unified payload (JSON) per letter, ready for the
rendering engine.

This is a stub: each `*_ingest.py` returns a normalized dict. Wire the
real connection strings / schemas once the sample source systems are
identified.
"""
from __future__ import annotations

import json
from dataclasses import dataclass, field
from typing import Any

from sql_ingest import fetch_sql_record
from xml_ingest import parse_xml_record
from json_ingest import parse_json_record


@dataclass
class UnifiedPayload:
    """The single normalized shape every renderer / template expects."""
    letter_id: str
    letter_type: str
    recipient: dict[str, Any] = field(default_factory=dict)
    fields: dict[str, Any] = field(default_factory=dict)
    barcode_data: str | None = None
    source_systems: list[str] = field(default_factory=list)

    def to_json(self) -> str:
        return json.dumps(self.__dict__, default=str)


def unify_record(letter_id: str, letter_type: str, sql_key: str | None = None,
                  xml_blob: str | None = None, json_blob: str | None = None) -> UnifiedPayload:
    """
    Merge whichever sources are present for a given letter into one
    UnifiedPayload. Precedence on field collisions: SQL > XML > JSON
    (adjust per real business rules once known).
    """
    payload = UnifiedPayload(letter_id=letter_id, letter_type=letter_type)

    if json_blob:
        data = parse_json_record(json_blob)
        payload.fields.update(data.get("fields", {}))
        payload.recipient.update(data.get("recipient", {}))
        payload.source_systems.append("json")

    if xml_blob:
        data = parse_xml_record(xml_blob)
        payload.fields.update(data.get("fields", {}))
        payload.recipient.update(data.get("recipient", {}))
        payload.source_systems.append("xml")

    if sql_key:
        data = fetch_sql_record(sql_key)
        payload.fields.update(data.get("fields", {}))
        payload.recipient.update(data.get("recipient", {}))
        payload.source_systems.append("sql")

    # FR-04: barcode payload is derived, not stored — e.g. member ID + letter type
    payload.barcode_data = f"{payload.recipient.get('member_id', '')}|{letter_type}"

    return payload


if __name__ == "__main__":
    # Smoke test with fake inputs
    result = unify_record(
        letter_id="LTR-0001",
        letter_type="REMITTANCE_ADVICE",
        sql_key="claim_12345",
        xml_blob="<record><field name='amount'>102.50</field></record>",
        json_blob='{"fields": {"provider_npi": "1234567890"}, "recipient": {"member_id": "M998877"}}',
    )
    print(result.to_json())
