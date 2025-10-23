import { fetchTypstPosts } from "$lib/posts";
import { json } from "@sveltejs/kit";

export const GET = async () => {
	const posts = await fetchTypstPosts();
	return json(posts);
};
