<script lang='ts'>
	import Login from './Login.svelte';
	import Register from './Register.svelte';

	let state = 0;

	// $page.form, returned from actions +page.server.ts
	export let form;
</script>

<!-- login -->
<div class="contain py-16">
	<div class="max-w-lg mx-auto shadow px-6 py-7 rounded overflow-hidden">
		{#if state == 0}
			<Login bind:state bind:form />
		{:else}
			<Register bind:state />
		{/if}
	</div>
</div>
<!-- ./login -->