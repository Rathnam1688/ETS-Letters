import React, { useEffect, useState } from "react";
import { PlayCircle, RefreshCw, Sparkles } from "lucide-react";

const API_BASE = import.meta?.env?.VITE_API_BASE ?? "http://localhost:8000";

// The missing 4th page identified alongside Workspace (edit)/Job Runs
// (monitor)/Visual QA (validate): a place to see letter types and
// actually trigger generation, backed by GET /letters and
// POST /letters/{type}/generate (api/routers/letters.py).
export default function GenerateLetters() {
  const [letters, setLetters] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [triggering, setTriggering] = useState(null);

  async function loadLetters() {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch(`${API_BASE}/letters/`, {
        headers: { Authorization: `Bearer ${localStorage.getItem("auth_token") ?? ""}` },
      });
      if (!res.ok) throw new Error(`API returned ${res.status}`);
      setLetters(await res.json());
    } catch (e) {
      // API isn't running in this sandbox (no FastAPI installed — see
      // api/README.md); surface the real error rather than silently
      // falling back to fake data, so this is honest about its state
      // once actually deployed too.
      setError(e.message);
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    loadLetters();
  }, []);

  async function handleGenerate(letterType) {
    setTriggering(letterType);
    try {
      const res = await fetch(`${API_BASE}/letters/${letterType}/generate`, {
        method: "POST",
        headers: { Authorization: `Bearer ${localStorage.getItem("auth_token") ?? ""}` },
      });
      if (!res.ok) throw new Error(`API returned ${res.status}`);
      await loadLetters(); // refresh pending counts after triggering
    } catch (e) {
      setError(e.message);
    } finally {
      setTriggering(null);
    }
  }

  return (
    <div className="h-full overflow-auto p-6">
      <div className="mb-4 flex items-center justify-between">
        <h2 className="text-base font-semibold">Generate Letters</h2>
        <button
          onClick={loadLetters}
          className="flex items-center gap-2 rounded border border-border px-3 py-1.5 text-xs text-ink-muted hover:text-ink hover:bg-canvas-raised"
        >
          <RefreshCw size={14} />
          Refresh
        </button>
      </div>

      {error && (
        <div className="mb-4 rounded border border-status-failed/40 bg-status-failed/10 px-3 py-2 text-xs text-status-failed">
          {error} — the backend API needs to be running (see api/README.md) and
          pointed at a real ets_dev connection for live counts.
        </div>
      )}

      {loading ? (
        <div className="text-xs text-ink-muted">Loading…</div>
      ) : (
        <table className="w-full border-collapse text-xs">
          <thead>
            <tr className="border-b border-border text-left text-ink-muted">
              <th className="py-2 font-medium">Letter Type</th>
              <th className="py-2 font-medium">Description</th>
              <th className="py-2 font-medium">Pending Records</th>
              <th className="py-2 font-medium"></th>
            </tr>
          </thead>
          <tbody>
            {letters.map((letter) => (
              <tr key={letter.letter_type} className="border-b border-border-subtle hover:bg-canvas-raised">
                <td className="py-2 font-mono text-ink">{letter.letter_type}</td>
                <td className="py-2 text-ink-muted">{letter.label}</td>
                <td className="py-2">
                  {letter.pending_count > 0 ? (
                    <span className="rounded bg-status-running/15 px-2 py-0.5 text-status-running">
                      {letter.pending_count} pending
                    </span>
                  ) : (
                    <span className="text-ink-faint">none</span>
                  )}
                </td>
                <td className="py-2 text-right">
                  <button
                    onClick={() => handleGenerate(letter.letter_type)}
                    disabled={triggering === letter.letter_type}
                    className="flex items-center gap-1.5 rounded bg-brand px-2.5 py-1 text-xs font-medium text-white hover:bg-brand-hover disabled:opacity-50"
                  >
                    <PlayCircle size={13} />
                    {triggering === letter.letter_type ? "Triggering…" : "Generate now"}
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}

      <div className="mt-6 flex items-start gap-2 rounded border border-border bg-canvas-panel px-3 py-2 text-xs text-ink-muted">
        <Sparkles size={14} className="mt-0.5 shrink-0 text-brand" />
        <p>
          A scheduled poller also checks these letter types every 15 minutes
          (see <code className="text-ink">infra/k8s/db-poller-cronjob.yaml</code>) —
          this page's "Generate now" is a manual trigger for the same underlying
          path, not a separate mechanism.
        </p>
      </div>
    </div>
  );
}
