const TYPST_BLOG_PATH = "/src/routes/blog/article";
export const fetchTypstPosts = async () => {
	const allPostFiles = import.meta.glob("/src/routes/blog/article/*.typ", {
		query: "?parts",
	});
	const iterablePostFiles = Object.entries(allPostFiles);

	const allPosts = await Promise.all(
		iterablePostFiles.map(async ([path, resolver]) => {
			const { title, description, body, tags } = await resolver();
			const postPath = path.slice(TYPST_BLOG_PATH.length + 1, -4);

			return {
				title,
				description,
				body,
				tags,
				postPath,
			};
		}),
	);

	return allPosts;
};
