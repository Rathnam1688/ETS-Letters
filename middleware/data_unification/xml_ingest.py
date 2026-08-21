"""
XML ingest — handles ~15% of source volume per FR-02.
Uses stdlib xml.etree; swap for lxml + real XSD validation once the
schema is uploaded to the Knowledge Base (FR-05) so the AI assistant
and this parser can share the same source of truth.
"""
from __future__ import annotations

import xml.etree.ElementTree as ET
from typing import Any


def parse_xml_record(xml_blob: str) -> dict[str, Any]:
    """
    Parse a <record><field name="...">value</field>...</record> style
    payload into {"fields": {...}, "recipient": {...}}.

    TODO: once real XSDs are uploaded, validate against them here
    (e.g. with xmlschema) before returning, and raise a clear error the
    UI's Job Runs tab can surface.
    """
    root = ET.fromstring(xml_blob)
    fields: dict[str, Any] = {}
    recipient: dict[str, Any] = {}

    for field in root.findall("field"):
        name = field.get("name", "")
        value = field.text or ""
        if name.startswith("recipient_"):
            recipient[name.removeprefix("recipient_")] = value
        else:
            fields[name] = value

    return {"fields": fields, "recipient": recipient}
