"""
Shared agency letterhead + contact-info parameters.

Confirmed by comparing three independently-uploaded letters
(PRV-MNT-L001, PRV-RVL-L006, PRV-RVL-L003): the "STATE OF NEW
HAMPSHIRE / DEPARTMENT OF HEALTH AND HUMAN SERVICES / DIVISION OF
MEDICAID SERVICES" header block, commissioner/director names, and
agency contact info are byte-identical across all three (same measured
PDF coordinates, same text). This is system CONFIGURATION, not
per-letter content — sourced from R_PARAM_DTL_TB, keyed by
(R_FUNC_AREA_CD, R_PARAM_NUM), not hardcoded per letter. Any future
Provider-domain prose letter almost certainly reuses this same block —
check before duplicating these queries into a new letter module.

Each letter's own Query workbook repeats a subset of these same
R_PARAM_DTL_TB lookups (confirmed identical SQL shape across all three
uploads) — this module exists so that repetition isn't copy-pasted a
fourth time.

Dialect: Oracle, as transcribed. See prv_enr_l016.py's module docstring
for the same Oracle->Postgres conversion caveat — not yet done here
either.
"""
from __future__ import annotations

# (R_FUNC_AREA_CD, R_PARAM_NUM) -> field name, with the query SQL shape
# every letter re-derives identically. `active_only=True` fields add
# the R_PARAM_BEG_DT/END_DT effective-dating filter seen in the
# RVL-L006/L003 queries (MNT-L001's workbook queries the same table
# without that filter for the header-block params — kept faithful to
# each source rather than silently harmonized).
LETTERHEAD_PARAMS = {
    "commissioner_name":   ("G1", 130, False),
    "commissioner_title":  ("G1", 133, False),   # "Resource Title" — renders as "Commissioner"/"Director" label
    "medicaid_director_name": ("P1", 72, False),
    "director_title":      ("P1", 74, False),
    "division_name":       ("P1", 75, False),
    "agency_address_line1": ("P1", 76, False),
    "agency_address_line2": ("P1", 77, False),
    "toll_free_number":    ("P1", 79, False),
    "fax_label_and_number": ("P1", 80, False),
    "tdd_access_label_and_number": ("P1", 81, False),
    "website_address":     ("P1", 82, False),
}

# Provider Relations contact block — appears in letter BODY text (not
# header), used by RVL-L006/L003; MNT-L001's body has its own inline
# phone numbers instead (per its DSD — not sourced from R_PARAM_DTL_TB
# in that letter's own Query workbook, kept as literal text there).
PROVIDER_RELATIONS_PARAMS = {
    "prov_rel_operation_hours": ("P1", 113, True),
    "provider_relations_number": ("P1", 89, True),
    "provider_relations_tollfree": ("P1", 90, True),
    "provider_relations_website": ("P1", 91, True),
    "prov_rel_fax_number":  ("P1", 112, True),
    "provider_relations_email": ("P1", 111, True),
    "provider_appeals_unit": ("P1", 114, True),
    "prov_appeals_addr_line1": ("P1", 115, True),
    "prov_appeals_addr_line2": ("P1", 116, True),
    "prov_appeals_number":  ("P1", 117, True),
}


def build_param_query(func_area_cd: str, param_num: int, active_only: bool) -> str:
    """Return the SQL for one R_PARAM_DTL_TB lookup, as transcribed from
    the uploaded Query workbooks (verbatim shape, not invented)."""
    base = f"""
        SELECT R_PARAM_VALUE_DATA
        FROM R_PARAM_DTL_TB
        WHERE R_FUNC_AREA_CD = '{func_area_cd}'
          AND R_PARAM_NUM = {param_num}
    """
    if active_only:
        # In ets_dev, R_PARAM_END_DT / BEG_DT may be VARCHAR strings (e.g. '31-DEC-99')
        # or TIMESTAMP. Handle both safely in Postgres.
        base += """
          AND (
            R_PARAM_END_DT IS NULL
            OR R_PARAM_END_DT::text LIKE '%99'
            OR (CASE WHEN R_PARAM_END_DT::text ~ '^[0-9]{2}-[A-Za-z]{3}-[0-9]{2}$'
                     THEN TO_DATE(R_PARAM_END_DT::text, 'DD-Mon-YY') >= CURRENT_DATE
                     ELSE TRUE END)
          )
        """
    return base


def fetch_letterhead(cursor) -> dict:
    """Fetch the shared header-block values. Run once per render batch,
    not once per letter — these don't vary by recipient."""
    values = {}
    for name, (area, num, active_only) in LETTERHEAD_PARAMS.items():
        cursor.execute(build_param_query(area, num, active_only))
        row = cursor.fetchone()
        values[name] = row[0] if row else None
    return values


def fetch_provider_relations_block(cursor) -> dict:
    """Fetch the Provider Relations contact block used in several
    letters' body text (RVL-L006, RVL-L003 confirmed; check others
    before assuming universal)."""
    values = {}
    for name, (area, num, active_only) in PROVIDER_RELATIONS_PARAMS.items():
        cursor.execute(build_param_query(area, num, active_only))
        row = cursor.fetchone()
        values[name] = row[0] if row else None
    return values
