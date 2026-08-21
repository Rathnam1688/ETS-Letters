import React from "react";
import { UploadCloud, FileText } from "lucide-react";

const INGESTED_DOCS = [
  { name: "CMS-1500-layout-rules.pdf", chunks: 214, status: "Indexed" },
  { name: "remittance-advice.xsd", chunks: 38, status: "Indexed" },
  { name: "revalidation-notice-guidelines.pdf", chunks: 156, status: "Indexed" },
];

// FR-05: management view to ingest regulatory PDFs / XSDs into the
// self-hosted vector database. Wired to ai-assistant/rag/ingest.py.
export default function KnowledgeBase() {
  return (
    <div className="h-full overflow-auto p-6">
      <div className="mb-4 flex items-center justify-between">
        <h2 className="text-base font-semibold">Local Knowledge Base</h2>
        <button className="flex items-center gap-2 rounded bg-brand px-3 py-1.5 text-xs font-medium text-white hover:bg-brand-hover">
          <UploadCloud size={14} />
          Upload documents
        </button>
      </div>
      <p className="mb-4 text-xs text-ink-muted">
        Documents are embedded locally (bge-large-en) and stored in the
        self-hosted vector DB (Milvus). Nothing leaves the organizational
        perimeter — BR-02.
      </p>

      <table className="w-full border-collapse text-xs">
        <thead>
          <tr className="border-b border-border text-left text-ink-muted">
            <th className="py-2 font-medium">Document</th>
            <th className="py-2 font-medium">Chunks</th>
            <th className="py-2 font-medium">Status</th>
          </tr>
        </thead>
        <tbody>
          {INGESTED_DOCS.map((doc) => (
            <tr key={doc.name} className="border-b border-border-subtle hover:bg-canvas-raised">
              <td className="flex items-center gap-2 py-2">
                <FileText size={14} className="text-ink-faint" />
                {doc.name}
              </td>
              <td className="py-2 text-ink-muted">{doc.chunks}</td>
              <td className="py-2">
                <span className="rounded bg-status-success/15 px-2 py-0.5 text-status-success">
                  {doc.status}
                </span>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
