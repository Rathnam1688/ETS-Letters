from fastapi.testclient import TestClient
from api.main import app

client = TestClient(app)


def test_health_route():
    r = client.get('/health')
    assert r.status_code == 200
    assert r.json() == {'status': 'ok'}


def test_list_letters_route():
    r = client.get('/letters/')
    assert r.status_code == 200
    letters = r.json()
    assert len(letters) == 4
    types = [item['letter_type'] for item in letters]
    assert 'PRV-ENR-L016' in types
    assert 'PRV-MNT-L001' in types


def test_trigger_generation_route():
    r = client.post('/letters/PRV-ENR-L016/generate')
    assert r.status_code == 200
    assert r.json()['letter_type'] == 'PRV-ENR-L016'


def test_trigger_generation_unknown_type_returns_404():
    r = client.post('/letters/UNKNOWN-TYPE/generate')
    assert r.status_code == 404


def test_list_templates_route():
    r = client.get('/templates/')
    assert r.status_code == 200
    templates = r.json()
    assert len(templates) == 4


def test_read_template_route():
    r = client.get('/templates/PRV-ENR-L016')
    assert r.status_code == 200
    assert 'content' in r.json()
    assert len(r.json()['content']) > 100


def test_read_template_unknown_returns_404():
    r = client.get('/templates/NON-EXISTENT')
    assert r.status_code == 404


def test_write_template_validate_only():
    r = client.put('/templates/PRV-ENR-L016', json={'content': '<html>Valid</html>', 'validate_only': True})
    assert r.status_code == 200
    assert r.json()['errors'] == []
    assert r.json()['dry_run'] is True


def test_write_template_invalid_syntax():
    r = client.put('/templates/PRV-ENR-L016', json={'content': '<html>{% unclosed', 'validate_only': True})
    assert r.status_code == 200
    assert len(r.json()['errors']) > 0


def test_ai_assistant_draft_error_returns_502():
    r = client.post('/ai-assistant/draft', json={'instruction': 'Create header', 'template_format': 'html'})
    assert r.status_code == 502
