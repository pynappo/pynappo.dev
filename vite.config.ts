import { sveltekit } from "@sveltejs/kit/vite";
import { defineConfig } from "vite";
import { TypstPlugin, checkExecResult } from "@myriaddreamin/vite-plugin-typst";

export default defineConfig({
  plugins: [
    sveltekit(),
    TypstPlugin({
      // the ts-node-compiler doesn't work with new Typst 0.14 HTML features like typed HTML.
      compiler: "typst-cli",
      onResolveParts: (input, project, ctx) => {
        const res = checkExecResult(input, project.tryHtml(input), ctx);
        if (!res) {
          return {};
        }
        return {
          tags: project.query(input, {
            selector: "<tag>",
            field: "text",
          }),
          title: project.query(input, {
            selector: "<title>",
            field: "value",
          }),
        };
      },
    }),
  ],
});
