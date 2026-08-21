import React, { useState } from "react";
import { Mail, FileCode2, Library, PlayCircle, ScanEye, PanelLeftClose, PanelLeftOpen } from "lucide-react";

const NAV_ITEMS = [
  { key: "generate", label: "Generate Letters", icon: Mail },
  { key: "workspace", label: "Workspace", icon: FileCode2 },
  { key: "knowledge", label: "Local Knowledge Base", icon: Library },
  { key: "jobs", label: "Job Runs", icon: PlayCircle },
  { key: "qa", label: "Visual QA", icon: ScanEye },
];

export default function Sidebar({ activeView, onSelect }) {
  const [collapsed, setCollapsed] = useState(false);

  return (
    <aside
      className={`flex flex-col justify-between border-r border-border bg-canvas-panel transition-all ${
        collapsed ? "w-14" : "w-56"
      }`}
    >
      <div>
        <div className="flex items-center justify-between px-3 py-3 border-b border-border">
          {!collapsed && (
            <span className="text-xs font-semibold tracking-wide text-ink-muted uppercase">
              Document Hub
            </span>
          )}
          <button
            onClick={() => setCollapsed((c) => !c)}
            className="text-ink-muted hover:text-ink"
            aria-label={collapsed ? "Expand sidebar" : "Collapse sidebar"}
          >
            {collapsed ? <PanelLeftOpen size={16} /> : <PanelLeftClose size={16} />}
          </button>
        </div>

        <nav className="mt-2 flex flex-col gap-0.5 px-2">
          {NAV_ITEMS.map(({ key, label, icon: Icon }) => {
            const active = activeView === key;
            return (
              <button
                key={key}
                onClick={() => onSelect(key)}
                className={`flex items-center gap-2 rounded px-2 py-1.5 text-left transition-colors ${
                  active
                    ? "bg-canvas-raised text-ink border-l-2 border-brand"
                    : "text-ink-muted hover:bg-canvas-raised hover:text-ink border-l-2 border-transparent"
                }`}
              >
                <Icon size={16} className={active ? "text-brand" : ""} />
                {!collapsed && <span className="truncate">{label}</span>}
              </button>
            );
          })}
        </nav>
      </div>

      {!collapsed && (
        <div className="px-3 py-3 border-t border-border text-xs text-ink-faint">
          On-prem · Air-gapped
        </div>
      )}
    </aside>
  );
}
