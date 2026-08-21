"""
PRV-MNT-L001 — 30-Day Recertification Notice (New Hampshire DHHS
Medicaid, NHMMIS52E2).

NOTE on source file naming: the uploaded "PRV-MNT-L001 Query.xlsx"
workbook's own "Letter" column header cell reads "PRV-RVL-L003" — a
copy-paste leftover from cloning a template workbook, not a real
letter mismatch (this file lives inside the PRV-MNT-L001 upload, and
its field list — license expiration date, "second reminder" body text
— matches the PRV-MNT-L001 legacy sample PDF, not PRV-RVL-L003's).
Flagged here rather than silently trusted or silently "fixed".

Shared agency letterhead fields (commissioner/director names, agency
address/contact) are NOT repeated here — see
middleware/data_unification/shared/agency_params.py.

Dialect: Oracle, as transcribed. Not yet converted to Postgres — see
prv_enr_l016.py's module docstring for the same caveat.
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
    "provider_id": {
        # NOTE: unlike RVL-L006/L003's "NH Medicaid Provider ID" query
        # (which orders by G_AUD_ADD_TS DESC + active-dates), this
        # letter's own workbook uses a MAX(P_ALT_ID_SK) subquery
        # instead — transcribed as given, not harmonized to match the
        # other two letters.
        "sql": """
            SELECT P_ALT_ID_TB.P_ALT_ID
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            JOIN P_ALT_ID_TB
              ON P_DTL_TB.P_SYS_ID = P_ALT_ID_TB.P_SYS_ID
            WHERE P_ALT_ID_TB.P_ALT_ID_TY_CD = '1D'
              AND P_ALT_ID_TB.P_ALT_ID_SK = (
                  SELECT MAX(P_ALT_ID_TB_2.P_ALT_ID_SK)
                  FROM P_ALT_ID_TB P_ALT_ID_TB_2
                  WHERE P_ALT_ID_TB_2.P_SYS_ID = P_ALT_ID_TB.P_SYS_ID
                    AND P_ALT_ID_TB_2.P_ALT_ID_TY_CD = '1D'
              )
              AND G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
    },
    "license_expiration_date": {
        "sql": """
            SELECT P_LIC_CERT_TB.P_LIC_CERT_END_DT
            FROM G_COTS_LTR_REQ_TB
            JOIN G_COTS_LTR_REQ_RECR_TB
              ON G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = G_COTS_LTR_REQ_RECR_TB.G_COTS_LTR_REQ_SK
            JOIN P_DTL_TB
              ON G_COTS_LTR_REQ_RECR_TB.G_CMN_ENTY_SK = P_DTL_TB.G_CMN_ENTY_SK
            JOIN P_LIC_CERT_TB
              ON P_DTL_TB.P_SYS_ID = P_LIC_CERT_TB.P_SYS_ID
            WHERE G_COTS_LTR_REQ_TB.G_COTS_LTR_REQ_SK = %(g_cots_ltr_req_sk)s
        """,
        # NOTE: no P_LIC_CERT_IND_CD='L' filter in this letter's own
        # workbook (unlike PRV-ENR-L016's provider_license_number
        # query, which does filter). Transcribed as given — may return
        # multiple rows if a provider has multiple license/cert
        # records; not resolved by the DSD, same category of open
        # question as PRV-ENR-L016's taxonomy tie-break was before
        # that got resolved. Flag for the same kind of resolution.
    },
}

# Barcode: Code128 linear (confirmed from legacy sample: 171x43pt at
# bottom-left, matching PRV-ENR-L016's dimensions), NOT a QR code —
# unlike PRV-RVL-L006/L003 which use QR. Encodes the zero-padded
# G_COTS_LTR_REQ_SK, same convention as PRV-ENR-L016.
BARCODE_SYMBOLOGY = "code128"
LETTER_FOOTER_LABEL = "30-Day Recertification Notice"
