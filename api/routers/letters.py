"""
Routes backing the "Generate Letters" UI page.

Thin wiring over api/services/letters_service.py — all real logic
lives there and is tested independent of FastAPI (not installed in
this sandbox — no network access to verify this file actually runs;
see api/README.md). Keep it that way: if a bug shows up here, it
should be a wiring bug, not a logic bug the tests should have caught.
"""
from __future__ import annotations

from fastapi import APIRouter, Depends, HTTPException

from api.auth import AuthenticatedUser, ROLE_LETTERS_ADMIN, ROLE_LETTERS_VIEWER
from api.deps import get_current_user, get_db_cursor, get_publish_fn
from api.services import letters_service

router = APIRouter(prefix="/letters", tags=["letters"])


@router.get("/")
def list_letters(
    user: AuthenticatedUser = Depends(get_current_user),
    cursor=Depends(get_db_cursor),
):
    if ROLE_LETTERS_VIEWER not in user.roles:
        raise HTTPException(status_code=403, detail="Requires letters:viewer role")
    return [vars(info) for info in letters_service.list_letter_types(cursor)]


@router.post("/{letter_type}/generate")
def generate_letter(
    letter_type: str,
    user: AuthenticatedUser = Depends(get_current_user),
    cursor=Depends(get_db_cursor),
    publish_fn=Depends(get_publish_fn),
):
    if ROLE_LETTERS_ADMIN not in user.roles:
        raise HTTPException(status_code=403, detail="Requires letters:admin role to trigger generation")
    try:
        return letters_service.trigger_generation(cursor, letter_type, publish_fn)
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
