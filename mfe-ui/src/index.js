import React from "react";
import { createRoot } from "react-dom/client";
import App from "./App";
import "./styles/theme.css";

// Standalone dev mount. When embedded in a host portal (BR-05), the
// host instead does: const { DocumentHub } = await import("document_hub/DocumentHub")
const container = document.getElementById("root");
createRoot(container).render(<App />);
