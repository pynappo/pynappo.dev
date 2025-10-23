import { error } from "@sveltejs/kit";
import type { PageLoad } from "./$types";

export const load: PageLoad = async ({ params }) => {
	const { title, description, body } = await import(
		`../../../../../typst/blog/${params.slug}.typ?parts`
	);
	return { title, description, body };
};
