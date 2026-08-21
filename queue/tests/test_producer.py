"""
Run with: pytest queue/tests/ -q
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from producer import split_iwa_batch  # noqa: E402


def test_split_iwa_batch_tags_each_letter_with_batch_id():
    fake_batch = {
        "batch_id": "BATCH-2026-08-09-001",
        "letters": [{"letter_id": f"LTR-{i:04d}", "letter_type": "REMITTANCE_ADVICE"} for i in range(3)],
    }
    records = split_iwa_batch(fake_batch)
    assert len(records) == 3
    assert all(r["batch_id"] == "BATCH-2026-08-09-001" for r in records)
    assert [r["letter_id"] for r in records] == ["LTR-0000", "LTR-0001", "LTR-0002"]


def test_split_iwa_batch_handles_empty_letters():
    assert split_iwa_batch({"batch_id": "EMPTY", "letters": []}) == []
