import { sveltekit } from "@sveltejs/kit/vite";
import { defineConfig } from "vite";
import typst from "@myriaddreamin/vite-plugin-typst";

export default defineConfig({
	plugins: [sveltekit(), typst()],
});
