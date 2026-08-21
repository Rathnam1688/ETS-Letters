# Architecture Notes

## Data flow (happy path)

```
IWA trigger (FR-01)
   -> queue/producer.py: split_iwa_batch()      [FR-03]
   -> RabbitMQ: render-jobs queue
   -> queue/consumer.py (N horizontally-scaled pods)   [NFR 5.3]
        -> middleware/data_unification/unify.py         [FR-02]
        -> rendering/engine/{html_renderer,xslfo_renderer}.py
              -> rendering/barcode/barcode_generator.py  [FR-04]
        -> on success: ack + persist PDF
        -> on failure: publish to render-jobs-dlq, ack original [NFR 5.3]
```

## AI assistant flow

```
Uploaded CMS PDFs / XSDs
   -> ai-assistant/rag/ingest.py   -> Milvus (self-hosted)   [FR-05]

Developer prompt in mfe-ui Workspace tab
   -> ai-assistant/code_assistant.py
        -> ai-assistant/rag/retriever.py  (grounds the prompt)  [BR-04]
        -> ai-assistant/llm_service/local_llm_client.py  (Ollama/vLLM, on-prem)  [FR-06, NFR 5.1]
```

## Why two rendering engines

The BRD lists both Apache FOP (XSL-FO) and Puppeteer/Playwright
(HTML/CSS) as acceptable rendering engines. This scaffold keeps both:

- `xslfo_renderer.py` — for forms needing Apache FOP's stricter,
  print-industry pagination guarantees (CMS forms migrated as-is from
  xPression's FO-like model).
- `html_renderer.py` — for templates the team would rather author in
  HTML/CSS with modern tooling.

Pick one as the default once Phase 5's PoC (Remittance Advice) settles
which gets closer to pixel-parity with legacy xPression output, per
the Visual QA tool.

## Open questions to resolve before Phase 1 infra stands up

- Real connection details for the SQL/XML/JSON source systems
  (`middleware/data_unification/*_ingest.py` currently return stub data
  — except `letters/prv_enr_l016.py`, see below).
- Exact IWA → producer handoff contract (`queue/producer.split_iwa_batch`
  assumes a `{batch_id, letters: [...]}` shape — confirm against real IWA job specs).
- Which open-weight model (Llama 3, Mistral, etc.) and hardware sizing
  for the local LLM serving tier.
- Host portal(s) that will import the `document_hub/DocumentHub` remote
  (BR-05) — needed to finalize the Module Federation shared-dependency versions.

## Reference implementation: PRV-ENR-L016 (EFT Enrollment PDF)

The uploaded `PRV-ENR-L016.zip` (New Hampshire DHHS Medicaid, Oracle
`NHMMIS52E2` schema) turned out to be a complete real-world letter spec
rather than a generic RAG knowledge base — a Design Spec Document with
field-by-field SQL, the assembled Query workbook, a legacy xPression
sample PDF, and DDL for 5 of the ~15 tables the field mapping touches.
It's wired in as the platform's first concrete end-to-end example:

- `middleware/data_unification/letters/prv_enr_l016.py` — every field's
  SQL transcribed verbatim from the Query workbook (Oracle dialect,
  bind variable `:g_cots_ltr_req_sk`)
- `rendering/templates/prv_enr_l016.html` — absolutely positioned at
  coordinates measured directly from the legacy sample PDF via
  pdfplumber (not approximated with flow-layout CSS — see the
  template's own header comment for the full calibration methodology
  and why that was necessary). Rendered through the real production
  path (`rendering/engine/html_renderer.py`, Playwright/Chromium) and
  diffed against the legacy sample: **7.21% pixel variance**, down
  from 26.1% pre-calibration. Independently-positioned elements match
  to within 0.01pt; the residual is concentrated in longer text runs
  and traced to font substitution (no licensed Times New Roman in this
  sandbox — Chromium substitutes Liberation Serif, metric-compatible
  for most but not all character pairs). wkhtmltopdf was tried first
  and rejected — an unpatched-Qt build with an undocumented,
  content-height-dependent auto-shrink that made coordinate
  calibration impossible (each adjustment changed the very scale
  factor being calibrated against). Full detail in
  `rendering/engine/html_renderer.py`'s module docstring.
- `visual-qa/baselines/PRV-ENR-L016_legacy_sample.pdf` — the legacy
  output, ready to feed `visual-qa/pixel_diff.py` once a real render
  pipeline exists to diff against
- `docs/schema/PRV-ENR-L016/` — DDL-only (no data) for the 5 tables
  that were provided
- `ai-assistant/rag/kb_source/PRV-ENR-L016/` — the DSD and Query
  workbook, ready for `ai-assistant/rag/ingest.py`

**Schema gaps:** resolved — see "Follow-up upload batches — schema
unification" below for the full history of how the referenced tables
were sourced and unified under `ets_dev`.

**Field-level ambiguities:** taxonomy code's tie-break rule (multiple
`P_TXNMY_TB` rows per provider, DSD didn't specify) is resolved — see
`provider_taxonomy_code` in `prv_enr_l016.py` (latest record by
`P_DTL_TB.G_AUD_TS DESC`). Other fields may still have similar
ambiguities not yet checked.

**Data handling note:** the uploaded data CSVs (per-table row exports)
were **not** copied into the repo scaffold — only DDL. Sample values in
tests/templates use the synthetic-looking record already visible in
the legacy sample PDF (`test.com` email domain), not real provider or
banking data. Given this letter surfaces TIN/EIN, NPI, and bank
routing/account numbers, treat any real data behind these queries as
sensitive under BR-02 regardless of how the current sample data looks.

## Follow-up upload batches — schema unification (resolved)

Two follow-up batches came in after the initial PRV-ENR-L016 upload:

1. **8 files** (`Details.zip`, `DETIALSS.zip`, `Tracker.zip`, `DSD.zip`,
   `Sample_L_Tracker.zip`, `B_DTL_TB.zip`,
   `provider_table_postgress_ddl.zip`, `ddl.7z`) — filled in most
   missing tables, but from **three different schema origins**
   (`NHMMIS52E2`/NH, `NDMMIS73E2`+`NDMMIS75E2`/ND,
   `TXT2SQL_APP`/unclear). Initially staged separately as unconfirmed.
2. **`Table_Details.zip`** — closed the last two gaps (`G_E_ADR_TB`,
   `R_VV_TB`), both confirmed `NHMMIS52E2`/NH.

**Per explicit direction, all of it is now unified** under a single
`ets_dev` schema (structure assumed equivalent across states of the
same COTS product — a stated assumption, not independently verified).
See `docs/schema/ets_dev/README.md` for the full per-table provenance
table. The Oracle dialect has also been converted to Postgres
(`docs/schema/ets_dev/oracle_to_pg.py`, `00_all_tables_consolidated.sql`).

`ddl.7z` still couldn't be opened (no 7z tool / no network in this
sandbox) — moot for the two tables it might have contained, since
`Table_Details.zip` provided those directly, but flagging in case it
holds anything else relevant.

## Genuinely new, high-value material from the second batch

- **`ai-assistant/rag/kb_source/domain-dsd/`** — five master DSD
  chapters (Conduent NHMMIS v15.1, confirmed New Hampshire-specific):
  *Provider Part N2*, *Member Part M*, *Service Authorization Part D*,
  *Claims Financial Reporting Part O*, *Acuity Rate Setting Part I2*.
  Each is a full chapter with per-letter definitions in the same
  format as the PRV-ENR-L016 DSD — e.g. Provider Part N2 alone covers
  PRV-RVL-L001 through L009. This is the actual FR-05 knowledge base;
  ingest these via `ai-assistant/rag/ingest.py` once Milvus is up.
- **`ai-assistant/rag/kb_source/reference-data/`** — lookup-table
  exports (`R_VV_TB`-style value/description pairs) and
  `NH_Business_Labels.xlsx`, a ~19,600-row UI field-label dictionary
  (code → human-readable label) — useful for auto-generating readable
  field labels in future templates.
- **`docs/schema/letter_samples_manifest.csv`** — catalog of 97
  distinct letter IDs found as legacy sample PDFs across `Tracker.zip`
  (full list: `OPR-TPL` × 43, `PRV-ENR` × 11, `PRV-RVL` × 9,
  `PRV-MNT` × 7, `ARS-CST` × 8, plus `ARS-CMX/CNS/GEN/MQP/SFR`,
  `CAR-EPS`, `MEM-ELG/SUP`, `OPR-PAY`, `PGM-AR/CRM`). The PDFs
  themselves weren't copied into the repo (avoiding bloat) — this is a
  large pool of future Visual QA baselines and template PoC candidates
  once you're ready to pick the next letter.

## PRV-ENR-L016 template: pixel-match investigation

The first version of `rendering/templates/prv_enr_l016.html` (flow-
layout CSS: flexbox rows, margins, `@page` size) was checked against
the legacy sample PDF and looked close by eye, but a real pixel-diff
(`visual-qa/pixel_diff.py`) showed **26% variance** — not close. Root
causes found by actually measuring the legacy PDF's coordinates with
`pdfplumber` (`page.extract_words()`, `.lines`, `.images`) rather than
eyeballing:

1. **Page size was wrong.** `@page { size: Letter }` in CSS wasn't
   honored by `wkhtmltopdf` (the only PDF renderer available in this
   sandbox — not the project's actual intended engine, see below);
   output came out as A4. Fixed with explicit `--page-size Letter`.
2. **The legacy letter isn't flow-laid-out.** Each bar and field
   occupies a fixed-height slot at a fixed absolute Y position,
   regardless of content length — confirmed because the gap between
   the last content row and the next section bar varies
   section-to-section (13.2pt, 30.7pt, 25.8pt for different sections)
   in a way uniform CSS margins cannot reproduce. This matches how
   COTS letter composers (xPression and similar) actually work — form
   fields at fixed coordinates, not reflowing paragraphs. The template
   was rebuilt with every bar and field row's `position: absolute`
   `top`/`left` set to coordinates measured directly from the legacy
   PDF.
3. **Bar colors/heights were guessed, not measured.** Sampled actual
   pixel colors from the legacy render: section bar is pure black
   `#000` with white text (not the greenish tint visible in a
   thumbnail), subsection bars are `#A6A6A6`. Heights: 13.15pt
   (section), 19.15pt (subsection) — measured from `page.lines`.
4. **Column positions were equal-width flex columns; the legacy form
   uses fixed tab-stops** at specific pt x-positions that don't divide
   the page evenly. Extracted actual `x0` clusters per row and used
   those.
5. **The state seal was a missing placeholder.** Extracted the actual
   embedded seal image directly from the legacy PDF via `pdfplumber`
   (`page.crop().to_image()`) — it's the official NH state seal, a
   government emblem, reused here for the org's own government letter
   template. Saved as `rendering/templates/nh_state_seal.png`.

**A second, separate problem surfaced during verification:**
`wkhtmltopdf 0.12.6` in this sandbox is the unpatched-Qt build, which
has a known DPI/print-scaling bug — CSS `pt` positions get rendered at
roughly 0.7687x their specified value (confirmed empirically: fit
`measured = 0.7687*specified + b` across 27 measured line positions).
This is a bug in this specific tool build, not in the coordinates
themselves — `--zoom` and `--disable-smart-shrinking` were tried and
had no effect. The production template
(`rendering/templates/prv_enr_l016.html`) uses the **real, uncorrected
measured coordinates** and should render correctly with the project's
actual intended engine, Playwright (`rendering/engine/html_renderer.py`)
or Apache FOP — neither has this bug. **Playwright isn't installed in
this sandbox** (no network access), so that can't be verified directly
here.

A second file, `prv_enr_l016.WKHTMLTOPDF_DEBUG_ONLY.html`, pre-
compensates for wkhtmltopdf's specific distortion purely so a PDF
could be visually inspected in this sandbox. **Its compensation is an
imperfect linear fit** — residual drift is small (~1-2pt) near the top
of the page but grows to ~18pt by the bottom (the fit doesn't hold
linearly across the full page height). Do not use this file for
anything but a rough visual sanity check in this specific sandbox, and
do not tighten its compensation further — recalibrating a workaround
for a tool that isn't even the production renderer is not a good use
of effort. The real next step is rendering `prv_enr_l016.html` (the
correct one) through Playwright and re-running `pixel_diff.py` against
`visual-qa/baselines/PRV-ENR-L016_legacy_sample.pdf` for a trustworthy
number.

## Second letter batch: PRV-MNT-L001, PRV-RVL-L006, PRV-RVL-L003

Three more letters, uploaded together. Same NH schema (`NHMMIS52E2`
confirmed on every table, including one new one — see below), but a
**different letter archetype** from PRV-ENR-L016: these are flowing
prose business letters (date, recipient address, RE line, optional
bold title, salutation, justified body paragraphs, signature block),
not rigid forms. CSS flow layout with `text-align: justify` is the
right tool here — the opposite lesson from PRV-ENR-L016, where flow
layout was wrong and absolute positioning was required. Don't apply
one letter's lesson to the other without checking which archetype a
new letter actually is.

**Shared architecture, not three copies.** Comparing all three legacy
PDFs' measured coordinates (pdfplumber) showed the agency letterhead
block — seal, "STATE OF NEW HAMPSHIRE / DEPARTMENT OF HEALTH AND HUMAN
SERVICES / DIVISION OF MEDICAID SERVICES", commissioner/director
names, contact info — is byte-identical across all three (same
top/left coordinates, same text). This is backed by a real shared
mechanism, not coincidence: every letter's own Query workbook sources
these same fields from `R_PARAM_DTL_TB`, keyed by
`(R_FUNC_AREA_CD, R_PARAM_NUM)` — e.g. commissioner name is always
`G1`/`130`, agency toll-free number is always `P1`/`79`, regardless of
which letter. Built as:
- `middleware/data_unification/shared/agency_params.py` — the shared
  `R_PARAM_DTL_TB` lookups (letterhead block + a wider Provider
  Relations/Appeals contact block used in letter bodies)
- `rendering/templates/_provider_letter_header.html` +
  `_provider_letter_styles.html` — Jinja `{% include %}`s, not
  copy-pasted per letter

Check `shared/agency_params.py` before adding a new Provider-domain
prose letter — there's a good chance it needs the same shared blocks
rather than its own copy of these queries.

**New table dependency:** `P_DTL_EXT_TB` (PRV-RVL-L003's revalidation
due date). Not seen in the first batch. No DDL for it yet — same
"candidate, unconfirmed" status as the gaps noted in
`docs/schema/ets_dev/README.md` until it arrives. Also added
`R_PARAM_DTL_TB` + `R_PARAM_TB` DDL to `docs/schema/ets_dev/` this
round (confirmed `NHMMIS52E2`, converted to Postgres with the same
`oracle_to_pg.py` used before, heuristically validated the same way —
27 tables in the consolidated schema now, up from 25).

**One data-quality note, not silently corrected:** the uploaded
`PRV-MNT-L001 Query.xlsx` workbook's own "Letter" column header cell
reads "PRV-RVL-L003" — a copy-paste leftover from cloning a template
workbook. The field list and body content match PRV-MNT-L001's own
legacy sample (license expiration date, "second reminder" language),
not PRV-RVL-L003's, so the file was used as intended — just flagged
in `prv_mnt_l001.py`'s docstring rather than trusted or silently
retitled.

**Verification status:** same honest bar as PRV-ENR-L016. All three
templates were rendered with sample data matching each legacy PDF's
own visible sample record and visually compared side-by-side — very
close on the first pass (no wkhtmltopdf-calibration rabbit hole this
time; using real measured header coordinates from the start, combined
with ordinary CSS flow for the prose body, got there directly). Not
run against a real database — same status as PRV-ENR-L016's
`FIELD_QUERIES`. Barcode/QR are the same kind of visual-only,
non-scannable placeholders as before (`placeholder_barcode_example.svg`,
new `placeholder_qr_example.svg`), for the same reason (no network
access to install `python-barcode`/`qrcode`, and a hand-rolled QR
encoder risks looking right while failing to actually scan).
