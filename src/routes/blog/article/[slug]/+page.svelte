<script lang="ts">
	import type { PageProps } from './$types';

	let props: PageProps = $props();
	console.log(props)

	let data = props.data;
	console.log(data);
</script>

<svelte:head>
	<title>{data.title}</title>
</svelte:head>

{@html data.body}
