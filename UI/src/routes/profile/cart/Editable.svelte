<script>
	import { enhance } from '$app/forms';

	import Counter from '$lib/Counter.svelte';
	export let quantity;
	export let productID;
	export let cartID;

	let editable = false;

	export let form;
</script>

<div class="flex items-center gap-4">
	<span>Quantity: </span>
	<Counter bind:count={quantity} disabled={!editable}/>
</div>

<form id="saveme" method="POST" action="?/save" on:submit={() => editable = false} use:enhance>
	<input type="hidden" name="cartID" value={cartID} />
	<input type="hidden" name="productID" value={productID} />
	<input type="hidden" name="quantity" value={quantity} />
</form>
<form id="deleteme" method="POST" action="?/save" use:enhance>
	<input type="hidden" name="cartID" value="0" />	
	<input type="hidden" name="productID" value={productID} />
	<input type="hidden" name="quantity" value={quantity} />
</form>

{#if editable}
	<button type="submit" form="saveme"
		class="btn btn-ghost p-2 text-success">
		<span class="icon done-icon"></span>Save
	</button>

	<button type="submit" form="deleteme"
		class="btn btn-ghost p-1 text-error">
		<span class="icon trash-icon"></span>
	</button>
{:else}
	<button class="btn btn-primary hover:bg-accent"
		on:click={() => {editable = true; }}>Edit</button>
{/if}



<style>
	.icon {
		mask-size: contain;
		width: 2rem;
		height: 2rem;
		background-color: currentColor;
	}
	.trash-icon {
		mask-image: url($lib/icons/trash.svg);
	}
	.done-icon {
		mask-image: url($lib/icons/done.svg);
	}
</style>