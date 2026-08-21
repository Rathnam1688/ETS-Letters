"""
Run with: pytest queue/tests/ -q

Verifies NFR 5.3 (Fault Isolation): a failed single-letter render must
route to the DLQ and ack the original message, without raising and
without crashing the consumer loop.
"""
import json
import sys
from pathlib import Path
from unittest.mock import MagicMock

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

import consumer  # noqa: E402


def test_failed_render_routes_to_dlq_and_acks(monkeypatch):
    monkeypatch.setattr(consumer, "render_one", MagicMock(side_effect=RuntimeError("boom")))

    fake_channel = MagicMock()
    fake_method = MagicMock(delivery_tag=42)
    body = json.dumps({"letter_id": "LTR-BAD", "letter_type": "UNKNOWN"}).encode()

    consumer.on_message(fake_channel, fake_method, None, body)

    fake_channel.basic_publish.assert_called_once()
    _, kwargs = fake_channel.basic_publish.call_args
    assert kwargs["routing_key"] == consumer.DLQ_NAME
    fake_channel.basic_ack.assert_called_once_with(delivery_tag=42)


def test_successful_render_acks_without_dlq(monkeypatch):
    monkeypatch.setattr(consumer, "render_one", MagicMock(return_value=b"%PDF-fake"))

    fake_channel = MagicMock()
    fake_method = MagicMock(delivery_tag=7)
    body = json.dumps({"letter_id": "LTR-OK", "letter_type": "REMITTANCE_ADVICE"}).encode()

    consumer.on_message(fake_channel, fake_method, None, body)

    fake_channel.basic_publish.assert_not_called()
    fake_channel.basic_ack.assert_called_once_with(delivery_tag=7)
