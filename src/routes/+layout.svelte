<script lang="ts">
	let { children } = $props();
</script>

<div class="app">
	<header>
		<nav>
			<a href="/about">
				About
			</a>
		</nav>
	</header>

	<main>
		{@render children()}
	</main>

	<footer>
		<p>
			visit <a href="https://svelte.dev/docs/kit">svelte.dev/docs/kit</a> to learn about SvelteKit
		</p>
	</footer>
</div>
