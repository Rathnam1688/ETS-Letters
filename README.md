# Next-Gen Document Generation Platform (On-Prem / Air-Gapped)

**New to this repo? Start with [`HANDOFF.md`](./HANDOFF.md)** — full
project context, what's verified vs. just written, the schema
provenance history, and a concrete next-steps list.

Replacement for xPression. Fully open-source, self-hosted, no external API calls.
See `docs/ARCHITECTURE.md` for the full design. This scaffold stubs every
phase from the BRD so each piece can be filled in and tested independently.

## Repo Map → BRD Phases

| Directory | Phase | Purpose |
|---|---|---|
| `infra/` | Phase 1 | Docker Compose (local dev) + K8s manifests (prod) for Milvus, RabbitMQ, vLLM/Ollama, Postgres |
| `mfe-ui/` | Phase 2 | Databricks-styled React Micro-Frontend ("Document Hub" tab) |
| `ai-assistant/rag/` | Phase 3 | Offline ingestion of CMS PDFs/XSDs into the local vector DB |
| `middleware/` | Phase 4 | SQL/XML/JSON → unified payload |
| `queue/` | Phase 3 (FR-03) | Batch splitting, RabbitMQ producer/consumer, Dead Letter Queue |
| `rendering/` | Phase 5 | XSL-FO / HTML rendering engine + barcode generation (FR-04) |
| `ai-assistant/llm_service/` | Phase 5 | Local LLM client (vLLM/Ollama) for the code assistant (FR-06) |
| `visual-qa/` | Phase 5 | AI Pixel-Diff tool (FR-07) |
| `ci-cd/` | All | Pipeline stub for Git-based template workflows (BR-06) |

## Status

Everything here is **stubbed and runnable in isolation** but not wired
end-to-end yet — this is the skeleton described as "repo scaffold for
everything, stubbed." Each module has TODOs marking where real logic
(and your uploaded Knowledge Base content) plugs in.

**Verified so far** (logic tested directly in a sandbox without network
access — `pika`/`barcode`/`qrcode` aren't installable here, so I
decoupled pure logic from those imports so it could still be checked):
- `middleware/data_unification/unify.py` — SQL/XML/JSON merge + precedence, barcode-data derivation, JSON serialization
- `queue/producer.py::split_iwa_batch` — batch → per-letter records
- `queue/consumer.py::on_message` — DLQ routing + ack-on-failure (NFR 5.3 fault isolation), confirmed with a mocked channel

Everything touching `pika`, `python-barcode`, `qrcode`, `pdf417gen`,
Playwright, Apache FOP, Milvus, or a live LLM server is written but
**unexecuted** — those need the real on-prem infra from `infra/` to
actually run. Test files live alongside each module in `tests/`.

## Local Dev Quickstart (once you have Docker/K8s access)

```bash
docker compose -f infra/docker-compose.yml up -d
cd mfe-ui && npm install && npm run dev
cd middleware && pip install -r requirements.txt
```

## Next Steps

1. Upload the KB source docs (CMS guidelines, XSDs) → drop them in
   `ai-assistant/rag/kb_source/` and run `ai-assistant/rag/ingest.py`.
2. Point `middleware/data_unification/` at real SQL/XML/JSON sample payloads.
3. Wire `queue/producer.py` → `queue/consumer.py` → `rendering/engine/` for
   one end-to-end letter.
