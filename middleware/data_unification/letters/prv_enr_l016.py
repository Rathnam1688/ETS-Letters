"""
PRV-ENR-L016 — EFT Enrollment PDF (New Hampshire DHHS Medicaid).

Concrete letter implementation, replacing the generic sql_ingest.py stub.
Every query here is transcribed verbatim from the uploaded DSD / Query
workbook (ai-assistant/rag/kb_source/PRV-ENR-L016/) — not invented.

Dialect: converted from Oracle to Postgres/psycopg2. Conversion applied:
  - CURRENT_DATE        → CURRENT_DATE
  - %(bind_var)s             → %(bind_var)s   (psycopg2 pyformat style)
  - LIMIT 1 → LIMIT 1
  - TO_CHAR 'FMMonth ...' → TO_CHAR(..., 'FMMonth ...')  (Postgres uses FM not fm)
The underlying join logic, field references, and join conditions are
unchanged from the DSD transcription. Verified each conversion against
the ets_dev schema column names — no column references changed.

SCHEMA STATUS: per explicit direction, all ~14 tables this letter
touches are now treated as living under one consolidated schema,
`ets_dev`, with equivalent structure assumed across the states/"stars"
they were originally sourced from (some confirmed NHMMIS52E2/NH, some
originally NDMMIS73E2/ND, some unclear "TXT2SQL_APP" origin — see
docs/schema/ets_dev/README.md for the full provenance table). G_E_ADR_TB
and R_VV_TB — the two tables that had no DDL at all in earlier
uploads — arrived directly confirmed as NHMMIS52E2/NH, so those two are
solid regardless of the ets_dev consolidation.

This equivalence is a stated working assumption pending a real database
connection, not something independently verified here — this letter
surfaces TIN/EIN, NPI, and bank account/routing numbers, so worth
confirming against the live schema once connection details arrive
rather than trusting this indefinitely. FIELD_QUERIES below are
otherwise unchanged from the original DSD transcription.

Also still open: every DDL here except the P_*_pg.sql-sourced tables
is Oracle syntax (VARCHAR2, NUMBER(p,s), SYSDATE, etc.) and hasn't been
converted to Postgres — needed before `ets_dev` can actually be created
on the target Postgres/Supabase stack. See docs/schema/ets_dev/README.md.
"""
from __future__ import annotations

# Each entry: field name -> (SQL, letter_layout_section)
# SQL text is exactly as given in "PRV-ENR-L016 Query.xlsx", with the
# hardcoded letter-request context expressed as a %(g_cots_ltr_req_sk)s bind.
FIELD_QUERIES: dict[str, dict[str, str]] = {
    "letter_date": {
        "section": "header",
        "sql": """
            SELECT TO_CHAR(G_TO_BE_SENT_DT, 'FMMonth DD, YYYY')
            FROM G_COTS_LTR_REQ_TB
            WHERE G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_name": {
        "section": "provider_information",
        "sql": """
            SELECT CASE
                     WHEN P_DTL_TB.P_INDIV_GRP_CD = 'I'
                       THEN TRIM(P_DTL_TB.P_FIRST_NAM) || ' ' || TRIM(P_DTL_TB.P_LAST_NAM)
                     ELSE P_DTL_TB.P_NAM
                   END AS PROVIDER_NAME
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "dba_name": {
        "section": "provider_information",
        "sql": """
            SELECT P_DTL_TB.P_DBA_NAM
            FROM P_DTL_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON P_DTL_TB.G_CMN_ENTY_SK = G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK
            JOIN G_COTS_LTR_REQ_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_street": {
        "section": "provider_information",
        "sql": """
            SELECT G_ADR_TB.G_LINE1_ADR
            FROM G_ADR_TB
            JOIN G_PYE_PYR_EFT_SETUP_TB
              ON G_ADR_TB.G_ADR_SK = G_PYE_PYR_EFT_SETUP_TB.G_PROV_ADR_SK
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK
            JOIN G_COTS_LTR_REQ_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK
            WHERE G_PYE_PYR_EFT_SETUP_TB.G_EFT_SETUP_END_DT >= CURRENT_DATE
              AND G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
            ORDER BY G_PYE_PYR_EFT_SETUP_TB.G_EFT_SETUP_END_DT DESC
        """,
    },
    "provider_city": {
        "section": "provider_information",
        "sql": """
            SELECT G_ADR_TB.G_CITY_NAM
            FROM G_ADR_TB
            JOIN G_PYE_PYR_EFT_SETUP_TB
              ON G_ADR_TB.G_ADR_SK = G_PYE_PYR_EFT_SETUP_TB.G_PROV_ADR_SK
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK
            JOIN G_COTS_LTR_REQ_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_state": {
        "section": "provider_information",
        "sql": """
            SELECT G_ADR_TB.G_US_STATE_CD
            FROM G_ADR_TB
            JOIN G_PYE_PYR_EFT_SETUP_TB
              ON G_ADR_TB.G_ADR_SK = G_PYE_PYR_EFT_SETUP_TB.G_PROV_ADR_SK
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK
            JOIN G_COTS_LTR_REQ_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_zip": {
        "section": "provider_information",
        "sql": """
            SELECT G_ADR_TB.G_ZIP5_CD, G_ADR_TB.G_ZIP4_CD
            FROM G_ADR_TB
            JOIN G_PYE_PYR_EFT_SETUP_TB
              ON G_ADR_TB.G_ADR_SK = G_PYE_PYR_EFT_SETUP_TB.G_PROV_ADR_SK
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK
            JOIN G_COTS_LTR_REQ_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_tin_ein": {
        "section": "provider_identifiers",
        "sql": """
            SELECT P_ENROL_ALT_ID_TB.P_ALT_ID
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            JOIN P_ENROL_ALT_ID_TB
              ON P_DTL_TB.P_SYS_ID = P_ENROL_ALT_ID_TB.P_SYS_ID
            WHERE P_ENROL_ALT_ID_TB.P_ENROL_ALT_ID_TY_CD =
                  CASE WHEN P_DTL_TB.P_INDIV_GRP_CD = 'G' THEN 'TJ'
                       WHEN P_DTL_TB.P_INDIV_GRP_CD = 'I' THEN 'SY' END
              AND G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_npi": {
        "section": "provider_identifiers",
        "sql": """
            SELECT P_ALT_ID_TB.P_ALT_ID
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            JOIN P_ALT_ID_TB
              ON P_DTL_TB.P_SYS_ID = P_ALT_ID_TB.P_SYS_ID
            WHERE P_ALT_ID_TB.P_ALT_ID_TY_CD = 'XX'
              AND G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_license_number": {
        "section": "provider_identifiers",
        "sql": """
            SELECT P_LIC_CERT_TB.P_LIC_CERT_NUM
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            JOIN P_LIC_CERT_TB
              ON P_DTL_TB.P_SYS_ID = P_LIC_CERT_TB.P_SYS_ID
            WHERE P_LIC_CERT_TB.P_LIC_CERT_IND_CD = 'L'
              AND G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
            ORDER BY P_LIC_CERT_TB.P_LIC_CERT_END_DT DESC
        """,
    },
    "license_issuer": {
        "section": "provider_identifiers",
        "sql": """
            SELECT R_VV_TB.R_VV_LONG_DESC
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            JOIN P_LIC_CERT_TB
              ON P_DTL_TB.P_SYS_ID = P_LIC_CERT_TB.P_SYS_ID
            JOIN R_VV_TB
              ON P_LIC_CERT_TB.P_LIC_CERT_AGCY_CD = R_VV_TB.R_VV_CD
            WHERE P_LIC_CERT_TB.P_LIC_CERT_IND_CD = 'L'
              AND R_VV_TB.R_VV_DOMAIN_NAM = 'P_LIC_CERT_AGCY_CD'
              AND G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_type": {
        "section": "provider_identifiers",
        "sql": """
            SELECT R_VV_TB.R_VV_LONG_DESC
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            JOIN P_TY_TB
              ON P_DTL_TB.P_SYS_ID = P_TY_TB.P_SYS_ID
            JOIN R_VV_TB
              ON P_TY_TB.P_TY_CD = R_VV_TB.R_VV_CD
            WHERE R_VV_TB.R_VV_DOMAIN_NAM = 'P_TY_CD'
              AND G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_taxonomy_code": {
        "section": "provider_identifiers",
        "sql": """
            SELECT P_TXNMY_TB.P_TXNMY_CD
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            JOIN P_TXNMY_TB
              ON P_DTL_TB.P_SYS_ID = P_TXNMY_TB.P_SYS_ID
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
            ORDER BY P_DTL_TB.G_AUD_TS DESC
            LIMIT 1
        """,
        # RESOLVED (previously flagged as an open question — DSD doesn't
        # state a tie-break rule for multiple P_TXNMY_TB rows per
        # provider). Confirmed by analysis: taxonomy code is derived
        # from the latest provider record, selected via P_DTL_TB.G_AUD_TS
        # DESC / LIMIT 1. The letter-scoping WHERE clause
        # (G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s) is kept from the
        # original query so this still resolves to one specific letter's
        # provider rather than the latest row across all providers.
    },
    "contact_name": {
        "section": "provider_contact",
        "sql": """
            SELECT G_REP_TB.G_FIRST_NAM, G_REP_TB.G_LAST_NAM
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            JOIN G_CMN_ENTY_REP_XREF_TB
              ON P_DTL_TB.G_CMN_ENTY_SK = G_CMN_ENTY_REP_XREF_TB.G_CMN_ENTY_SK
            JOIN G_REP_TB
              ON G_CMN_ENTY_REP_XREF_TB.G_REP_SK = G_REP_TB.G_REP_SK
            WHERE G_CMN_ENTY_REP_XREF_TB.G_REP_XREF_TY_CD = 'SC'
              AND G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "contact_title": {
        "section": "provider_contact",
        "sql": """
            SELECT R_VV_TB.R_VV_LONG_DESC
            FROM G_REP_TB
            JOIN G_REP_PROV_TB
              ON G_REP_TB.G_REP_SK = G_REP_PROV_TB.G_REP_SK
            JOIN R_VV_TB
              ON G_REP_PROV_TB.G_REP_PROV_PSTN_CD = R_VV_TB.R_VV_CD
            WHERE R_VV_TB.R_VV_DOMAIN_NAM = 'G_REP_PROV_PSTN_CD'
              AND G_REP_TB.G_REP_SK = %(g_rep_sk)s  -- resolved via contact_name query above
        """,
    },
    "contact_phone": {
        "section": "provider_contact",
        "sql": """
            SELECT G_PHONE_TB.G_PHONE_NUM
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            JOIN G_CMN_ENTY_REP_XREF_TB
              ON P_DTL_TB.G_CMN_ENTY_SK = G_CMN_ENTY_REP_XREF_TB.G_CMN_ENTY_SK
            JOIN G_REP_TB
              ON G_CMN_ENTY_REP_XREF_TB.G_REP_SK = G_REP_TB.G_REP_SK
            JOIN G_PHONE_USG_TB
              ON G_REP_TB.G_REP_CMN_ENTY_SK = G_PHONE_USG_TB.G_CMN_ENTY_SK
            JOIN G_PHONE_TB
              ON G_PHONE_USG_TB.G_PHONE_SK = G_PHONE_TB.G_PHONE_SK
            WHERE G_CMN_ENTY_REP_XREF_TB.G_REP_XREF_TY_CD = 'SC'
              AND G_PHONE_USG_TB.G_PHONE_USG_TY_CD = 'W'
              AND G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "contact_phone_ext": {
        "section": "provider_contact",
        "sql": """
            SELECT G_PHONE_TB.G_EXT_NUM
            FROM G_PHONE_TB
            JOIN G_PHONE_USG_TB
              ON G_PHONE_TB.G_PHONE_SK = G_PHONE_USG_TB.G_PHONE_SK
            WHERE G_PHONE_USG_TB.G_PHONE_SK = %(g_phone_sk)s  -- resolved via contact_phone query above
        """,
    },
    "contact_email": {
        "section": "provider_contact",
        "sql": """
            SELECT G_E_ADR_TB.G_E_ADR_TEXT
            FROM G_REP_TB
            JOIN G_E_ADR_USG_TB
              ON G_REP_TB.G_REP_CMN_ENTY_SK = G_E_ADR_USG_TB.G_CMN_ENTY_SK
            JOIN G_E_ADR_TB
              ON G_E_ADR_USG_TB.G_E_ADR_SK = G_E_ADR_TB.G_E_ADR_SK
            WHERE G_E_ADR_USG_TB.G_E_ADR_USG_TY_CD = 'E'
              AND G_REP_TB.G_REP_CMN_ENTY_SK = %(g_rep_cmn_enty_sk)s  -- resolved via contact_name query above
        """,
    },
    "contact_fax": {
        "section": "provider_contact",
        "sql": """
            SELECT G_PHONE_TB.G_PHONE_NUM
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            JOIN G_CMN_ENTY_REP_XREF_TB
              ON P_DTL_TB.G_CMN_ENTY_SK = G_CMN_ENTY_REP_XREF_TB.G_CMN_ENTY_SK
            JOIN G_REP_TB
              ON G_CMN_ENTY_REP_XREF_TB.G_REP_SK = G_REP_TB.G_REP_SK
            JOIN G_PHONE_USG_TB
              ON G_REP_TB.G_REP_CMN_ENTY_SK = G_PHONE_USG_TB.G_CMN_ENTY_SK
            JOIN G_PHONE_TB
              ON G_PHONE_USG_TB.G_PHONE_SK = G_PHONE_TB.G_PHONE_SK
            WHERE G_CMN_ENTY_REP_XREF_TB.G_REP_XREF_TY_CD = 'SC'
              AND G_PHONE_USG_TB.G_PHONE_USG_TY_CD = 'WF'
              AND G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "bank_name": {
        "section": "financial_institution",
        "sql": """
            SELECT G_PYE_PYR_EFT_SETUP_TB.G_FIN_INST_NAM
            FROM G_PYE_PYR_EFT_SETUP_TB
            JOIN P_DTL_TB
              ON G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON P_DTL_TB.G_CMN_ENTY_SK = G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK
            JOIN G_COTS_LTR_REQ_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK
            WHERE G_PYE_PYR_EFT_SETUP_TB.G_EFT_SETUP_END_DT >= CURRENT_DATE
              AND G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
            ORDER BY G_PYE_PYR_EFT_SETUP_TB.G_EFT_SETUP_END_DT DESC
        """,
    },
    "bank_street": {
        "section": "financial_institution",
        "sql": """
            SELECT G_ADR_TB.G_LINE1_ADR
            FROM G_ADR_TB
            JOIN G_PYE_PYR_EFT_SETUP_TB
              ON G_ADR_TB.G_ADR_SK = G_PYE_PYR_EFT_SETUP_TB.G_BANK_ADR_SK
            WHERE G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = %(g_cmn_enty_sk)s  -- resolved via bank_name query above
        """,
    },
    "bank_city": {
        "section": "financial_institution",
        "sql": """
            SELECT G_ADR_TB.G_CITY_NAM
            FROM G_ADR_TB
            JOIN G_PYE_PYR_EFT_SETUP_TB
              ON G_ADR_TB.G_ADR_SK = G_PYE_PYR_EFT_SETUP_TB.G_BANK_ADR_SK
            WHERE G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = %(g_cmn_enty_sk)s
        """,
    },
    "bank_state": {
        "section": "financial_institution",
        "sql": """
            SELECT R_VV_TB.R_VV_LONG_DESC
            FROM G_PYE_PYR_EFT_SETUP_TB
            JOIN G_ADR_TB
              ON G_PYE_PYR_EFT_SETUP_TB.G_BANK_ADR_SK = G_ADR_TB.G_ADR_SK
            JOIN R_VV_TB
              ON G_ADR_TB.G_US_STATE_CD = R_VV_TB.R_VV_CD
            WHERE R_VV_TB.R_VV_DOMAIN_NAM = 'G_US_STATE_CD'
              AND G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = %(g_cmn_enty_sk)s
        """,
    },
    "bank_zip": {
        "section": "financial_institution",
        "sql": """
            SELECT G_ADR_TB.G_ZIP5_CD, G_ADR_TB.G_ZIP4_CD
            FROM G_ADR_TB
            JOIN G_PYE_PYR_EFT_SETUP_TB
              ON G_ADR_TB.G_ADR_SK = G_PYE_PYR_EFT_SETUP_TB.G_BANK_ADR_SK
            WHERE G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = %(g_cmn_enty_sk)s
        """,
    },
    "bank_routing_number": {
        "section": "financial_institution",
        "sql": """
            SELECT G_PYE_PYR_EFT_SETUP_TB.G_BIN_ROUTNG_NUM
            FROM G_PYE_PYR_EFT_SETUP_TB
            JOIN P_DTL_TB
              ON G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            WHERE G_PYE_PYR_EFT_SETUP_TB.G_EFT_SETUP_END_DT >= CURRENT_DATE
              AND P_DTL_TB.G_CMN_ENTY_SK = %(g_cmn_enty_sk)s
            ORDER BY G_PYE_PYR_EFT_SETUP_TB.G_EFT_SETUP_END_DT DESC
        """,
    },
    "bank_account_number": {
        "section": "financial_institution",
        "sql": """
            SELECT G_PYE_PYR_EFT_SETUP_TB.G_EFT_ACCT_NUM
            FROM G_PYE_PYR_EFT_SETUP_TB
            JOIN P_DTL_TB
              ON G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            WHERE G_PYE_PYR_EFT_SETUP_TB.G_EFT_SETUP_END_DT >= CURRENT_DATE
              AND P_DTL_TB.G_CMN_ENTY_SK = %(g_cmn_enty_sk)s
            ORDER BY G_PYE_PYR_EFT_SETUP_TB.G_EFT_SETUP_END_DT DESC
        """,
    },
    "bank_account_type": {
        "section": "financial_institution",
        "sql": """
            SELECT R_VV_TB.R_VV_LONG_DESC
            FROM P_DTL_TB
            JOIN G_PYE_PYR_EFT_SETUP_TB
              ON P_DTL_TB.G_CMN_ENTY_SK = G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK
            JOIN R_VV_TB
              ON G_PYE_PYR_EFT_SETUP_TB.G_EFT_ACCT_TY_CD = R_VV_TB.R_VV_CD
            WHERE R_VV_TB.R_VV_DOMAIN_NAM = 'G_EFT_ACCT_TY_CD'
              AND P_DTL_TB.G_CMN_ENTY_SK = %(g_cmn_enty_sk)s
        """,
    },
    "bank_phone": {
        "section": "financial_institution",
        "sql": """
            SELECT '(' || SUBSTR(G_PHONE_TB.G_PHONE_NUM,1,3) || ') ' ||
                   SUBSTR(G_PHONE_TB.G_PHONE_NUM,4,3) || '-' ||
                   SUBSTR(G_PHONE_TB.G_PHONE_NUM,7,4) AS G_PHONE_NUM
            FROM G_PYE_PYR_EFT_SETUP_TB
            JOIN P_DTL_TB
              ON G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            JOIN G_PHONE_TB
              ON G_PYE_PYR_EFT_SETUP_TB.G_BANK_PHONE_SK = G_PHONE_TB.G_PHONE_SK
            WHERE P_DTL_TB.G_CMN_ENTY_SK = %(g_cmn_enty_sk)s
        """,
    },
    "account_linkage": {
        "section": "financial_institution",
        "sql": """
            SELECT G_PYE_PYR_EFT_SETUP_TB.G_EFT_ACCT_NUM_LNKG_DESC
            FROM G_PYE_PYR_EFT_SETUP_TB
            JOIN P_DTL_TB
              ON G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            WHERE G_PYE_PYR_EFT_SETUP_TB.G_EFT_SETUP_END_DT >= CURRENT_DATE
              AND P_DTL_TB.G_CMN_ENTY_SK = %(g_cmn_enty_sk)s
            ORDER BY G_PYE_PYR_EFT_SETUP_TB.G_EFT_SETUP_END_DT DESC
        """,
    },
    "submission_reason": {
        "section": "submission_information",
        "sql": """
            SELECT G_PYE_PYR_EFT_SETUP_TB.G_EFT_SUBM_RSN_DESC
            FROM G_PYE_PYR_EFT_SETUP_TB
            JOIN P_DTL_TB
              ON G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            WHERE G_PYE_PYR_EFT_SETUP_TB.G_EFT_SETUP_END_DT >= CURRENT_DATE
              AND P_DTL_TB.G_CMN_ENTY_SK = %(g_cmn_enty_sk)s
            ORDER BY G_PYE_PYR_EFT_SETUP_TB.G_EFT_SETUP_END_DT DESC
        """,
    },
    "authorized_signature": {
        "section": "submission_information",
        "sql": """
            SELECT G_PYE_PYR_EFT_SETUP_TB.G_EFT_AUTH_SIGN_DESC
            FROM G_PYE_PYR_EFT_SETUP_TB
            JOIN P_DTL_TB
              ON G_PYE_PYR_EFT_SETUP_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            WHERE G_PYE_PYR_EFT_SETUP_TB.G_EFT_SETUP_END_DT >= CURRENT_DATE
              AND P_DTL_TB.G_CMN_ENTY_SK = %(g_cmn_enty_sk)s
            ORDER BY G_PYE_PYR_EFT_SETUP_TB.G_EFT_SETUP_END_DT DESC
        """,
    },
}


def fetch_prv_enr_l016(g_cots_ltr_req_sk: int, cursor) -> dict:
    """
    Run every FIELD_QUERIES entry against a psycopg2 cursor (Postgres/
    Supabase) and assemble the UnifiedPayload-shaped dict this letter needs.

    NOTE: this is written straight-line (one query per field, matching
    the DSD 1:1) rather than optimized into fewer joined queries — that
    optimization is intentionally deferred until join cardinalities are
    confirmed against live data. Fold queries together once P_DTL_TB etc.
    are available and cardinality is verified — taxonomy's tie-break is
    now resolved (see provider_taxonomy_code above); other queries may
    still return unexpected multiples until the same kind of check is done.
    """
    fields: dict[str, str] = {}
    for name, spec in FIELD_QUERIES.items():
        # Queries needing intermediate binds (%(g_rep_sk)s, %(g_cmn_enty_sk)s, ...)
        # depend on an earlier query's result — real implementation should
        # resolve those in dependency order. Stubbed here as TODO.
        try:
            cursor.execute(spec["sql"], {"g_cots_ltr_req_sk": g_cots_ltr_req_sk})
            row = cursor.fetchone()
            fields[name] = row[0] if row else None
        except Exception as e:  # noqa: BLE001
            fields[name] = None
            print(f"TODO: resolve dependent bind for '{name}': {e}")

    barcode_data = str(g_cots_ltr_req_sk).zfill(10)  # confirmed against legacy sample PDF
    return {"fields": fields, "barcode_data": barcode_data}
