"""
Backing logic for the "Generate Letters" UI page — the missing 4th
page identified alongside the existing Workspace/Knowledge
Base/Job Runs/Visual QA pages. Plain functions, no FastAPI import, so
this is testable without the framework installed (not available in
this sandbox — no network access; see api/README.md).
"""
from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path

import sys

# NOTE: the "queue" directory name collides with Python's stdlib
# `queue` module — `from queue.db_poller import ...` resolves to the
# stdlib module and fails. Add the directory itself to sys.path and
# import the submodule directly instead, same pattern already used by
# queue/tests/test_consumer.py and test_producer.py.
_QUEUE_DIR = Path(__file__).resolve().parent.parent.parent / "queue"
sys.path.insert(0, str(_QUEUE_DIR))
from db_poller import MONITORED_LETTER_TYPES, poll_ready_records, poll_and_enqueue  # noqa: E402


@dataclass
class LetterTypeInfo:
    letter_type: str
    label: str
    pending_count: int = 0
    last_generated: str | None = None


# Human-readable labels — kept separate from MONITORED_LETTER_TYPES
# (queue/db_poller.py) so the UI layer can have display names without
# the poller needing to know about them.
LETTER_LABELS = {
    "PRV-ENR-L016": "EFT Enrollment Application",
    "PRV-MNT-L001": "30-Day Recertification Notice",
    "PRV-RVL-L006": "Provider Revalidation Received",
    "PRV-RVL-L003": "Provider Revalidation Final Notice",
}


def list_letter_types(cursor=None) -> list[LetterTypeInfo]:
    """
    List every onboarded letter type with its current pending count.
    If `cursor` is None (no live DB — the case in this sandbox), pending
    counts come back as 0 rather than raising, so the UI page can still
    render the catalog without a database connection.
    """
    results = []
    for letter_type in MONITORED_LETTER_TYPES:
        pending = 0
        if cursor is not None:
            poll_result = poll_ready_records(cursor, letter_type)
            pending = poll_result.record_count
        results.append(LetterTypeInfo(
            letter_type=letter_type,
            label=LETTER_LABELS.get(letter_type, letter_type),
            pending_count=pending,
        ))
    return results


def trigger_generation(cursor, letter_type: str, publish_fn) -> dict:
    """
    Manual "Generate now" trigger from the UI — same underlying path as
    the scheduled db_poller CronJob (queue/db_poller.py), just invoked
    on demand instead of on a timer. Returns a JSON-serializable dict
    (not a dataclass) since this is the direct response shape for the
    POST /letters/{type}/generate endpoint.
    """
    if letter_type not in MONITORED_LETTER_TYPES:
        raise ValueError(f"Unknown letter type '{letter_type}'. Known: {MONITORED_LETTER_TYPES}")

    result = poll_and_enqueue(cursor, letter_type, publish_fn)
    return {
        "letter_type": result.letter_type,
        "records_found": result.record_count,
        "record_ids": result.record_ids,
        "polled_at": result.polled_at.isoformat(),
    }
