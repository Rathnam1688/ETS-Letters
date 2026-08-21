"""
Rendering worker consumer.

NFR 5.3 (Fault Isolation): if a single letter fails, drop it into the
Dead Letter Queue and keep processing the rest of the batch — never
crash the parent IWA job.
"""
from __future__ import annotations

import json
import logging
import os

QUEUE_HOST = os.environ.get("QUEUE_HOST", "localhost")
QUEUE_USER = os.environ.get("QUEUE_USER", "platform")
QUEUE_PASS = os.environ.get("QUEUE_PASS", "changeme")
QUEUE_NAME = "render-jobs"
DLQ_NAME = "render-jobs-dlq"

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("rendering-worker")


def render_one(payload: dict) -> bytes:
    """
    Render a single unified payload to PDF.
    TODO: call into rendering/engine/ (XSL-FO or HTML/CSS) here.
    """
    from rendering.engine.html_renderer import render_html_to_pdf  # local import to avoid hard dep at import time

    return render_html_to_pdf(payload)


def on_message(channel, method, properties, body):
    payload = json.loads(body)
    letter_id = payload.get("letter_id", "unknown")
    try:
        pdf_bytes = render_one(payload)
        # TODO: write pdf_bytes to output storage / stream back to IWA
        logger.info("Rendered %s (%d bytes)", letter_id, len(pdf_bytes))
        channel.basic_ack(delivery_tag=method.delivery_tag)
    except Exception:
        logger.exception("Render failed for %s — routing to DLQ", letter_id)
        channel.basic_publish(exchange="", routing_key=DLQ_NAME, body=body)
        # ack the original so it's removed from the main queue (it's preserved in the DLQ)
        channel.basic_ack(delivery_tag=method.delivery_tag)


def main():
    import pika  # lazy: keeps on_message() testable without pika installed

    creds = pika.PlainCredentials(QUEUE_USER, QUEUE_PASS)
    connection = pika.BlockingConnection(pika.ConnectionParameters(host=QUEUE_HOST, credentials=creds))
    channel = connection.channel()
    channel.queue_declare(queue=QUEUE_NAME, durable=True)
    channel.queue_declare(queue=DLQ_NAME, durable=True)
    channel.basic_qos(prefetch_count=1)
    channel.basic_consume(queue=QUEUE_NAME, on_message_callback=on_message)

    logger.info("Rendering worker started. Waiting for jobs on '%s'...", QUEUE_NAME)
    channel.start_consuming()


if __name__ == "__main__":
    main()
