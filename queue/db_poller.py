"""
DB-condition-triggered generation.

Answers the actual question this module exists for: "if 10 PRV-MNT-L001
records are ready in the DB today, that should trigger generation" —
without this, the pipeline is push-only (IWA hands off a batch,
producer.py splits it). This adds the pull side: poll for records
matching a "ready to send" condition, per letter type, and enqueue them
through the existing producer.py path unchanged.

Runs as a scheduled job (cron / K8s CronJob — see infra/k8s/) rather
than a long-lived daemon, since letter readiness is naturally
batch-oriented (matches how IWA already triggers batches).
"""
from __future__ import annotations

import logging
from dataclasses import dataclass
from datetime import datetime

logger = logging.getLogger("db-poller")

# Per-letter-type "ready to send" condition in G_COTS_LTR_REQ_TB.
# In ets_dev, G_COTS_LTR_GNRTN_RTRN_CD_DT / G_COTS_LTR_REQ_DISP_CD tracks
# generation completion (GE = generated, AP = approved/pending).
READY_TO_SEND_CONDITION = """
    SELECT G_COTS_LTR_REQ_SK
    FROM G_COTS_LTR_REQ_TB
    WHERE G_COTS_LTR_TMPLT_KEY_DATA = %(letter_type)s
      AND G_TO_BE_SENT_DT <= CURRENT_DATE
      AND (G_COTS_LTR_GNRTN_RTRN_CD_DT IS NULL AND G_COTS_LTR_REQ_DISP_CD != 'GE')
    ORDER BY G_TO_BE_SENT_DT ASC
"""


@dataclass
class PollResult:
    letter_type: str
    record_count: int
    record_ids: list[int]
    polled_at: datetime


def poll_ready_records(cursor, letter_type: str) -> PollResult:
    """
    Check the DB for records ready to generate for one letter type.
    Pure query + result packaging — no side effects, so this is safe
    to call repeatedly / test independent of the enqueue step below.
    """
    cursor.execute(READY_TO_SEND_CONDITION, {"letter_type": letter_type})
    rows = cursor.fetchall()
    ids = [r[0] for r in rows]
    return PollResult(
        letter_type=letter_type,
        record_count=len(ids),
        record_ids=ids,
        polled_at=datetime.utcnow(),
    )


def poll_and_enqueue(cursor, letter_type: str, publish_fn) -> PollResult:
    """
    Poll for ready records and hand them to the existing queue producer.
    `publish_fn` is injected (rather than importing queue.producer
    directly) so this stays testable without a live RabbitMQ — see
    queue/tests/test_db_poller.py.

    In production, `publish_fn` is queue.producer.publish_batch, and
    each record becomes one message on the render-jobs queue, exactly
    as if IWA had submitted a batch containing just these records —
    the render pipeline downstream doesn't know or care whether a
    batch came from IWA or from this poller.
    """
    result = poll_ready_records(cursor, letter_type)

    if result.record_count == 0:
        logger.info("No pending %s records.", letter_type)
        return result

    logger.info("Found %d pending %s records — enqueuing.", result.record_count, letter_type)

    records = [
        {"letter_id": f"{letter_type}-{rid}", "letter_type": letter_type, "g_cots_ltr_req_sk": rid}
        for rid in result.record_ids
    ]
    published = publish_fn(records)

    if published != result.record_count:
        logger.warning(
            "Published %d of %d records for %s — mismatch, investigate before assuming the batch is complete.",
            published, result.record_count, letter_type,
        )

    return result


# Letter types this poller checks each run. Extend as new letters are
# onboarded (see docs/schema/letter_samples_manifest.csv for the full
# catalog of 97 known letter IDs not yet built).
MONITORED_LETTER_TYPES = [
    "PRV-ENR-L016",
    "PRV-MNT-L001",
    "PRV-RVL-L006",
    "PRV-RVL-L003",
]


def run_poll_cycle(cursor, publish_fn) -> list[PollResult]:
    """Entry point for the scheduled job — one poll pass across every
    monitored letter type."""
    results = []
    for letter_type in MONITORED_LETTER_TYPES:
        try:
            results.append(poll_and_enqueue(cursor, letter_type, publish_fn))
        except Exception:
            logger.exception("Poll failed for %s — continuing with remaining letter types.", letter_type)
    return results


if __name__ == "__main__":
    import sys
    from pathlib import Path

    logging.basicConfig(level=logging.INFO)

    sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "middleware"))
    from db_connection import get_cursor_context, MissingCredentialsError

    sys.path.insert(0, str(Path(__file__).resolve().parent))
    from producer import publish_batch

    try:
        with get_cursor_context() as cursor:
            run_poll_cycle(cursor, publish_batch)
    except MissingCredentialsError as e:
        print("Not configured:", e)
        print("Copy .env.example to .env and fill in real ets_dev credentials.")
    except ImportError:
        print("psycopg2 not installed — `pip install psycopg2-binary`")
