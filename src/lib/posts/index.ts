export const fetchTypstPosts = async () => {
	const allPostFiles = import.meta.glob("/typst/blog/*.typ", {
		query: "?parts",
	});
	const iterablePostFiles = Object.entries(allPostFiles);

	const allPosts = await Promise.all(
		iterablePostFiles.map(async ([path, resolver]) => {
			const { title, description, body } = await resolver();
			const postPath = path.slice(11, -3);

			return {
				title,
				description,
				body,
			};
		}),
	);

	return allPosts;
};
