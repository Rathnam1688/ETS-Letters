"""
CI validation step (ci-cd/pipeline.yml: validate-templates).

Checks every template under rendering/templates/ is well-formed, and
once real XSDs are uploaded to the Knowledge Base (FR-05), validates
XML-based templates against them so a broken template fails the PR
instead of failing in production.
"""
from __future__ import annotations

import sys
import xml.etree.ElementTree as ET
from pathlib import Path

from jinja2 import Environment, FileSystemLoader, TemplateSyntaxError

KB_XSD_DIR = Path(__file__).resolve().parent.parent.parent / "ai-assistant" / "rag" / "kb_source"


def validate_jinja_syntax(template_path: Path) -> list[str]:
    """Confirm the template parses as valid Jinja (catches {{ }} typos etc.)."""
    errors = []
    env = Environment(loader=FileSystemLoader(str(template_path.parent)))
    try:
        env.get_template(template_path.name)
    except TemplateSyntaxError as e:
        errors.append(f"{template_path.name}: Jinja syntax error at line {e.lineno}: {e.message}")
    return errors


def validate_xml_wellformed(template_path: Path) -> list[str]:
    """
    For .fo.xsl templates: strip Jinja tags to a dummy value and confirm
    the resulting markup is well-formed XML. (Full CMS XSD validation
    happens once the real schema is in kb_source/ — see TODO below.)
    """
    errors = []
    if not template_path.name.endswith(".fo.xsl"):
        return errors

    raw = template_path.read_text(encoding="utf-8")
    # crude placeholder substitution just to check the surrounding XML shape
    import re
    stubbed = re.sub(r"{{.*?}}", "X", raw)
    stubbed = re.sub(r"{%.*?%}", "", stubbed)
    try:
        ET.fromstring(stubbed)
    except ET.ParseError as e:
        errors.append(f"{template_path.name}: not well-formed XML after stubbing: {e}")

    # TODO: once CMS XSDs are uploaded to kb_source/, validate here with
    # xmlschema against the matching schema for this letter type.
    if not KB_XSD_DIR.exists() or not any(KB_XSD_DIR.glob("*.xsd")):
        print(f"  (skipping XSD validation — no schemas found in {KB_XSD_DIR})")

    return errors


def main(template_dir: str) -> int:
    template_dir_path = Path(template_dir)
    all_errors: list[str] = []

    for template_path in sorted(template_dir_path.glob("*")):
        if template_path.suffix not in (".html", ".xsl"):
            continue
        print(f"Validating {template_path.name}...")
        all_errors.extend(validate_jinja_syntax(template_path))
        all_errors.extend(validate_xml_wellformed(template_path))

    if all_errors:
        print("\nValidation FAILED:")
        for err in all_errors:
            print(f"  - {err}")
        return 1

    print("\nAll templates valid.")
    return 0


if __name__ == "__main__":
    template_dir = sys.argv[1] if len(sys.argv) > 1 else "rendering/templates/"
    sys.exit(main(template_dir))
