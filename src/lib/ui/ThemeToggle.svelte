<script lang="ts">
// https://pepelsbey.dev/articles/native-light-dark
import { onMount } from "svelte";
import SunIcon from "virtual:icons/material-symbols/sunny-rounded";

onMount(() => {
	let colorScheme = document.querySelector(
		"meta[name=color-scheme]",
	) as HTMLMetaElement;
	// Load theme preference from localStorage or detect system preference
	const storedColorScheme = localStorage.getItem("color-scheme");
	if (storedColorScheme) {
		colorScheme.content = storedColorScheme;
	} else if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
		colorScheme.content = "dark";
	}
	document.documentElement.dataset.colorScheme = colorScheme.content;
	const switchButtons = document.querySelectorAll(
		"#color-scheme-switcher input",
	) as NodeListOf<HTMLInputElement>;

	switchButtons.forEach((input) => {
		input.addEventListener("click", () => {
			colorScheme.content = input.value;
			document.documentElement.dataset.colorScheme = colorScheme.content;
		});
	});
	const themeSwitcher = document.querySelector("#color-scheme-switcher");
	if (themeSwitcher) {
		themeSwitcher.classList.add("visible");
	}
});
</script>

<fieldset id="color-scheme-switcher">
  <!-- https://clagnut.com/blog/2437 -->
	<legend>Color Scheme</legend>
	<label for="color-scheme-switcher-system">
    <input type="radio" name="color-scheme" value="system" id="color-scheme-switcher-system"/>
    <SunIcon/>
	</label>

	<label for="color-scheme-switcher-dark">
    <input type="radio" name="color-scheme" value="dark" id="color-scheme-switcher-dark"/>
    <SunIcon/>
	</label>

	<label for="color-scheme-switcher-light">
    <input type="radio" name="color-scheme" value="light" id="color-scheme-switcher-light"/>
    <SunIcon/>
	</label>
</fieldset>
