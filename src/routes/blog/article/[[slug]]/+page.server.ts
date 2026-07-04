import type { PageServerLoad } from "./$types";
import { highlightCode } from "$lib/highlight/treesitter";
import { parseHTML } from "linkedom";

export const load: PageServerLoad = async ({ params }) => {
	const { title, description, body } = await import(
		`../${params.slug}.typ?parts`
	);

	try {
		const { document } = parseHTML(body);

		// 2. Select only <code> tags inside <pre> tags directly
		const codeElements = document.querySelectorAll("pre > code");

		for (const codeElement of codeElements) {
			const rawCodeText = codeElement.textContent || "";
			const highlighted = await highlightCode(
				rawCodeText,
				codeElement.getAttribute("data-lang"),
			);

			if (highlighted !== null) {
				// 3. Instead of constructing a new node, inject the highlighted string
				codeElement.innerHTML = highlighted;
			}
		}

		// 4. Serialize the entire document root cleanly via outerHTML
		return {
			title,
			description,
			body: document.toString(), // Linkedom uses toString() or document.documentElement.outerHTML
		};
	} catch (e) {
		console.error("Failed to parse and highlight HTML body:", e);
		return { title, description, body };
	}
};
