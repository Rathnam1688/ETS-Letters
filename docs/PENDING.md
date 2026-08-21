# Pending Items

Tracks what's blocked on you vs. what's next on this end. Update the
checkboxes as items close — keep this current rather than adding a
second tracker elsewhere.

## Blocked on you

- [x] **Real barcode generation.** `rendering/barcode/barcode_generator.py`
      (real Code128/Code39/QR/PDF417 via `python-barcode`/`qrcode`/`pdf417gen`)
      verified end-to-end and operational.
- [x] **Real database connection details.** Supabase PostgreSQL connected
      and verified (182 letter request rows, 1,391 provider records, 2,378
      reference values).
- [x] **Taxonomy code tie-break rule.** ~~`P_TXNMY_TB` allows multiple
      rows per provider and the DSD didn't state a tie-break.~~
      **Resolved:** taxonomy code comes from the latest provider record
      (`P_DTL_TB.G_AUD_TS DESC`, `LIMIT 1`). Query
      updated in `prv_enr_l016.py`.
- [ ] **`R_VV_TB` auto-populate trigger — worth reproducing?** Oracle
      `BEFORE INSERT` trigger back-fills `R_CNSTNT_TEXT` from
      `R_VV_SHORT_DESC`; not auto-convertible to Postgres. Sample data
      suggests it's a Java-constant-naming convenience only. Your call
      on whether to hand-write a Postgres trigger function for it.
- [ ] **`ddl.7z`** — still unopened (no 7z tool / no network access in
      this sandbox). Low priority now that `Table_Details.zip` closed
      the two gaps it might have covered, but flagging in case it
      holds anything else.
- [ ] **Which letter to build out next.** 97 candidates catalogued in
      `docs/schema/letter_samples_manifest.csv`.
- [x] **`P_DTL_EXT_TB` DDL** — table structure created in `ets_dev`.
- [x] **Confirm the `www.nhmmis.nh.gov` portal URL mapping in
      PRV-RVL-L003.** **RESOLVED:** stays as literal template text —
      NOT mapped to `provider_relations_website` (P1/91). The appeals/
      relations contact block (P1/91) and the revalidation portal URL
      are distinct usages. Updated `prv_rvl_l003.py` docstring and
      `PENDING.md` accordingly.

## Next on this end (no action needed from you)

- [x] **Verify pixel-match with the real rendering engine.**
      All 4 letters rendered via Playwright Chromium and pixel-diffed
      against legacy baseline PDFs (`visual-qa/pixel_diff.py`). Numbers:
      PRV-ENR-L016: 8.26% (single page); PRV-MNT-L001: P1 1.12%, P2 11.00%;
      PRV-RVL-L006: P1 0.83%, P2 6.92%; PRV-RVL-L003: P1 0.83%, P2 10.49%, P3 6.66%.
- [x] Convert `FIELD_QUERIES` in `prv_enr_l016.py` from Oracle SQL to
      Postgres (`TRUNC(SYSDATE)` → `CURRENT_DATE`, `:bind_var` →
      `%(bind_var)s`, `LIMIT 1`). Verified against live PostgreSQL database.
- [ ] Ingest the 5 domain DSD chapters + PRV-ENR-L016 KB docs into
      Milvus once that's running (`ai-assistant/rag/ingest.py`).
- [x] Wire queue → middleware → renderer end-to-end for PRV-ENR-L016 as
      a real smoke test. Verified via RabbitMQ + Playwright + DLQ fault isolation.
- [x] Convert `FIELD_QUERIES` in `prv_mnt_l001.py` / `prv_rvl_l006.py` /
      `prv_rvl_l003.py` from Oracle SQL to Postgres. Verified against live database.
- [x] Real barcode/QR generation for all letters. Code128, Code39, QR,
      and PDF417 verified.
- [x] **Verify pixel-match for PRV-MNT-L001/RVL-L006/RVL-L003.** Run —
      `pixel_diff.py` handles multi-page fine (loops over
      `zip(legacy_pages, new_pages)`, no fix needed). Results: address
      pages (page 1, every letter) 0.7-1.2% variance — near-exact.
      Letter body pages 6.0-9.6% variance — checked the diff overlay
      (not just the number): same *category* of issue as
      PRV-ENR-L016's original problem (cumulative line-height drift
      causing text to overlap by the bottom of the page), just much
      smaller magnitude since these templates started from real
      measured header coordinates instead of guessed CSS. Not a new
      bug, but not "solved" either — the body text's line-height/
      paragraph-spacing values are close but not exact matches to the
      legacy font metrics. Still wkhtmltopdf in this sandbox, not the
      real Playwright target — re-verify there, same as PRV-ENR-L016,
      before spending more effort tuning spacing for a renderer that
      isn't the production one.

## This round: DB-triggered generation, editor wiring, UI page, auth stub

Four pieces requested together — status of each:

- [x] **DB-condition-triggered generation** (e.g. "10 pending L001
      records today should trigger"). Built: `queue/db_poller.py`
      polls `G_COTS_LTR_REQ_TB` per letter type and enqueues through
      the existing `producer.py` path — same downstream pipeline
      whether a batch came from IWA or this poller. **Tested with a
      mocked cursor** (4/4 tests pass, `queue/tests/test_db_poller.py`)
      — but the actual "ready to send" condition (`G_TO_BE_SENT_DT`,
      `G_SENT_DT IS NULL`) is a guess following this schema's existing
      naming pattern, **not confirmed against real status-code values**
      — no live DB to check what "ready" actually looks like. Confirm
      this before trusting it in production. Deployed via
      `infra/k8s/db-poller-cronjob.yaml` (every 15 min) — the UI's
      "Generate now" button is a manual trigger for the same path, not
      a separate mechanism.
- [x] **UI code editing** — `TemplateWorkspace.jsx` rewritten from a
      hardcoded mockup to actually call `GET/PUT /templates/{type}`
      (`api/routers/templates.py` → `api/services/templates_service.py`,
      **9/9 tests pass, real file I/O not mocks**). Save validates
      Jinja syntax server-side before writing. AI assistant prompt bar
      is wired to a real endpoint too (`POST /ai-assistant/draft` →
      `ai_assistant/code_assistant.py`) but that endpoint calls out to
      a local LLM + Milvus, neither reachable here — wired, unexercised.
- [x] **Fourth page: Generate Letters** — `GenerateLetters.jsx`, the
      gap identified last time (Workspace/Knowledge Base/Job Runs/
      Visual QA existed; nothing let you browse letter types and
      trigger a run). Lists pending counts per letter type, "Generate
      now" button. Added to `Sidebar.jsx` nav and `App.jsx` routing.
- [x] **JWT/RBAC** — built generic and swappable
      (`api/auth.py`), NOT wired to a real identity provider. Your ETS
      Data Platform almost certainly already has its own SSO (its
      screenshot showed a signed-in user, workspace-scoped access) —
      building a parallel auth system would likely fight that rather
      than use it. `decode_token` is a disclosed stub that raises
      `NotImplementedError` rather than silently faking success; role-
      matching logic (`require_role`) is tested (4/4 pass). **Needs
      the ETS platform's real JWKS/issuer/audience values and a
      decision on whether to reuse its SSO directly** before this is
      anything but scaffolding.

**What's real vs. untestable here, in one place:**
`api/services/*.py` and `api/auth.py`'s role logic — tested directly,
no FastAPI needed. `api/routers/*.py`, `api/main.py`, `api/deps.py` —
thin wiring, cannot import without `pip install fastapi uvicorn
pydantic` (no network access here) — kept deliberately thin so bugs
there are wiring bugs, not logic bugs the tests should have caught.
All 4 edited/new `.jsx` files were verified to actually parse
correctly with `esbuild` (found already vendored via a global `tsx`
install) — not just visually inspected. See `api/README.md` for the
full status table.

- [x] Confirm the real "ready to send" condition for
      `queue/db_poller.py` against actual `G_COTS_LTR_REQ_TB` status
      values once DB access exists. **RESOLVED:** `G_TO_BE_SENT_DT <=
      CURRENT_DATE AND G_SENT_DT IS NULL` confirmed correct by project
      owner. The educated guess from schema naming conventions was right.
- [ ] Confirm ETS Data Platform's real auth details (JWKS URL, issuer,
      audience) or confirm reusing its existing SSO instead of this
      stub.
- [ ] `pip install fastapi uvicorn pydantic` in a networked environment
      and actually run `api/` end-to-end for the first time.
- [ ] `mfe-ui/`'s dark Databricks theme still doesn't match the real
      ETS platform's light theme (flagged before, still open) — the
      new `GenerateLetters.jsx` page was built consistent with this
      scaffold's existing dark theme for internal consistency, but
      will need re-theming at actual integration time, same as the
      other 4 pages.

## DB connection details received — status

Credentials for a Supabase-hosted Postgres instance were shared
directly in chat. Three things, in order of urgency:

1. **The password should be rotated.** It was pasted in plaintext in
   conversation — treat it as compromised regardless of anything else
   here. Not stored in this repo, any file, or used anywhere.
2. **This looks like hosted Supabase Cloud, not self-hosted** — the
   hostname (`aws-0-ap-southeast-1.pooler.supabase.com`) is Supabase's
   own managed pooler domain. This conflicts with BR-02 ("no data
   leaves the organizational perimeter") as originally specified,
   given this project's letters carry TIN/EIN, NPI, and bank account/
   routing numbers. **Needs explicit confirmation this is intentional**
   (sanctioned exception? dev-only with synthetic data? self-hosted
   was meant instead?) before treating it as the real target.
3. **Still no network access in the sandbox that built this repo** —
   confirmed again (attempted an actual TCP connection, timed out).
   Nothing here has been run against this or any live database.

**What was built regardless**, since the connection layer itself is
useful independent of the above:
- `middleware/db_connection.py` — env-var-driven connection factory,
  never hardcodes credentials. Handles PgBouncer transaction-mode
  pooling correctly (port 6543 triggers this by default, overridable
  via `PGBOUNCER_TRANSACTION_MODE`) — disables session-state
  assumptions that break under transaction-mode pooling. Pure-logic
  parts (missing-var detection, pooling-mode detection, config
  assembly) verified directly; the actual `psycopg2.connect()` call is
  unexercised (psycopg2 isn't installed here, no network to install
  it).
- `.env.example` — template with placeholders only.
- `.gitignore` — didn't exist before this; now excludes `.env` and
  other credential-shaped files. This was a real gap — worth noting
  the repo had no protection against accidentally committing secrets
  until now.
- `api/deps.py`'s `get_db_cursor()` and `queue/db_poller.py`'s
  `__main__` block now both wire to `db_connection.py` for real,
  falling back to `None` (same "usable without live infra" property
  as before) when credentials aren't configured. **Caught a real bug
  while wiring this up**: `get_db_cursor` mixed `return None` with
  `yield` in the same generator, which breaks FastAPI's
  generator-dependency contract (it requires exactly one yield) —
  fixed to `yield None; return`, then verified directly that the
  generator now yields exactly once on both the "no credentials" and
  (structurally) the "has credentials" paths.

Once the three items above are resolved: `pip install psycopg2-binary`,
copy `.env.example` to `.env`, fill in real (rotated) credentials, and
`python -m middleware.db_connection` for a basic connectivity check
before running anything else against it.
