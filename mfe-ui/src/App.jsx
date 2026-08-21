import React, { useState } from "react";
import Sidebar from "./components/Sidebar";
import GenerateLetters from "./components/GenerateLetters";
import TemplateWorkspace from "./components/TemplateWorkspace";
import KnowledgeBase from "./components/KnowledgeBase";
import JobRuns from "./components/JobRuns";
import VisualQA from "./components/VisualQA";

const VIEWS = {
  generate: GenerateLetters,
  workspace: TemplateWorkspace,
  templates: TemplateWorkspace,
  knowledge: KnowledgeBase,
  jobs: JobRuns,
  qa: VisualQA,
};

// Root of the "Document Hub" tab (BR-05: mounted into any host portal).
export default function App() {
  const [activeView, setActiveView] = useState("generate");
  const ActiveView = VIEWS[activeView] ?? GenerateLetters;

  return (
    <div className="flex h-screen w-full bg-canvas text-ink font-sans text-sm">
      <Sidebar activeView={activeView} onSelect={setActiveView} />
      <main className="flex-1 overflow-hidden">
        <ActiveView />
      </main>
    </div>
  );
}
