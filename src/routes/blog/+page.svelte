<script lang="ts">
	import type { PageProps } from './$types';

	let { data }: PageProps = $props();
</script>

{#each data.posts as post}
	<article>
		<h2>
			{post.body}
		</h2>
	</article>
{/each}
