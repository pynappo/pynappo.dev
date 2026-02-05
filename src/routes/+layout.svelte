<script lang="ts">
	import ThemeToggle from '$lib/ui/ThemeToggle.svelte';
	let { children } = $props();
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
