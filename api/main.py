"""
API entry point. Run with: uvicorn api.main:app --reload
(requires `pip install fastapi uvicorn` — not available in this
sandbox, no network access; see api/README.md for what has and hasn't
been executed here.)
"""
from __future__ import annotations

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from api.routers import letters, templates, ai_assistant

app = FastAPI(
    title="Document Hub API",
    description="Backend for the Letters section — Generate, Workspace (edit), Job Runs, Visual QA pages.",
    version="0.1.0",
)

# TODO: restrict to the real host portal's origin once known (BR-05 —
# this MFE mounts into an existing host application). Wide open for
# local dev only.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(letters.router)
app.include_router(templates.router)
app.include_router(ai_assistant.router)


@app.get("/health")
def health():
    return {"status": "ok"}
