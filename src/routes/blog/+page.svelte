<script lang="ts">
	import type { PageProps } from './$types';

	let { data }: PageProps = $props();
</script>

{#each data.posts as post}
	<article>
		<a href={`blog/article${post.postPath}`}>
			<h2>
					{post.title}
			</h2>
		</a>
	</article>
{/each}
