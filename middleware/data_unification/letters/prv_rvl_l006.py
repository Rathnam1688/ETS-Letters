"""
PRV-RVL-L006 — Provider Revalidation Received (New Hampshire DHHS
Medicaid, NHMMIS52E2).

Shared agency letterhead fields are NOT repeated here — see
middleware/data_unification/shared/agency_params.py. This letter's
body also uses the shared Provider Relations contact block (operation
hours, phone, tollfree) from the same shared module — confirmed by
matching R_FUNC_AREA_CD/R_PARAM_NUM pairs against
PRV-RVL-L003's identical queries for the same fields.

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
        # NOTE: different query shape from PRV-MNT-L001's "provider_id"
        # (that one uses a MAX(P_ALT_ID_SK) subquery; this one filters
        # on P_ALT_ID_END_DT >= CURRENT_DATE and orders by
        # G_AUD_ADD_TS DESC with ROWNUM=1). Transcribed as given.
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
}

# Shared Provider Relations fields this letter's body uses (subset of
# middleware/data_unification/shared/agency_params.py PROVIDER_RELATIONS_PARAMS):
#   prov_rel_operation_hours (P1-113), provider_relations_number (P1-89),
#   provider_relations_tollfree (P1-90)
# Fetch via shared.agency_params.fetch_provider_relations_block(cursor)
# and pull just these three — don't re-query them here.

BARCODE_SYMBOLOGY = "qr"  # confirmed from legacy sample: 28x28pt square, not linear
LETTER_TITLE = "PROVIDER REVALIDATION RECEIVED"
