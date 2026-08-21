"""
JSON ingest — handles ~15% of source volume per FR-02.
Usually the simplest of the three since it's already close to the
unified payload shape.
"""
from __future__ import annotations

import json
from typing import Any


def parse_json_record(json_blob: str) -> dict[str, Any]:
    """Parse and lightly validate an inbound JSON record."""
    data = json.loads(json_blob)
    return {
        "fields": data.get("fields", {}),
        "recipient": data.get("recipient", {}),
    }
