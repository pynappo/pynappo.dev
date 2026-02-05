import type { PageServerLoad } from "./$types";

export const load: PageServerLoad = async ({ params }) => {
	const { title, description, body } = await import(
		`../${params.slug}.typ?parts`
	);
	return { title, description, body };
};
