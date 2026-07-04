import type { PageLoad } from "./$types";

export const prerender = true;
export const load: PageLoad = async ({ params, fetch }) => {
	const response = await fetch(`/api/posts`);
	const posts = await response.json();

	return {
		posts,
	};
};
