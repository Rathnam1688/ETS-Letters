"""
Routes backing the Workspace (code editor) UI page. Thin wiring over
api/services/templates_service.py.
"""
from __future__ import annotations

from pydantic import BaseModel
from fastapi import APIRouter, Depends, HTTPException

from api.auth import AuthenticatedUser, ROLE_LETTERS_EDITOR, ROLE_LETTERS_VIEWER
from api.deps import get_current_user
from api.services import templates_service

router = APIRouter(prefix="/templates", tags=["templates"])


class TemplateWriteRequest(BaseModel):
    content: str
    validate_only: bool = False  # true = check for errors without saving


@router.get("/")
def list_templates(user: AuthenticatedUser = Depends(get_current_user)):
    if ROLE_LETTERS_VIEWER not in user.roles:
        raise HTTPException(status_code=403, detail="Requires letters:viewer role")
    return templates_service.list_editable_templates()


@router.get("/{letter_type}")
def read_template(letter_type: str, user: AuthenticatedUser = Depends(get_current_user)):
    if ROLE_LETTERS_VIEWER not in user.roles:
        raise HTTPException(status_code=403, detail="Requires letters:viewer role")
    try:
        return templates_service.read_template(letter_type)
    except templates_service.TemplateNotFoundError as e:
        raise HTTPException(status_code=404, detail=str(e))


@router.put("/{letter_type}")
def write_template(
    letter_type: str,
    body: TemplateWriteRequest,
    user: AuthenticatedUser = Depends(get_current_user),
):
    if ROLE_LETTERS_EDITOR not in user.roles:
        raise HTTPException(status_code=403, detail="Requires letters:editor role")
    try:
        result = templates_service.write_template(
            letter_type, body.content, validate=True, dry_run=body.validate_only,
        )
        return result
    except templates_service.TemplateNotFoundError as e:
        raise HTTPException(status_code=404, detail=str(e))
