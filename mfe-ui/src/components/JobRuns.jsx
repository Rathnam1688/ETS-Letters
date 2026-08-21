import React from "react";

const STATUS_STYLES = {
  Success: "bg-status-success/15 text-status-success",
  Running: "bg-status-running/15 text-status-running",
  Failed: "bg-status-failed/15 text-status-failed",
  Queued: "bg-status-queued/15 text-status-queued",
};

const RUNS = [
  { batch: "BATCH-2026-08-09-004", letters: 1240, status: "Running", triggered: "IWA · 2 min ago" },
  { batch: "BATCH-2026-08-09-003", letters: 980, status: "Success", triggered: "IWA · 1 hr ago" },
  { batch: "BATCH-2026-08-08-011", letters: 15, status: "Failed", triggered: "IWA · 18 hrs ago" },
  { batch: "BATCH-2026-08-08-010", letters: 2003, status: "Success", triggered: "IWA · 19 hrs ago" },
];

// Reflects queue/producer.py + consumer.py batch/DLQ status (FR-03, NFR 5.3).
export default function JobRuns() {
  return (
    <div className="h-full overflow-auto p-6">
      <h2 className="mb-4 text-base font-semibold">Job Runs</h2>
      <table className="w-full border-collapse text-xs">
        <thead>
          <tr className="border-b border-border text-left text-ink-muted">
            <th className="py-2 font-medium">Batch</th>
            <th className="py-2 font-medium">Letters</th>
            <th className="py-2 font-medium">Status</th>
            <th className="py-2 font-medium">Triggered</th>
          </tr>
        </thead>
        <tbody>
          {RUNS.map((run) => (
            <tr key={run.batch} className="border-b border-border-subtle hover:bg-canvas-raised">
              <td className="py-2 font-mono text-ink">{run.batch}</td>
              <td className="py-2 text-ink-muted">{run.letters.toLocaleString()}</td>
              <td className="py-2">
                <span className={`rounded px-2 py-0.5 ${STATUS_STYLES[run.status]}`}>
                  {run.status}
                </span>
              </td>
              <td className="py-2 text-ink-muted">{run.triggered}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
