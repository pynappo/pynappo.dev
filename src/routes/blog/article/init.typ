#import "/typst/templates/article.typ": article

#show: article.with(
  article-title: "Building a SvelteKit blog with Typst",
  date-published: datetime(year: 2025, month: 11, day: 6),
  tags: ("meta", "typst"),
)

= Motivation:

Having a blog to post and ramble on is cool.

= Goals:

The blog should:

- Use a markup format like Markdown or Typst, because writing HTML can be a pain.
- Be versatile enough to implement things like a tagging system.
- Be able to work without client-side JavaScript.

= Implementation:

I chose SvelteKit because people tend to praise it for strong DX. I looked up a guide for how people make Markdown blogs
on SvelteKit and found
#link(
  "https://joshcollinsworth.com/blog/build-static-sveltekit-markdown-blog",
  [this wonderful blogpost
    from Josh Collinsworth],
).

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
			// the ts-node-compiler doesn't support typed HTML (e.g. #html.p()), which is new in Typst 0.14
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

== Why not markdown?

