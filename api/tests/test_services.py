"""
Run with: pytest api/tests/ -q
"""
import sys
from pathlib import Path
from unittest.mock import MagicMock

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from services import letters_service, templates_service  # noqa: E402


# ---- letters_service ----

def test_list_letter_types_without_db_returns_zero_pending():
    results = letters_service.list_letter_types(cursor=None)
    assert len(results) == 4
    assert all(r.pending_count == 0 for r in results)
    labels = {r.letter_type: r.label for r in results}
    assert labels["PRV-ENR-L016"] == "EFT Enrollment Application"


def test_list_letter_types_with_mocked_db_returns_real_counts():
    fake_cursor = MagicMock()
    fake_cursor.fetchall.return_value = [(1,), (2,), (3,)]
    results = letters_service.list_letter_types(cursor=fake_cursor)
    assert all(r.pending_count == 3 for r in results)


def test_trigger_generation_rejects_unknown_letter_type():
    try:
        letters_service.trigger_generation(MagicMock(), "NOT-A-REAL-LETTER", MagicMock())
        assert False, "should have raised"
    except ValueError as e:
        assert "Unknown letter type" in str(e)


def test_trigger_generation_returns_json_serializable_dict():
    fake_cursor = MagicMock()
    fake_cursor.fetchall.return_value = [(42,)]
    fake_publish = MagicMock(return_value=1)

    result = letters_service.trigger_generation(fake_cursor, "PRV-MNT-L001", fake_publish)

    assert result["letter_type"] == "PRV-MNT-L001"
    assert result["records_found"] == 1
    assert result["record_ids"] == [42]
    assert isinstance(result["polled_at"], str)  # datetime serialized, not a raw object


# ---- templates_service ----

def test_read_template_reads_real_file():
    result = templates_service.read_template("PRV-ENR-L016")
    assert result["filename"] == "prv_enr_l016.html"
    assert "Provider Name" in result["content"]


def test_read_template_unknown_letter_type_raises():
    try:
        templates_service.read_template("NOT-A-REAL-LETTER")
        assert False, "should have raised"
    except templates_service.TemplateNotFoundError:
        pass


def test_write_template_validates_and_rejects_broken_jinja():
    result = templates_service.write_template(
        "PRV-ENR-L016", "{{ unclosed_tag", validate=True
    )
    assert result["saved"] is False
    assert len(result["errors"]) > 0


def test_write_template_roundtrip(tmp_path, monkeypatch):
    # Use a scratch copy so this test doesn't mutate the real template
    import shutil
    scratch_dir = tmp_path / "templates"
    scratch_dir.mkdir()
    shutil.copy(
        templates_service.TEMPLATE_DIR / "prv_mnt_l001.html",
        scratch_dir / "prv_mnt_l001.html",
    )
    monkeypatch.setattr(templates_service, "TEMPLATE_DIR", scratch_dir.resolve())

    new_content = "<html><body>{{ fields.letter_date }}</body></html>"
    result = templates_service.write_template("PRV-MNT-L001", new_content)
    assert result["saved"] is True

    read_back = templates_service.read_template("PRV-MNT-L001")
    assert read_back["content"] == new_content


def test_list_editable_templates():
    templates = templates_service.list_editable_templates()
    assert len(templates) == 4
    assert {"letter_type": "PRV-ENR-L016", "filename": "prv_enr_l016.html"} in templates
