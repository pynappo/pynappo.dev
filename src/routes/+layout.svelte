<script lang="ts">
	let { children } = $props();
</script>

<header>
	<nav>
		<a href="/about">
			About
		</a>
		<a href="/blog">
			Blog
		</a>
	</nav>
</header>

<svelte:head>
	<link rel="stylesheet" href="/css/main.css">
</svelte:head>

<main>
	{@render children()}
</main>

<footer>
	pynappo's site.
</footer>
