/**
 * Free up the memory by destroying the Playfab SDK object
 */
function playfab_free() {
	with (__playfab_obj) instance_destroy();
}