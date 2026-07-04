<script lang="ts">
	import ThemeToggle from "$lib/ui/ThemeToggle.svelte";
	import { onMount } from "svelte";
	let { children } = $props();
	onMount(() => {
		document.querySelectorAll('pre code').forEach((block) => {
			if (navigator.clipboard) {

					// Wrap code block in a relative container so the button can be positioned absolute
					const wrapper = document.createElement('div');
					const pre = block.closest("pre");
					if (!pre) throw new Error("what")
					pre.before(wrapper);
					// Create the button
					const button = document.createElement('button');
					button.innerText = 'Copy';
					button.classList.add('copy-btn');

					// Add click event to copy text and provide feedback
					button.addEventListener('click', () => {
							if (!block.innerText) {
								alert("no code text found, please report if you believe this is an error")
								return;
							}
							navigator.clipboard.writeText(block.innerText).then(() => {
									button.innerText = 'Copied!';
									setTimeout(() => {
											button.innerText = 'Copy';
									}, 2000);
							});
					});
					wrapper.append(pre, button);
			}
		});
	})
</script>

<svelte:head>
	<link rel="stylesheet" href="/css/main.css">
</svelte:head>

<header>
	<nav>
		<a href="/about">
			About
		</a>
		<a href="/blog">
			Blog
		</a>
	</nav>
	<ThemeToggle/>
</header>

<main>
	{@render children()}
</main>

<footer>
	pynappo's site.
</footer>
