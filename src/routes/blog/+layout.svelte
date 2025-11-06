<script lang="ts">
	let { children } = $props();
</script>

<svelte:head>
	<link rel="stylesheet" href="/css/blog.css">
</svelte:head>

{@render children()}
