# Handoff — Document Generation Platform

**Read this file first.** It's the entry point for picking up this
project cold, without the conversation history that produced it.
Everything referenced below is in this repo — nothing lives only in
chat.

## 1. What this project is

Replacing a legacy proprietary tool (xPression) with an on-prem,
open-source document generation platform for a state Medicaid MMIS
system (batch letter generation — CMS/healthcare compliance forms,
triggered by IBM Workload Automation). Full requirements: none of the
original BRD text was saved verbatim into this repo — if you need the
formal BRD (business/functional requirements, NFRs, tech stack
mandate), ask the user for it; this repo is the implementation that
resulted from it. The short version, inferred from what's built:

- **On-prem / air-gapped.** No external APIs, no public cloud LLMs, no
  data leaves the org perimeter. Self-hosted LLM inference (Ollama/
  vLLM), self-hosted vector DB (originally Milvus; see §4 re: Postgres/
  pgvector option).
- **Databricks-styled Micro-Frontend** ("Document Hub" tab) — pluggable
  into any host portal via Webpack Module Federation.
- **RAG-grounded AI template assistant** — drafts/edits XSL-FO or
  HTML/CSS templates, grounded in a local knowledge base of CMS/state
  design-spec documents to avoid hallucinated layout rules.
- **Batch rendering pipeline** — IWA triggers → split into per-letter
  jobs on RabbitMQ/Kafka → horizontally-scaled stateless rendering
  workers → Dead Letter Queue on per-letter failure (never crash the
  parent batch).
- **Pixel-perfect compliance** — barcode generation (Code39/128/QR/
  PDF417), AI-assisted visual QA (pixel-diff vs. legacy output).

## 2. Repo map

```
infra/               Phase 1 — docker-compose (local dev) + K8s manifests (prod) + db-poller CronJob
mfe-ui/               Phase 2 — React/Tailwind Databricks-style MFE shell (5 pages: Generate/Workspace/Knowledge/Jobs/QA)
api/                   Backend for the MFE — FastAPI, thin wiring over tested services/ (see §3, §8)
ai-assistant/rag/     Phase 3 — RAG ingestion + retriever + kb_source/ (real docs, see §5)
middleware/           Phase 4 — SQL/XML/JSON → unified payload; letters/ has 4 real per-letter modules; shared/ has cross-letter agency params
queue/                Phase 3 — batch producer, DLQ-aware consumer, db_poller (DB-condition trigger, see §8)
rendering/            Phase 5 — XSL-FO (Apache FOP) + HTML (Playwright) engines, barcode gen, templates (4 real letters)
ai-assistant/         Phase 5 — local LLM client (Ollama/vLLM), RAG-grounded code assistant
visual-qa/            Phase 5 — AI pixel-diff tool + baselines/ (4 real legacy PDFs)
ci-cd/                Pipeline stub (Git-based template workflow)
docs/
  ARCHITECTURE.md      Data-flow diagrams, design rationale, full upload provenance history
  PENDING.md            Live checklist — what's blocked on the user vs. next-up here
  schema/ets_dev/        THE target DB schema (see §4 — read this before touching any SQL)
  schema/letter_samples_manifest.csv   97 other letter IDs catalogued, not yet built
```

Also present but not yet wired anywhere: a standalone live-preview
React artifact of the MFE shell was generated during development
(`document-hub-preview.jsx`, delivered separately in chat, not part of
this zip) — cosmetic reference only, `mfe-ui/src/` is the real source.

## 3. Status per module — what's actually verified vs. just written

**This sandbox has no network access**, so packages not already
installed couldn't be added (`pika`, `python-barcode`, `qrcode`,
`pdf417gen`, `pytest`, `psycopg2`, `sqlglot`), no live database or
message broker was reachable, and a `.7z` archive (`ddl.7z`) still
couldn't be opened. One correction to an earlier version of this
table: **Playwright turned out to already be available** here (Python
package plus a cached Chromium binary from Playwright's own cache) —
it was wrongly marked untested before simply because nobody checked.
Below is exactly what was and wasn't exercised — don't assume
"written" means "tested," and don't assume this table is exhaustively
re-verified either; re-check anything load-bearing.

| Module | Status |
|---|---|
| `middleware/data_unification/unify.py` | **Ran directly**, output inspected — SQL/XML/JSON merge, precedence, barcode-data derivation, JSON serialization all correct |
| `queue/producer.py::split_iwa_batch` | **Ran directly** — pure logic, no broker needed |
| `queue/consumer.py::on_message` | **Ran directly with a mocked pika channel** — confirmed DLQ routing + ack-on-failure (fault isolation) actually works, not just written |
| `rendering/templates/prv_enr_l016.html` + `rendering/engine/html_renderer.py` | **Ran end-to-end through the actual production function**, output diffed against the legacy sample with `visual-qa/pixel_diff.py`: **7.21% pixel variance** (down from 26.1% before the template was recalibrated to exact PDF-measured coordinates). Two real bugs in `html_renderer.py` were caught only by actually running it and are now fixed: (1) it looked up templates as `prv-enr-l016.html` (hyphens) when the file is `prv_enr_l016.html` (underscores) — always would have thrown `TemplateNotFound`; (2) it called `page.set_content(..., base_url=...)`, a parameter that doesn't exist on this Playwright version's `set_content` — always would have thrown `TypeError`. Neither bug was hit before because the function had never been executed. wkhtmltopdf was tried first for this template and rejected — see the module's docstring for why |
| `rendering/barcode/barcode_generator.py` | Written, **not run** — `python-barcode`/`qrcode`/`pdf417gen` not installed here |
| `rendering/engine/xslfo_renderer.py` | Written, **not run** — no Apache FOP binary here |
| `ai-assistant/*` (RAG ingest, retriever, LLM client, code assistant) | Written, **not run** — no Milvus/Ollama/vLLM reachable |
| `mfe-ui/*` | Written, **not built** — no `npm install` (no network). Webpack/Babel/PostCSS/Tailwind configs are in place; a live-viewable React-artifact version of the same UI was rendered and confirmed visually in chat, but that's a hand-duplicated preview, not a build of the actual `mfe-ui/src/` tree |
| `middleware/data_unification/letters/prv_enr_l016.py` (FIELD_QUERIES) | Transcribed from the real Query workbook, **not run against any database** — still Oracle dialect (see §4), no DB was ever reachable |
| `docs/schema/ets_dev/*.sql` | Oracle→Postgres converted, **validated heuristically only** (balanced parens, statement terminators, no leftover Oracle tokens, manual review of complex files) — never run against a real Postgres server. Two real bugs were caught and fixed in the converter during this process (see `oracle_to_pg.py` git-blame-equivalent: schema-qualifier double-rewrite corrupting `COMMENT ON COLUMN`, and a stripped `TABLESPACE` clause that ate a statement terminator and merged two statements) |
| Everything under `infra/` (docker-compose, K8s manifests) | Written, **never deployed** — no Docker/K8s available here |

**First thing to do in a real environment:** run
`docs/schema/ets_dev/00_all_tables_consolidated.sql` against an actual
Postgres instance. That's the cheapest, highest-value check available
and it's never been done.

## 4. The schema situation — read before touching any SQL

Full history is in `docs/ARCHITECTURE.md` and
`docs/schema/ets_dev/README.md`; short version:

The letter this project builds around, **PRV-ENR-L016**, is genuinely
from New Hampshire's MMIS (`NHMMIS52E2`). Filling in its full set of
~25 referenced tables required uploads that turned out to span **three
different source schemas**: NH (`NHMMIS52E2`), North Dakota
(`NDMMIS73E2` / `NDMMIS75E2` — same COTS product, different state's
implementation), and an unclear-origin export labeled `TXT2SQL_APP`.

**By explicit user direction**, all of it is now unified under one
target schema, `ets_dev`, on the stated assumption that structure is
equivalent across state instances of the same product. **This
assumption is not independently verified** — no live database was ever
available to check it. `docs/schema/ets_dev/README.md` has a full
per-table provenance table (which table came from which original
source) for exactly this reason — check it before trusting any
specific table's columns/types are correct for NH.

The DDL is now Postgres dialect (was Oracle). The
`FIELD_QUERIES` SELECT statements in `prv_enr_l016.py` are **still
Oracle SQL** — that conversion was deliberately not done blind (see
inline TODO in that file — `TRUNC(SYSDATE)` → `CURRENT_DATE`,
`:bind_var` → driver params, etc.), since several of those queries
touch TIN/EIN and bank account/routing numbers and a silently wrong
translation is a real-money/real-PII risk, not a cosmetic one.

One trigger (`R_VV_TB`'s Oracle `BEFORE INSERT`) has no mechanical
Postgres equivalent and is left as a commented TODO rather than
guessed at.

## 5. Knowledge base contents (`ai-assistant/rag/kb_source/`)

Real documents, not placeholders:
- `PRV-ENR-L016/` — the letter's actual Design Spec Doc, Query
  workbook, and the two late-arriving table DDLs/data samples
- `domain-dsd/` — **five master DSD chapters**, confirmed New
  Hampshire-specific (Conduent NHMMIS v15.1): Provider Part N2, Member
  Part M, Service Authorization Part D, Claims Financial Reporting
  Part O, Acuity Rate Setting Part I2. Each covers many letters' full
  definitions (e.g. Provider Part N2 alone covers PRV-RVL-L001–L009).
  **Not yet ingested into any vector DB** — `ai-assistant/rag/
  ingest.py` is ready but no Milvus instance was ever reachable here.
- `reference-data/` — lookup-table exports and a ~19,600-row UI
  field-label dictionary (`NH_Business_Labels.xlsx`)

**Deliberately excluded:** the per-table row-data CSVs from the
original uploads were never copied into the repo — only DDL/schema.
Sample values used in tests/templates match the synthetic-looking
record already visible in the legacy sample PDF (`test.com` email
domain), not real provider or banking data. Treat any real data behind
these queries as sensitive (TIN/EIN, NPI, bank routing/account
numbers) regardless of how synthetic the current samples look.

## 6. Immediate next steps (suggested order)

1. Get a real Postgres reachable and run
   `docs/schema/ets_dev/00_all_tables_consolidated.sql` against it —
   the single highest-value unblock, since nothing SQL-related has
   ever touched a live database.
2. Convert `prv_enr_l016.py`'s `FIELD_QUERIES` to Postgres dialect
   (flagged, not done — see §4) and run them for real once the schema
   is loaded and sample data exists.
3. `pip install` the real dependencies (`pika`, `python-barcode`,
   `qrcode`, `pdf417gen`, Playwright + `playwright install`, `pytest`)
   somewhere with network access, then actually run the test suites
   under `*/tests/` — they were written but several couldn't execute
   here.
4. Stand up `infra/docker-compose.yml` locally and wire
   queue → middleware → renderer end-to-end for PRV-ENR-L016 as a real
   smoke test.
5. Ingest `ai-assistant/rag/kb_source/` into a real Milvus/pgvector
   instance.
6. `cd mfe-ui && npm install && npm run dev` — first real build of the
   MFE; the source has never been compiled.

Full outstanding-questions list (including items genuinely blocked on
the user, like live DB credentials) is in `docs/PENDING.md` — keep it
current as items close rather than starting a second tracker.

## 7. Environment note for whoever picks this up

Everything above was built and reviewed in a sandboxed environment
with **no network access, no live database, no Docker/K8s, and no
package installation beyond what was preinstalled**. That's why the
status table in §3 draws such a hard line between "written" and
"verified" — it's not a hedge, it's the literal constraint this work
was produced under. None of that is a reason to distrust the code;
it's a reason to run the checks in §6 before assuming anything SQL- or
infra-adjacent is production-ready.

## 8. Second letter batch + DB-triggered generation + real UI wiring + auth stub

Two more rounds of work landed after §1-7 were written.

**Three more letters** (PRV-MNT-L001, PRV-RVL-L006, PRV-RVL-L003) — a
different archetype from PRV-ENR-L016: flowing prose letters, not
rigid forms. CSS flow + `text-align: justify` is correct here; don't
apply PRV-ENR-L016's absolute-positioning lesson to these. All three
share one agency letterhead block, confirmed byte-identical across
uploads and backed by a real shared mechanism (`R_PARAM_DTL_TB`, keyed
by `(R_FUNC_AREA_CD, R_PARAM_NUM)`) — built once
(`middleware/data_unification/shared/agency_params.py` +
`rendering/templates/_provider_letter_header.html`/
`_provider_letter_styles.html`), not copy-pasted three times. Check
that shared module before adding a fourth Provider-domain prose letter.
Real `pixel_diff.py` numbers (not just eyeballed): address pages
0.7-1.2% (near-exact), letter body pages 6.0-9.6% (same *category* of
line-height drift as PRV-ENR-L016's early attempts, much smaller
magnitude, not a new bug). Full writeup: `docs/ARCHITECTURE.md`
"Second letter batch" section.

**DB-triggered generation, editor wiring, a 4th UI page, auth stub** —
four pieces built together, status of each:

| Piece | File | Status |
|---|---|---|
| DB-condition trigger | `queue/db_poller.py` | **Tested** (mocked cursor, 4/4 pass) — but the actual "ready to send" SQL condition is an educated guess following this schema's naming pattern, not confirmed against real status values |
| Editor → real files | `api/services/templates_service.py` + `TemplateWorkspace.jsx` | **Tested** (9/9 pass, real file I/O not mocks) — editor now loads/saves/validates real template files instead of hardcoded content |
| 4th page: Generate Letters | `mfe-ui/src/components/GenerateLetters.jsx` | Built, lists letter types + pending counts + trigger button. Untested (same `.jsx`-can't-execute status as the rest of `mfe-ui/`) but verified to actually **parse correctly with esbuild** (found already vendored via a global `tsx` npm install in this sandbox — worth checking for on any fresh environment before assuming JS tooling is fully absent) |
| JWT/RBAC | `api/auth.py` | Generic/swappable, deliberately NOT wired to a real IdP — the target ETS Data Platform likely already has its own SSO; building parallel auth would probably fight it. `decode_token` is a disclosed stub (`raise NotImplementedError`, not a silent fake pass). Role-matching logic tested (4/4 pass) |

**New split worth knowing about:** `api/services/*.py` and
`api/auth.py`'s role logic have zero FastAPI dependency and are fully
tested. `api/routers/*.py` + `main.py` + `deps.py` are thin wiring that
cannot even be imported without `pip install fastapi uvicorn pydantic`
(no network access here) — kept deliberately thin so any bug there is
a wiring bug, not a logic bug the tests should have caught. Full status
table: `api/README.md`.

**Real bug caught during this round, not just written-and-trusted:**
`api/services/letters_service.py` originally did
`from queue.db_poller import ...`, which silently resolves to Python's
*stdlib* `queue` module instead of this repo's `queue/` directory
(name collision) and fails. Fixed by adding the directory to
`sys.path` and importing the submodule directly — same pattern
`queue/tests/` already used, just not followed consistently the first
time. If you add new code that imports from this repo's `queue/`
directory, use that pattern, not `import queue.whatever`.

Full detail, including the "confirm before trusting" list for the
DB-trigger condition and the auth stub's real JWKS/issuer/audience
values: `docs/PENDING.md`, section "This round: DB-triggered
generation, editor wiring, UI page, auth stub".
