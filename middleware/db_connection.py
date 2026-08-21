"""
Shared Postgres connection factory for ets_dev.

Credentials come from environment variables ONLY — never hardcoded in
this file or any other file in this repo. See .env.example for the
variables this expects; copy it to .env (already gitignored) and fill
in real values locally, or set them directly in your deployment
environment (K8s Secret, etc. — see infra/k8s/db-poller-cronjob.yaml
for the pattern already used elsewhere in this repo).

Untested in this sandbox: no network access to install psycopg2 or
reach any Postgres instance, live or otherwise. Written to the
documented psycopg2 API; verify with a real `pip install psycopg2-binary`
in a networked environment before trusting it.

IMPORTANT — connection pooling mode: if PGPORT is 6543 (Supabase's
"Transaction pooler" / PgBouncer transaction mode, as opposed to 5432
direct or 5433 session pooler), several Postgres features behave
differently and this factory accounts for that:
  - Prepared statements don't survive across pooled connections
    reliably in transaction mode — psycopg2's default statement
    caching can produce "prepared statement does not exist" errors
    under load. This factory disables psycopg2's server-side cursor
    reuse for that reason (see PGBOUNCER_TRANSACTION_MODE below).
  - Session-level SET statements (e.g. SET search_path) don't persist
    reliably either — every query should be self-contained rather than
    relying on session state set by a previous query.
If you're not actually behind PgBouncer transaction mode (e.g. a
direct connection or session-mode pooler), set PGBOUNCER_TRANSACTION_MODE=false.
"""
from __future__ import annotations

import os
from pathlib import Path

try:
    from dotenv import load_dotenv
    # Load .env from project root or current working directory
    env_path = Path(__file__).resolve().parent.parent / ".env"
    if env_path.exists():
        load_dotenv(dotenv_path=env_path, interpolate=False)
    else:
        load_dotenv(interpolate=False)
except ImportError:
    pass


class MissingCredentialsError(Exception):
    pass


REQUIRED_ENV_VARS = ["PGHOST", "PGPORT", "PGUSER", "PGPASSWORD", "PGDATABASE"]


def _read_config() -> dict:
    missing = [v for v in REQUIRED_ENV_VARS if not os.environ.get(v)]
    if missing:
        raise MissingCredentialsError(
            f"Missing required environment variables: {missing}. "
            f"Copy .env.example to .env and fill in real values, or set "
            f"these in your deployment environment. Never hardcode "
            f"credentials in source files."
        )
    return {
        "host": os.environ["PGHOST"],
        "port": int(os.environ["PGPORT"]),
        "user": os.environ["PGUSER"],
        "password": os.environ["PGPASSWORD"],
        "dbname": os.environ["PGDATABASE"],
        "sslmode": os.environ.get("PGSSLMODE", "require"),  # require by default — this DB is reached over the public internet
        "options": "-c search_path=ets_dev,public",
    }


def is_pgbouncer_transaction_mode() -> bool:
    """
    Best-effort default: Supabase's transaction pooler is conventionally
    on port 6543. Override explicitly with PGBOUNCER_TRANSACTION_MODE=
    true/false if your setup differs — don't rely on the port-number
    guess for anything that matters.
    """
    explicit = os.environ.get("PGBOUNCER_TRANSACTION_MODE")
    if explicit is not None:
        return explicit.lower() in ("true", "1", "yes")
    return os.environ.get("PGPORT") == "6543"


def get_connection():
    """
    Returns a live psycopg2 connection. Caller is responsible for
    closing it (use as a context manager: `with get_connection() as conn:`).

    Raises MissingCredentialsError if required env vars aren't set —
    deliberately fails loudly rather than silently falling back to
    anything, since a silent fallback here could mean queries running
    against nothing, or worse, an unintended database.
    """
    import psycopg2  # deferred import — keeps this module importable
                       # even where psycopg2 isn't installed, same
                       # pattern used elsewhere in this repo (e.g.
                       # queue/producer.py's lazy pika import) so pure
                       # logic that doesn't need a live connection can
                       # still be tested without the dependency present.

    config = _read_config()
    conn = psycopg2.connect(**config)

    if is_pgbouncer_transaction_mode():
        # Disable server-side named cursors / prepared statement reuse
        # that doesn't play well with PgBouncer transaction mode.
        conn.autocommit = True

    return conn


def get_cursor_context():
    """
    Convenience context manager: `with get_cursor_context() as cursor:`
    handles opening/closing the connection around one query or a small
    batch of queries — the right granularity under transaction-mode
    pooling, where holding a connection open across unrelated
    application logic works against the pooler's whole purpose.
    """
    from contextlib import contextmanager

    @contextmanager
    def _ctx():
        conn = get_connection()
        try:
            cur = conn.cursor()
            yield cur
            conn.commit()
        except Exception:
            conn.rollback()
            raise
        finally:
            conn.close()

    return _ctx()


if __name__ == "__main__":
    try:
        with get_cursor_context() as cur:
            cur.execute("SELECT 1")
            print("Connection OK:", cur.fetchone())
    except MissingCredentialsError as e:
        print("Not configured:", e)
    except ImportError:
        print("psycopg2 not installed — `pip install psycopg2-binary`")
