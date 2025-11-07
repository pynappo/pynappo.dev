#import "/typst/templates/article.typ": article

#show: article.with(
  article-title: "Building a SvelteKit blog with Typst",
  date-published: datetime(year: 2025, month: 11, day: 6),
  tags: ("meta", "typst"),
)

= Motivation:

Having a blog to post and ramble on is cool.

= Goals:

- It should use a markup format like Markdown or Typst, because writing HTML can be a pain.
- It should be versatile enough to implement things like a tagging system.

= Implementation:

This website is built with SvelteKit. I looked up a guide for how people make Markdown blogs on SvelteKit and found
#link(
  "https://joshcollinsworth.com/blog/build-static-sveltekit-markdown-blog",
  [this wonderful blogpost
    from Josh Collinsworth],
). I wanted to try using S
could be.

== Why not markdown?

Amazingly, simply adapting the guide to use
#link(
  "https://www.npmjs.com/package/@myriaddreamin/vite-plugin-typst",
  [\@myriaddreamin/vite-plugin-typst],
) for importing typst files, instead of the markdown equivalent, pretty much just works.

For tagging, I configured the plugin to get text from `<tag>` labels:

```typescript
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
				};
			},
		}),
	],
});
```
