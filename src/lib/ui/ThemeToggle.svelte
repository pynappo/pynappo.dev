<script lang="ts">
  // https://pepelsbey.dev/articles/native-light-dark
  import { onMount } from 'svelte';

  onMount(() => {
    let colorScheme = document.querySelector('meta[name=color-scheme]') as HTMLMetaElement;
    let localStorageKey = 'color-scheme';
    // Load theme preference from localStorage or detect system preference
    const storedTheme = localStorage.getItem(localStorageKey);
    if (storedTheme) {
      colorScheme.content = storedTheme;
    } else if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
      colorScheme.content = 'dark';
    }
    document.documentElement.setAttribute('data-theme', colorScheme.content);
    const switchButtons = document.querySelectorAll('button');

    switchButtons.forEach(button => {
      button.addEventListener('click', () => {
        const currentButton = button;

        switchButtons.forEach(
          button => button.setAttribute('aria-pressed', button === currentButton ? "true" : "false")
        );

        colorScheme.content = button.value;
      });
    });
  });
</script>

<section id="color-scheme-switcher">
	<button aria-pressed="false" value="light">
		Light
	</button>
	<button aria-pressed="true" value="light dark">
		Auto
	</button>
	<button aria-pressed="false" value="dark">
		Dark
	</button>
</section>
