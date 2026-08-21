"""
Run with: pytest api/tests/ -q

Only covers what's testable without a real JWT/JWKS setup: the
require_role decorator's pass/fail logic. decode_token itself is a
stub (see api/auth.py docstring) and is NOT tested here since there's
nothing real to test yet.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

import auth  # noqa: E402


def test_require_role_allows_user_with_role():
    user = auth.AuthenticatedUser(user_id="u1", roles=[auth.ROLE_LETTERS_EDITOR])

    @auth.require_role(auth.ROLE_LETTERS_EDITOR)
    def protected(user=None):
        return "ok"

    assert protected(user=user) == "ok"


def test_require_role_blocks_user_without_role():
    user = auth.AuthenticatedUser(user_id="u2", roles=[auth.ROLE_LETTERS_VIEWER])

    @auth.require_role(auth.ROLE_LETTERS_ADMIN)
    def protected(user=None):
        return "ok"

    try:
        protected(user=user)
        assert False, "should have raised"
    except auth.AuthError as e:
        assert e.status_code == 403


def test_require_role_blocks_missing_user():
    @auth.require_role(auth.ROLE_LETTERS_VIEWER)
    def protected(user=None):
        return "ok"

    try:
        protected(user=None)
        assert False, "should have raised"
    except auth.AuthError as e:
        assert e.status_code == 401


def test_decode_token_is_a_disclosed_stub_not_silently_fake():
    """Confirms decode_token fails loudly rather than pretending to work —
    important because a silent fake-auth stub would be a real security bug
    if this ever got deployed without being wired up for real."""
    try:
        auth.decode_token("fake.token.here")
        assert False, "stub should raise, not silently succeed"
    except NotImplementedError:
        pass
