"""
FR-03: Massive Bursting.

Splits a batch job (e.g. 1,000+ letters, triggered by IWA — FR-01) into
individual messages on a local queue (RabbitMQ) so rendering workers can
process them in parallel.
"""
from __future__ import annotations

import json
import sys
import os
from typing import Iterable

QUEUE_HOST = os.environ.get("QUEUE_HOST", "localhost")
QUEUE_USER = os.environ.get("QUEUE_USER", "platform")
QUEUE_PASS = os.environ.get("QUEUE_PASS", "changeme")
QUEUE_NAME = "render-jobs"


def get_channel():
    # Imported lazily so split_iwa_batch() (pure logic, no I/O) can be
    # unit-tested without the pika dependency / a live broker present.
    import pika

    creds = pika.PlainCredentials(QUEUE_USER, QUEUE_PASS)
    connection = pika.BlockingConnection(pika.ConnectionParameters(host=QUEUE_HOST, credentials=creds))
    channel = connection.channel()
    # durable=True so jobs survive a broker restart mid-batch
    channel.queue_declare(queue=QUEUE_NAME, durable=True)
    return channel


def publish_batch(letter_records: Iterable[dict], channel=None) -> int:
    """
    Publish one message per letter. Each message is a UnifiedPayload
    (see middleware/data_unification/unify.py) plus a batch_id for
    tracking in the MFE's "Job Runs" tab.
    """
    import pika

    own_channel = channel is None
    if own_channel:
        channel = get_channel()

    count = 0
    for record in letter_records:
        channel.basic_publish(
            exchange="",
            routing_key=QUEUE_NAME,
            body=json.dumps(record),
            properties=pika.BasicProperties(delivery_mode=2),  # persistent
        )
        count += 1

    if own_channel and channel.connection and channel.connection.is_open:
        channel.connection.close()

    return count


def split_iwa_batch(iwa_batch_payload: dict) -> list[dict]:
    """
    IWA (FR-01) hands off one big batch descriptor. This breaks it into
    per-letter records ready for publish_batch().

    TODO: replace with the real IWA payload contract once available.
    """
    batch_id = iwa_batch_payload["batch_id"]
    return [
        {**letter, "batch_id": batch_id}
        for letter in iwa_batch_payload.get("letters", [])
    ]


if __name__ == "__main__":
    # Smoke test with a fake 3-letter batch
    fake_batch = {
        "batch_id": "BATCH-2026-08-09-001",
        "letters": [
            {"letter_id": f"LTR-{i:04d}", "letter_type": "REMITTANCE_ADVICE"}
            for i in range(3)
        ],
    }
    records = split_iwa_batch(fake_batch)
    print(f"Split into {len(records)} records. Publishing requires a live RabbitMQ (see infra/docker-compose.yml).")
