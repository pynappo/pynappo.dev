# pynappo.dev

Personal website - primarily a portfolio and blog.

## Notable things

Built on SvelteKit + Bun (but trying not to use too many Bun features because the pace of that project is scary and I'd
like to migrate easily between runtimes. currently bun is used because `bun patch` is a nice for me to vendor a fix for
an issue I have with vite-plugin-typst (and the PR I submitted with the patch is still open))

The blog generates pages from typst documents via `vite-plugin-typst` and then redoes the syntax highlighting using
Tree-sitter.

## Development commands

Basically, the typical SvelteKit commands with `bun`:

```bash
bun run dev
# vite dev

bun run build
# vite build

bun run preview
# vite preview

bun run prepare
# svelte-kit sync || echo ''

bun run check
# svelte-kit sync && svelte-check --tsconfig ./tsconfig.json

bun run check:watch
# svelte-kit sync && svelte-check --tsconfig ./tsconfig.json --watch
```

## AI disclosure

This probably belongs in a page on the site eventually but for now I'll leave this here.

In short, the prose in my blog posts is all written by me - I'm luckily able to write in my own voice in fluent English,
and I believe that if I don't put time into writing something then you shouldn't bother to read it.

In the same vein, I don't like putting out heavily-AI-generated designs as if it's my own. Design is a form of
art/communication as much as the prose is. So most of the important CSS is likely going to be handmade or, at most, done
through a system like Tailwind.

That being said, LLMs are just objectively very fast at prototyping, wiring things together, and writing tedious but
easy to verify code. The current main bits of website code written with LLM use are:

- A bunch of CSS classes to help me integrate the `ayu` color scheme into syntax highlighting and the overall website
theme.
- Tree-sitter highlighting code was originally done by Google's `antigravity` agent (because I got free 2 years of
Google AI Pro I got as a student) and then I heavily enhanced it (rewrote functions to be conciser, changed the
tree-sitter package used, added auto-integration with all installed tree-sitter packages, etc).
