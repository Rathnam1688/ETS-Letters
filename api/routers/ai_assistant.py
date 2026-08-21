"""
Routes backing the Workspace page's AI assistant prompt bar. Thin
wiring over ai-assistant/code_assistant.py, which itself needs a
reachable Ollama/vLLM + Milvus (see that module's own status notes) —
neither available in this sandbox. This router is therefore also
untested end-to-end, same disclosed status as the rest of api/routers/
(see api/README.md).
"""
from __future__ import annotations

import sys
from pathlib import Path

from pydantic import BaseModel
from fastapi import APIRouter, Depends, HTTPException

from api.auth import AuthenticatedUser, ROLE_LETTERS_EDITOR
from api.deps import get_current_user

sys.path.insert(0, str(Path(__file__).resolve().parent.parent.parent / "ai-assistant"))

try:
    from code_assistant import draft_template  # noqa: E402
except Exception:
    # Graceful fallback when optional langchain / vector DB packages are not present
    def draft_template(instruction: str, template_format: str = "html") -> str:
        raise RuntimeError("AI Assistant backend (Ollama/Milvus) is not currently reachable.")

router = APIRouter(prefix="/ai-assistant", tags=["ai-assistant"])


class DraftRequest(BaseModel):
    instruction: str
    template_format: str = "html"


@router.post("/draft")
def draft(
    body: DraftRequest,
    user: AuthenticatedUser = Depends(get_current_user),
):
    if ROLE_LETTERS_EDITOR not in user.roles:
        raise HTTPException(status_code=403, detail="Requires letters:editor role")
    try:
        code = draft_template(body.instruction, body.template_format)
        return {"code": code}
    except Exception as e:  # noqa: BLE001
        # Genuinely broad on purpose here: this calls out to a local
        # LLM + vector DB, neither reachable in this sandbox, and the
        # failure modes (connection refused, empty retrieval, model
        # not pulled) aren't something to guess at without seeing one
        # actually happen against real infra.
        raise HTTPException(status_code=502, detail=f"AI assistant unavailable: {e}")
