"""
FastAPI dependencies. Each of these is a STUB with a clear TODO —
this file is the single place to swap in real auth/DB/queue
connections, rather than scattered across every router.
"""
from __future__ import annotations

from api.auth import AuthenticatedUser, ROLE_LETTERS_ADMIN, ROLE_LETTERS_EDITOR, ROLE_LETTERS_VIEWER


def get_current_user() -> AuthenticatedUser:
    """
    TODO: replace with real JWT verification (api.auth.decode_token,
    itself a stub — see that module's docstring) once the ETS
    platform's real auth is confirmed. Currently returns a fixed
    all-roles user so the OTHER pieces (routing, services, UI wiring)
    can be built and reasoned about without being blocked on auth
    being finalized first — this is a deliberately narrow, disclosed
    stub, not a security decision. Do not deploy this as-is.
    """
    return AuthenticatedUser(
        user_id="stub-user",
        roles=[ROLE_LETTERS_VIEWER, ROLE_LETTERS_EDITOR, ROLE_LETTERS_ADMIN],
        workspace="Provider SIT",
    )


def get_db_cursor():
    """
    Yields a real ets_dev connection if credentials are configured
    (middleware/db_connection.py, reading from environment variables —
    see .env.example), otherwise returns None. Every service function
    that takes a cursor already handles cursor=None as "no live DB"
    rather than crashing (see letters_service.list_letter_types), so
    the API stays usable for UI development even without a database
    connection configured.

    Untested end-to-end in this sandbox — no network access to reach
    any Postgres instance. The env-var-driven config itself (missing-
    var detection, PgBouncer transaction-mode handling) is unit-tested
    directly in middleware/db_connection.py without needing a live
    connection.
    """
    import sys
    from pathlib import Path

    sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "middleware"))
    from db_connection import get_connection, MissingCredentialsError

    try:
        conn = get_connection()
    except MissingCredentialsError:
        yield None
        return
    except ImportError:
        # psycopg2 not installed — same "usable without live infra" fallback
        yield None
        return

    try:
        yield conn.cursor()
    finally:
        conn.close()


def get_publish_fn():
    """
    TODO: replace with queue.producer.publish_batch once a live
    RabbitMQ connection exists. Returns a no-op that reports 0
    published rather than raising, consistent with get_db_cursor's
    "usable without live infra" approach.
    """
    def _noop_publish(records: list[dict]) -> int:
        return 0
    return _noop_publish
