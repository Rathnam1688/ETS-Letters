"""
Backing logic for the Workspace (code editor) UI page. This is what
turns TemplateWorkspace.jsx from a hardcoded mockup into something
that reads and writes real files.

Deliberately restricted to rendering/templates/ — no arbitrary path
access, since this is reachable from a UI editor and must not become a
path-traversal hole.
"""
from __future__ import annotations

from pathlib import Path

TEMPLATE_DIR = (Path(__file__).resolve().parent.parent.parent / "rendering" / "templates").resolve()

# letter_type -> template filename. Extend as new letters are onboarded.
TEMPLATE_FILES = {
    "PRV-ENR-L016": "prv_enr_l016.html",
    "PRV-MNT-L001": "prv_mnt_l001.html",
    "PRV-RVL-L006": "prv_rvl_l006.html",
    "PRV-RVL-L003": "prv_rvl_l003.html",
}


class TemplateNotFoundError(Exception):
    pass


class UnsafePathError(Exception):
    """Raised if a resolved path somehow escapes TEMPLATE_DIR — should
    never happen given TEMPLATE_FILES is a fixed allowlist, but this is
    the kind of check that's cheap to keep even so."""


def _resolve_template_path(letter_type: str) -> Path:
    if letter_type not in TEMPLATE_FILES:
        raise TemplateNotFoundError(f"No template registered for '{letter_type}'")
    path = (TEMPLATE_DIR / TEMPLATE_FILES[letter_type]).resolve()
    if TEMPLATE_DIR not in path.parents and path != TEMPLATE_DIR:
        raise UnsafePathError(f"Resolved path {path} escapes template directory")
    return path


def read_template(letter_type: str) -> dict:
    path = _resolve_template_path(letter_type)
    if not path.exists():
        raise TemplateNotFoundError(f"Template file missing on disk: {path}")
    return {
        "letter_type": letter_type,
        "filename": path.name,
        "content": path.read_text(encoding="utf-8"),
    }


def write_template(letter_type: str, content: str, validate: bool = True, dry_run: bool = False) -> dict:
    """
    Save edited template content. Validates first (rendering/engine/
    validate_templates.py's checks) unless explicitly skipped — an
    editor UI should surface validation errors before letting someone
    save broken template syntax, not after.

    dry_run=True validates only and never writes to disk, regardless
    of whether validation passes — for the editor's "check without
    saving" action.
    """
    path = _resolve_template_path(letter_type)

    if validate or dry_run:
        errors = _validate_content(path.name, content)
        if errors:
            return {"saved": False, "errors": errors}

    if dry_run:
        return {"saved": False, "errors": [], "dry_run": True}

    path.write_text(content, encoding="utf-8")
    return {"saved": True, "errors": []}


def _validate_content(filename: str, content: str) -> list[str]:
    """Runs the same Jinja-syntax check as the CI pipeline
    (rendering/engine/validate_templates.py), against in-memory
    content rather than a file on disk, since the editor is validating
    unsaved edits."""
    from jinja2 import Environment, TemplateSyntaxError

    errors = []
    env = Environment()
    try:
        env.parse(content)
    except TemplateSyntaxError as e:
        errors.append(f"{filename}: Jinja syntax error at line {e.lineno}: {e.message}")
    return errors


def list_editable_templates() -> list[dict]:
    return [{"letter_type": lt, "filename": fn} for lt, fn in TEMPLATE_FILES.items()]
