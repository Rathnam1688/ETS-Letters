# API — Status

`pip install fastapi uvicorn pydantic` was not possible in the sandbox
this was built in (no network access). Split deliberately so most of
it could still be verified:

| Layer | Status |
|---|---|
| `services/letters_service.py`, `services/templates_service.py` | **Tested directly** — plain Python, no FastAPI import, 12/13 tests run and passed (`api/tests/`). Real file I/O against actual template files, not mocks, where practical. |
| `auth.py` (`require_role`, `AuthenticatedUser`) | **Tested directly** — the role-matching logic. `decode_token` is an intentionally loud stub (raises `NotImplementedError`, not a silent fake pass) — see its docstring. |
| `routers/*.py`, `main.py`, `deps.py` | **Untested — cannot import without FastAPI installed.** Thin wiring over the tested services; kept deliberately thin so bugs here are wiring bugs, not logic bugs. Review before trusting, same as any other untested code in this repo. |

Run the tests: `pip install fastapi uvicorn pydantic`, then
`python -m pytest api/tests/ -q` in a networked environment.

## Before this goes near production

1. Wire `deps.get_current_user` to real JWT verification once the ETS
   Data Platform's actual SSO/auth details are confirmed — see
   `auth.py`'s module docstring and `docs/PENDING.md`.
2. Wire `deps.get_db_cursor` / `get_publish_fn` to real `ets_dev` /
   RabbitMQ connections.
3. Restrict `main.py`'s CORS origins — wide open is for local dev only.
