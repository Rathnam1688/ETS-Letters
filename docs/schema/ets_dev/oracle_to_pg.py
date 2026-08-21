"""
Pragmatic Oracle -> Postgres DDL converter for the ets_dev unification.
Regex-based (no sqlparse available offline) — good enough for the
fairly uniform export format these files share. Flags anything it
can't safely translate (PL/SQL triggers) rather than guessing.
"""
import re
import sys
from pathlib import Path

TARGET_SCHEMA = "ets_dev"

TYPE_MAP_SIMPLE = {
    "CLOB": "TEXT",
    "BLOB": "BYTEA",
}

def convert_type(type_str: str) -> str:
    type_str = type_str.strip()
    # VARCHAR2(n BYTE) / VARCHAR2(n CHAR) -> VARCHAR(n)
    m = re.match(r'VARCHAR2\((\d+)\s*(?:BYTE|CHAR)?\)', type_str)
    if m:
        return f"VARCHAR({m.group(1)})"
    # NUMBER(p,s)
    m = re.match(r'NUMBER\((\d+),\s*(\d+)\)', type_str)
    if m:
        p, s = int(m.group(1)), int(m.group(2))
        if s == 0:
            if p <= 4: return "SMALLINT"
            if p <= 9: return "INTEGER"
            return "BIGINT"
        return f"NUMERIC({p},{s})"
    # NUMBER(p) no scale
    m = re.match(r'NUMBER\((\d+)\)', type_str)
    if m:
        p = int(m.group(1))
        if p <= 4: return "SMALLINT"
        if p <= 9: return "INTEGER"
        return "BIGINT"
    if type_str == "NUMBER":
        return "NUMERIC"
    # TIMESTAMP (6) -> TIMESTAMP
    m = re.match(r'TIMESTAMP\s*\(\d+\)', type_str)
    if m:
        return "TIMESTAMP"
    if type_str == "DATE":
        return "TIMESTAMP"  # Oracle DATE includes time; Postgres DATE doesn't
    for k, v in TYPE_MAP_SIMPLE.items():
        if type_str.startswith(k):
            return v
    return type_str  # unknown — pass through, flagged by caller


def convert_file(src: Path, dest: Path, warnings: list):
    text = src.read_text(encoding="utf-8", errors="replace")

    # Bail out / flag PL/SQL triggers rather than mistranslate them
    if re.search(r'CREATE OR REPLACE.*TRIGGER', text, re.IGNORECASE):
        warnings.append(f"{src.name}: contains a PL/SQL TRIGGER — not auto-converted, needs manual plpgsql rewrite (left as a comment block)")
        text = re.sub(
            r'(CREATE OR REPLACE EDITIONABLE TRIGGER.*?END\s+\w+;\s*/\s*ALTER TRIGGER.*?ENABLE;)',
            lambda m: "/* TODO(ets_dev): Oracle PL/SQL trigger not auto-converted — rewrite as a Postgres trigger function.\n" + m.group(1) + "\n*/",
            text, flags=re.IGNORECASE | re.DOTALL,
        )

    # Rewrite ONLY known source schema qualifiers -> "ets_dev"
    # (a blanket quoted-dot-quoted regex over-matches COMMENT ON COLUMN
    # "SCHEMA"."TABLE"."COL" and double-rewrites the table part too)
    known_schemas = ["NHMMIS52E2", "NDMMIS73E2", "NDMMIS75E2", "TXT2SQL_APP"]
    for schema in known_schemas:
        text = re.sub(rf'"{schema}"\.', f'"{TARGET_SCHEMA}".', text)

    # Strip Oracle storage/segment noise (whole clause chunks)
    strip_patterns = [
        r'\s*SEGMENT CREATION IMMEDIATE\s*',
        r'\s*PCTFREE \d+ PCTUSED \d+ INITRANS \d+ MAXTRANS \d+\s*',
        r'\s*PCTFREE \d+ INITRANS \d+ MAXTRANS \d+ COMPUTE STATISTICS(?: COMPRESS ADVANCED LOW)?\s*',
        r'\s*ROW STORE COMPRESS ADVANCED(?: LOGGING)?\s*',
        r'\s*STORAGE\([^)]*\)\s*',

        r'\s*SUPPLEMENTAL LOG (?:DATA \([^)]*\) COLUMNS|GROUP "[^"]*" \([^)]*\) ALWAYS),?\s*',
        r'\s*ENABLE\b',
        r'\s*USING INDEX "ets_dev"\."[^"]*"\s*',
    ]
    for pat in strip_patterns:
        text = re.sub(pat, ' ', text, flags=re.IGNORECASE)

    # TABLESPACE clause is the last thing before the statement's terminating
    # semicolon in the source — strip it but KEEP the semicolon, or the next
    # statement silently merges into this one (real syntax bug otherwise).
    text = re.sub(r'\s*TABLESPACE "[^"]*"\s*;', ';', text, flags=re.IGNORECASE)

    # DEFAULT SYSDATE -> DEFAULT CURRENT_TIMESTAMP
    text = re.sub(r'DEFAULT SYSDATE', 'DEFAULT CURRENT_TIMESTAMP', text, flags=re.IGNORECASE)

    # Convert column type declarations: "COL_NAME" TYPE(...)  -> keep name, map type
    def col_type_sub(m):
        col, typ = m.group(1), m.group(2)
        return f'"{col}" {convert_type(typ)}'
    text = re.sub(
        r'"([A-Z0-9_]+)"\s+(VARCHAR2\(\d+\s*(?:BYTE|CHAR)?\)|NUMBER(?:\(\d+(?:,\s*\d+)?\))?|TIMESTAMP\s*\(\d+\)|DATE|CLOB|BLOB)',
        col_type_sub, text,
    )

    # Tidy up leftover blank lines / trailing spaces from stripped clauses
    text = re.sub(r'[ \t]+\n', '\n', text)
    text = re.sub(r'\n{3,}', '\n\n', text)
    text = re.sub(r',\s*\)', '\n)', text)  # dangling trailing comma before close paren

    dest.write_text(text, encoding="utf-8")


if __name__ == "__main__":
    src_dir = Path(sys.argv[1])
    dest_dir = Path(sys.argv[2])
    dest_dir.mkdir(parents=True, exist_ok=True)
    warnings = []
    for f in sorted(src_dir.glob("*.sql")) + sorted(src_dir.glob("*.txt")):
        out_name = f.stem + ".sql"
        convert_file(f, dest_dir / out_name, warnings)
    for w in warnings:
        print("WARNING:", w)
    print(f"Converted {len(list(src_dir.glob('*.sql')) + list(src_dir.glob('*.txt')))} files -> {dest_dir}")
