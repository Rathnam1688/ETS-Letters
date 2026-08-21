import React from "react";
import { AlertTriangle } from "lucide-react";

// FR-07: overlay legacy xPression PDF vs new open-source PDF, highlight
// pixel variances. Backed by visual-qa/pixel_diff.py.
export default function VisualQA() {
  return (
    <div className="h-full overflow-auto p-6">
      <h2 className="mb-4 text-base font-semibold">Visual QA — Pixel Diff</h2>
      <div className="mb-4 flex items-center gap-2 rounded border border-status-failed/40 bg-status-failed/10 px-3 py-2 text-xs text-status-failed">
        <AlertTriangle size={14} />
        Page 3 of remittance_advice.html shows 2.3% pixel variance vs. legacy xPression output.
      </div>
      <div className="grid grid-cols-3 gap-3 text-xs">
        {["Legacy (xPression)", "New (open-source)", "Diff overlay"].map((label) => (
          <div key={label} className="rounded border border-border">
            <div className="border-b border-border bg-canvas-panel px-2 py-1 text-ink-muted">
              {label}
            </div>
            <div className="flex h-64 items-center justify-center bg-white text-ink-faint">
              page render
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
