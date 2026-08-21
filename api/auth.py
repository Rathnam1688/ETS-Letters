"""
JWT verification + RBAC role-checking.

Written generic and swappable, NOT tied to a specific identity
provider, because the actual ETS Data Platform this "Letters" section
is being integrated into almost certainly already has its own SSO
(the platform screenshot shows a signed-in user, workspace-scoped
access — "Provider SIT"). Bolting on a separate auth system here would
likely fight that platform's real auth rather than use it.

This module is a reasonable-default placeholder: standard JWT
signature/expiry verification plus a role-based decorator, built so
that swapping in the platform's real token issuer/verification
endpoint is a config change (JWKS_URL, ISSUER, AUDIENCE below), not a
rewrite of every route. Confirm with whoever owns the ETS platform's
auth before relying on this as-is — see docs/PENDING.md.

Untestable end-to-end in this sandbox: no network access to fetch a
real JWKS keyset, and `pyjwt`/`python-jose` aren't installed here
either. The pure logic below (role-matching, error shapes) is
structured to be testable independent of actual token verification —
see api/tests/test_auth.py for what could be checked without a real
IdP.
"""
from __future__ import annotations

from dataclasses import dataclass
from functools import wraps

# TODO: replace with the ETS platform's real values once confirmed.
JWKS_URL = "https://CONFIRM-WITH-PLATFORM-OWNER/.well-known/jwks.json"
ISSUER = "CONFIRM-WITH-PLATFORM-OWNER"
AUDIENCE = "document-hub-letters"


class AuthError(Exception):
    def __init__(self, message: str, status_code: int = 401):
        super().__init__(message)
        self.status_code = status_code


@dataclass
class AuthenticatedUser:
    user_id: str
    roles: list[str]
    workspace: str | None = None  # e.g. "Provider SIT", matching the platform's workspace model


# Roles this module expects to exist. Confirm these match the real
# platform's role names before wiring RBAC checks to them — a mismatch
# here fails closed (raises AuthError), which is the safe direction to
# fail, but still worth getting right rather than discovering it in
# an access-denied bug report.
ROLE_LETTERS_VIEWER = "letters:viewer"      # can see Job Runs, Generate Letters
ROLE_LETTERS_EDITOR = "letters:editor"      # can edit templates in Workspace
ROLE_LETTERS_ADMIN = "letters:admin"        # can trigger generation, manage KB


def decode_token(token: str) -> AuthenticatedUser:
    """
    Verify a JWT's signature/expiry/issuer/audience and extract the
    user + roles claim.

    STUB: real implementation needs `pyjwt` (or the platform's own
    verification helper if it exposes one) and a live JWKS endpoint —
    neither available in this sandbox. Wire this up against the real
    values once confirmed; don't ship this stub as-is.
    """
    raise NotImplementedError(
        "decode_token is a stub — wire up real JWT verification "
        "(pyjwt + JWKS_URL) once the ETS platform's real auth details are confirmed. "
        "See docs/PENDING.md."
    )


def require_role(required_role: str):
    """
    Decorator for route handlers: raises AuthError(403) if the
    authenticated user lacks `required_role`. Expects the route
    handler to receive `user: AuthenticatedUser` as a kwarg (FastAPI
    dependency injection wires this — see api/routers/*.py).
    """
    def decorator(fn):
        @wraps(fn)
        def wrapper(*args, **kwargs):
            user: AuthenticatedUser | None = kwargs.get("user")
            if user is None:
                raise AuthError("No authenticated user in request context", status_code=401)
            if required_role not in user.roles:
                raise AuthError(
                    f"User {user.user_id} lacks required role '{required_role}'",
                    status_code=403,
                )
            return fn(*args, **kwargs)
        return wrapper
    return decorator
