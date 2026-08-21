# ets_dev — Consolidated Target Schema

All table DDL for this project is treated as living under a single
schema, **`ets_dev`**, per explicit direction: tables from different
source states (NH's `NHMMIS52E2`, ND's `NDMMIS73E2`/`NDMMIS75E2`) and
the earlier unclear-origin `TXT2SQL_APP` export are consolidated here
with their schema qualifiers rewritten to `ets_dev`, on the stated
assumption that structure is equivalent across "stars" (state
instances) of the same COTS product.

**This is a stated assumption, not independently verified against a
live database.** A real connection (details to follow) is what
actually confirms it. Until then, treat this folder as the working
schema baseline, not ground truth — especially for `PRV-ENR-L016`,
which surfaces TIN/EIN, NPI, and bank account/routing numbers.

**Start here:** `00_all_tables_consolidated.sql` — all 25 tables in
one file, Postgres dialect, ready to run against a local Postgres/
Supabase instance for dev purposes. Individual per-table files (plus
their indexes/constraints/FK files) remain alongside it for reference.

## Provenance by table (for when the real DB details arrive)

| Table | Original schema | Confirmed for this letter? |
|---|---|---|
| G_COTS_LTR_REQ_TB, G_COTS_LTR_REQ_RECR_TB, G_PYE_PYR_EFT_SETUP_TB, G_ADR_USG_TB, G_COTS_LTR_TMPLT_TB, G_E_ADR_TB, R_VV_TB | NHMMIS52E2 (NH) | Yes — directly from this letter's own KB upload |
| G_REP_TB, G_REP_PROV_TB, G_CMN_ENTY_REP_XREF_TB, G_PHONE_TB, G_PHONE_USG_TB, G_E_ADR_USG_TB | NDMMIS73E2 (ND) | No — assumed equivalent per direction, not verified |
| P_DTL_TB, P_ALT_ID_TB, P_ENROL_ALT_ID_TB, P_LIC_CERT_TB, P_TXNMY_TB, P_TY_TB | TXT2SQL_APP (unclear origin) | No — assumed equivalent per direction, not verified |
| Remaining supporting tables (G_CMN_ENTY_TB, G_ADR_TB, G_USER_TB, G_NOTE_TB, R_DD_COL_TB, etc.) | Mixed NH/ND | Mixed — schema qualifier no longer indicates origin since normalization |

## Dialect status — DONE

Every Oracle-dialect file (`VARCHAR2`, `NUMBER(p,s)`, `SYSDATE`,
`ENABLE`, `SUPPLEMENTAL LOG`/storage/tablespace clauses) has been
converted to Postgres syntax via `oracle_to_pg.py` (regex-based, no
`sqlparse`/live DB available in this sandbox to do it more robustly).
Validated with a structural heuristic pass (balanced parens, statement
terminators, no leftover Oracle tokens) across all 51 files — clean —
plus manual review of the more complex multi-FK tables. **Not the same
as validating against a real Postgres server**, which wasn't available
here; re-run `\i 00_all_tables_consolidated.sql` in a real `psql`
session as the first real check once infra is up.

**One exception, not auto-converted:** `R_VV_TB.sql` had a PL/SQL
`BEFORE INSERT` trigger (auto-populates `R_CNSTNT_TEXT` from
`R_VV_SHORT_DESC`). Oracle's `:new.col` trigger syntax has no
mechanical Postgres equivalent — it's left as a commented-out block in
the file with a TODO. Needs a hand-written Postgres trigger function
(`CREATE FUNCTION ... RETURNS TRIGGER`) if that auto-populate behavior
is still wanted; the sample data suggests it's mostly used to generate
Java-code constant names and may not be worth reproducing at all.
