import React, { useEffect, useState, useCallback } from "react";
import { Sparkles, Save, CheckCircle2, AlertTriangle } from "lucide-react";

const API_BASE = import.meta?.env?.VITE_API_BASE ?? "http://localhost:8000";

// Phase 5 PoC surface: real editor now, backed by
// api/routers/templates.py — GET loads real file content, PUT saves
// (with server-side validation) instead of a hardcoded SAMPLE_CODE
// string. AI Code Assistant wiring is still a TODO (see prompt bar
// below) — that endpoint doesn't exist in api/routers/ yet.
export default function TemplateWorkspace() {
  const [templates, setTemplates] = useState([]);
  const [activeType, setActiveType] = useState(null);
  const [code, setCode] = useState("");
  const [originalCode, setOriginalCode] = useState("");
  const [loading, setLoading] = useState(true);
  const [saveState, setSaveState] = useState("idle"); // idle | saving | saved | error
  const [validationErrors, setValidationErrors] = useState([]);
  const [prompt, setPrompt] = useState("");
  const [aiState, setAiState] = useState("idle"); // idle | thinking
  const [error, setError] = useState(null);

  const authHeaders = { Authorization: `Bearer ${localStorage.getItem("auth_token") ?? ""}` };

  useEffect(() => {
    fetch(`${API_BASE}/templates/`, { headers: authHeaders })
      .then((res) => {
        if (!res.ok) throw new Error(`API returned ${res.status}`);
        return res.json();
      })
      .then((list) => {
        setTemplates(list);
        if (list.length > 0) setActiveType(list[0].letter_type);
      })
      .catch((e) => setError(e.message))
      .finally(() => setLoading(false));
  }, []);

  useEffect(() => {
    if (!activeType) return;
    setLoading(true);
    fetch(`${API_BASE}/templates/${activeType}`, { headers: authHeaders })
      .then((res) => {
        if (!res.ok) throw new Error(`API returned ${res.status}`);
        return res.json();
      })
      .then((data) => {
        setCode(data.content);
        setOriginalCode(data.content);
        setValidationErrors([]);
        setSaveState("idle");
      })
      .catch((e) => setError(e.message))
      .finally(() => setLoading(false));
  }, [activeType]);

  const isDirty = code !== originalCode;

  const handleSave = useCallback(async () => {
    setSaveState("saving");
    try {
      const res = await fetch(`${API_BASE}/templates/${activeType}`, {
        method: "PUT",
        headers: { ...authHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ content: code, validate_only: false }),
      });
      const result = await res.json();
      if (!result.saved) {
        setValidationErrors(result.errors ?? ["Save failed for an unknown reason"]);
        setSaveState("error");
        return;
      }
      setValidationErrors([]);
      setOriginalCode(code);
      setSaveState("saved");
      setTimeout(() => setSaveState("idle"), 2000);
    } catch (e) {
      setError(e.message);
      setSaveState("error");
    }
  }, [activeType, code]);

  const handleAskAI = useCallback(async () => {
    if (!prompt.trim()) return;
    setAiState("thinking");
    try {
      const res = await fetch(`${API_BASE}/ai-assistant/draft`, {
        method: "POST",
        headers: { ...authHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ instruction: prompt, template_format: "html" }),
      });
      if (!res.ok) {
        const detail = (await res.json().catch(() => ({}))).detail ?? `API returned ${res.status}`;
        throw new Error(detail);
      }
      const { code: draftedCode } = await res.json();
      setCode(draftedCode);
      setPrompt("");
    } catch (e) {
      setError(e.message);
    } finally {
      setAiState("idle");
    }
  }, [prompt]);

  return (
    <div className="flex h-full flex-col">
      {/* Tab bar */}
      <div className="flex items-center border-b border-border bg-canvas-panel">
        {templates.map((t) => (
          <button
            key={t.letter_type}
            onClick={() => setActiveType(t.letter_type)}
            className={`flex items-center gap-2 border-r border-border px-4 py-2 text-xs ${
              activeType === t.letter_type ? "bg-canvas text-ink" : "text-ink-muted hover:text-ink"
            }`}
          >
            {t.filename}
            {activeType === t.letter_type && isDirty && (
              <span className="h-1.5 w-1.5 rounded-full bg-brand" />
            )}
          </button>
        ))}
      </div>

      {error && (
        <div className="border-b border-status-failed/40 bg-status-failed/10 px-3 py-2 text-xs text-status-failed">
          {error} — the backend API needs to be running (see api/README.md).
        </div>
      )}

      {validationErrors.length > 0 && (
        <div className="flex items-start gap-2 border-b border-status-failed/40 bg-status-failed/10 px-3 py-2 text-xs text-status-failed">
          <AlertTriangle size={14} className="mt-0.5 shrink-0" />
          <div>{validationErrors.map((e, i) => <div key={i}>{e}</div>)}</div>
        </div>
      )}

      {/* Code editor + save bar */}
      <div className="flex flex-1 overflow-hidden">
        <div className="flex w-full flex-col">
          <div className="flex items-center justify-between border-b border-border px-3 py-1.5">
            <span className="text-xs text-ink-muted">Code</span>
            <button
              onClick={handleSave}
              disabled={!isDirty || saveState === "saving"}
              className="flex items-center gap-1.5 rounded bg-brand px-2.5 py-1 text-xs font-medium text-white hover:bg-brand-hover disabled:opacity-40"
            >
              {saveState === "saved" ? (
                <><CheckCircle2 size={13} /> Saved</>
              ) : (
                <><Save size={13} /> {saveState === "saving" ? "Saving…" : "Save"}</>
              )}
            </button>
          </div>
          {loading ? (
            <div className="p-3 text-xs text-ink-muted">Loading…</div>
          ) : (
            <textarea
              value={code}
              onChange={(e) => setCode(e.target.value)}
              spellCheck={false}
              className="flex-1 resize-none overflow-auto bg-canvas p-3 font-mono text-xs leading-relaxed text-ink outline-none"
            />
          )}
        </div>
      </div>

      {/* AI Code Assistant prompt bar (FR-06), wired to
          POST /ai-assistant/draft (api/routers/ai_assistant.py). That
          route calls ai-assistant/code_assistant.py, which itself
          needs a reachable local LLM + Milvus — neither available in
          this sandbox, so this path is wired but unexercised
          end-to-end. See api/README.md. */}
      <div className="flex items-center gap-2 border-t border-border bg-canvas-panel px-3 py-2">
        <Sparkles size={16} className="text-brand shrink-0" />
        <input
          value={prompt}
          onChange={(e) => setPrompt(e.target.value)}
          onKeyDown={(e) => e.key === "Enter" && handleAskAI()}
          placeholder="Ask the local AI assistant to draft or update this template…"
          disabled={aiState === "thinking"}
          className="flex-1 rounded border border-border bg-canvas px-2 py-1.5 text-xs text-ink placeholder:text-ink-faint outline-none focus:border-brand disabled:opacity-50"
        />
        <button
          onClick={handleAskAI}
          disabled={aiState === "thinking" || !prompt.trim()}
          className="rounded bg-brand px-3 py-1.5 text-xs font-medium text-white hover:bg-brand-hover disabled:opacity-40"
        >
          {aiState === "thinking" ? "Generating…" : "Generate"}
        </button>
      </div>
    </div>
  );
}
