import { sveltekit } from "@sveltejs/kit/vite";
import { defineConfig } from "vite";
import { TypstPlugin, checkExecResult } from "@myriaddreamin/vite-plugin-typst";

export default defineConfig({
	plugins: [
		sveltekit(),
		TypstPlugin({
			compiler: "typst-cli",
			onResolveParts: (input, project, ctx) => {
				const res = checkExecResult(input, project.tryHtml(input), ctx);
				if (!res) {
					return {};
				}
				return {
					tags: project.query(input, {
						selector: "<tags>",
						field: "value",
					}),
				};
			},
		}),
	],
});
