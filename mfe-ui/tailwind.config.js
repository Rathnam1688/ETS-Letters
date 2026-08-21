/** Design tokens — Databricks-style dark UI per BRD Section 4. */
module.exports = {
  content: ["./src/**/*.{js,jsx}"],
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        canvas: {
          DEFAULT: "#1B1B1D", // main dark background
          panel: "#232326",   // sidebar / card surface
          raised: "#2A2A2E",  // hovered/active rows
        },
        border: {
          DEFAULT: "#33343A",
          subtle: "#2A2A2E",
        },
        ink: {
          DEFAULT: "#E8E8EA", // primary text
          muted: "#8A8B93",   // secondary text
          faint: "#5C5D64",
        },
        brand: {
          DEFAULT: "#FF3621", // signature accent (Databricks red-orange, per BR-03)
          hover: "#E62F1C",
        },
        status: {
          success: "#00A972",
          running: "#2272B4",
          failed: "#E5484D",
          queued: "#8A8B93",
        },
      },
      fontFamily: {
        sans: ["Inter", "system-ui", "sans-serif"],
        mono: ["JetBrains Mono", "ui-monospace", "monospace"],
      },
    },
  },
  plugins: [],
};
