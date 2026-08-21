"""
Relational SQL ingest — handles ~70% of source volume per FR-02.
Stub uses SQLAlchemy conventions; swap the connection string / query
for the real claims/eligibility DB once known.
"""
from __future__ import annotations

from typing import Any

# TODO: replace with real engine, e.g.
# from sqlalchemy import create_engine, text
# ENGINE = create_engine(os.environ["CLAIMS_DB_URL"])


def fetch_sql_record(record_key: str) -> dict[str, Any]:
    """
    Fetch one record by key from the relational source and normalize it
    into {"fields": {...}, "recipient": {...}}.

    TODO: replace with a real query, e.g.:
        with ENGINE.connect() as conn:
            row = conn.execute(
                text("SELECT * FROM claims WHERE claim_id = :k"),
                {"k": record_key},
            ).mappings().first()
    """
    # --- stub data so the pipeline is runnable end-to-end today ---
    return {
        "fields": {
            "claim_id": record_key,
            "billed_amount": 250.00,
            "paid_amount": 187.50,
            "service_date": "2026-06-01",
        },
        "recipient": {
            "member_id": "M998877",
            "name": "Jane Q. Sample",
            "address_line1": "123 Main St",
            "city": "Springfield",
            "state": "IL",
            "zip": "62704",
        },
    }
