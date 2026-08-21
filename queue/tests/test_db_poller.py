"""
Run with: pytest queue/tests/ -q

Proves the DB-trigger logic actually works with a mocked cursor,
same approach as test_consumer.py's DLQ verification — not just
written-and-trusted.
"""
import sys
from pathlib import Path
from unittest.mock import MagicMock

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

import db_poller  # noqa: E402


def test_poll_finds_pending_records():
    fake_cursor = MagicMock()
    fake_cursor.fetchall.return_value = [(1001,), (1002,), (1003,)]

    result = db_poller.poll_ready_records(fake_cursor, "PRV-MNT-L001")

    assert result.record_count == 3
    assert result.record_ids == [1001, 1002, 1003]
    fake_cursor.execute.assert_called_once()
    args, kwargs = fake_cursor.execute.call_args
    assert kwargs["parameters"] if "parameters" in kwargs else args[1] == {"letter_type": "PRV-MNT-L001"}


def test_poll_and_enqueue_publishes_found_records():
    fake_cursor = MagicMock()
    fake_cursor.fetchall.return_value = [(2001,), (2002,)]
    fake_publish = MagicMock(return_value=2)

    result = db_poller.poll_and_enqueue(fake_cursor, "PRV-MNT-L001", fake_publish)

    assert result.record_count == 2
    fake_publish.assert_called_once()
    (published_records,), _ = fake_publish.call_args
    assert len(published_records) == 2
    assert published_records[0]["letter_type"] == "PRV-MNT-L001"
    assert published_records[0]["g_cots_ltr_req_sk"] == 2001


def test_poll_and_enqueue_skips_publish_when_nothing_pending():
    fake_cursor = MagicMock()
    fake_cursor.fetchall.return_value = []
    fake_publish = MagicMock()

    result = db_poller.poll_and_enqueue(fake_cursor, "PRV-ENR-L016", fake_publish)

    assert result.record_count == 0
    fake_publish.assert_not_called()


def test_run_poll_cycle_continues_after_one_letter_type_fails():
    fake_cursor = MagicMock()
    # First call raises, rest succeed with no pending records
    fake_cursor.execute.side_effect = [RuntimeError("boom"), None, None, None]
    fake_cursor.fetchall.return_value = []
    fake_publish = MagicMock()

    results = db_poller.run_poll_cycle(fake_cursor, fake_publish)

    # One letter type failed and was skipped from results; the rest completed
    assert len(results) == len(db_poller.MONITORED_LETTER_TYPES) - 1
