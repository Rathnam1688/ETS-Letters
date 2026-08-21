"""
PRV-RVL-L003 — Provider Revalidation Final Notice (New Hampshire DHHS
Medicaid, NHMMIS52E2).

Longest of the three letters in this batch — spans 3 pages in the
legacy sample (address page, letter page 1, continuation page 2 with
its own "<date> / Page 2" mini-header). Uses the widest set of shared
Provider Relations / Appeals params of the three.

Shared agency letterhead fields are NOT repeated here — see
middleware/data_unification/shared/agency_params.py.

Dialect: Oracle, as transcribed. Not yet converted to Postgres.
"""
from __future__ import annotations

FIELD_QUERIES: dict[str, dict[str, str]] = {
    "letter_date": {
        "sql": """
            SELECT TO_CHAR(G_TO_BE_SENT_DT, 'FMMonth DD, YYYY')
            FROM G_COTS_LTR_REQ_TB
            WHERE G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_name": {
        "sql": """
            SELECT P_DTL_TB.P_NAM
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_dba_name": {
        "sql": """
            SELECT P_DTL_TB.P_DBA_NAM
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_address_line1": {
        "sql": """
            SELECT G_ADR_TB.G_LINE1_ADR
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN G_ADR_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_ADR_SK = G_ADR_TB.G_ADR_SK
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_address_line2": {
        "sql": """
            SELECT G_ADR_TB.G_LINE2_ADR
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN G_ADR_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_ADR_SK = G_ADR_TB.G_ADR_SK
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_address_city": {
        "sql": """
            SELECT G_ADR_TB.G_CITY_NAM
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN G_ADR_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_ADR_SK = G_ADR_TB.G_ADR_SK
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_address_state": {
        "sql": """
            SELECT G_ADR_TB.G_US_STATE_CD
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN G_ADR_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_ADR_SK = G_ADR_TB.G_ADR_SK
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "provider_address_zip": {
        "sql": """
            SELECT G_ADR_TB.G_ZIP5_CD || '-' || G_ADR_TB.G_ZIP4_CD AS ZIP_CODE
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN G_ADR_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_ADR_SK = G_ADR_TB.G_ADR_SK
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "nh_medicaid_provider_id": {
        # Same query shape as PRV-RVL-L006's — confirmed identical
        # between these two uploads (both use active-dated + ORDER BY
        # G_AUD_ADD_TS DESC + ROWNUM=1), unlike PRV-MNT-L001's
        # MAX(P_ALT_ID_SK) subquery approach.
        "sql": """
            SELECT P_ALT_ID
            FROM (
                SELECT P_ALT_ID_TB.P_ALT_ID
                FROM G_COTS_LTR_REQ_TB
                JOIN G_COTS_LTR_REQ_RECR_TB
                  ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
                JOIN P_DTL_TB
                  ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
                JOIN P_ALT_ID_TB
                  ON P_DTL_TB.P_SYS_ID = P_ALT_ID_TB.P_SYS_ID
                WHERE P_ALT_ID_TB.P_ALT_ID_TY_CD = '1D'
                  AND P_ALT_ID_TB.P_ALT_ID_END_DT >= CURRENT_DATE
                  AND G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
                ORDER BY P_ALT_ID_TB.G_AUD_ADD_TS DESC
            ) sub
            LIMIT 1
        """,
    },
    "revalidation_due_date": {
        # NEW TABLE: P_DTL_EXT_TB — not previously encountered in this
        # project (PRV-ENR-L016 didn't reference it). No DDL for it
        # has been uploaded yet — same "candidate, unconfirmed" status
        # as the tables flagged in docs/schema/ets_dev/README.md until
        # its DDL arrives.
        "sql": """
            SELECT P_DTL_EXT_TB.P_REVLDTN_DUE_DT
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            JOIN P_DTL_EXT_TB
              ON P_DTL_TB.P_SYS_ID = P_DTL_EXT_TB.P_SYS_ID
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
}

# Shared params this letter's body uses (from shared/agency_params.py
# PROVIDER_RELATIONS_PARAMS — the widest subset of the three letters):
#   provider_appeals_unit (P1-114), prov_appeals_addr_line1 (P1-115),
#   prov_appeals_addr_line2 (P1-116), prov_appeals_number (P1-117),
#   provider_relations_website (P1-91), prov_rel_fax_number (P1-112),
#   provider_relations_email (P1-111), prov_rel_operation_hours (P1-113),
#   provider_relations_number (P1-89), provider_relations_tollfree (P1-90)
#
# RESOLVED: the legacy body text references "www.nhmmis.nh.gov" (the
# revalidation portal URL) as LITERAL TEMPLATE TEXT — it is NOT mapped
# to provider_relations_website (P1/91). The appeals/relations contact
# block (P1/91) is a separate field. Confirmed by project owner.

BARCODE_SYMBOLOGY = "qr"  # confirmed from legacy sample: 28x28pt square
LETTER_TITLE = "PROVIDER REVALIDATION FINAL NOTICE"
