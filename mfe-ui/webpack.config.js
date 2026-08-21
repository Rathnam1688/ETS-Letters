const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const ModuleFederationPlugin = require("webpack").container.ModuleFederationPlugin;

// BR-05: Pluggable UI. This MFE exposes <DocumentHub /> as a remote so
// any host application can `import("document_hub/DocumentHub")` and
// mount it as a new tab without touching the host's own codebase.
module.exports = {
  entry: "./src/index.js",
  mode: "development",
  devServer: {
    port: 3001,
    headers: { "Access-Control-Allow-Origin": "*" },
  },
  module: {
    rules: [
      { test: /\.jsx?$/, exclude: /node_modules/, use: "babel-loader" },
      { test: /\.css$/, use: ["style-loader", "css-loader", "postcss-loader"] },
    ],
  },
  resolve: { extensions: [".js", ".jsx"] },
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "[name].[contenthash].js",
    publicPath: "auto",
    clean: true,
  },
  plugins: [
    new HtmlWebpackPlugin({ template: "./public/index.html" }),
    new ModuleFederationPlugin({
      name: "document_hub",
      filename: "remoteEntry.js",
      exposes: {
        "./DocumentHub": "./src/App",
      },
      shared: {
        react: { singleton: true, requiredVersion: "^18.3.0" },
        "react-dom": { singleton: true, requiredVersion: "^18.3.0" },
      },
    }),
  ],
};
