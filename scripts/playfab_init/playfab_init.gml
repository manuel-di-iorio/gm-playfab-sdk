/**
 * Init the Microsoft Azure Playfab SDK
 *
 * Create an account here: https://developer.playfab.com/en-us/sign-up
 * API Reference: https://docs.microsoft.com/en-us/gaming/playfab/api-references/?view=playfab-rest
 * 
 * @param {String} title_id
 * @param {Function} [on_http_callback] Callback for the HTTP request (if not using the promise pattern)
 * @param {String} [layer_id]
 *
 * @return {Struct<Promise>}
 */
function playfab_init(title_id, on_http_callback = undefined, layer_id = layer) {
	instance_create_layer(0, 0, layer_id, __playfab_obj);
	
	with (__playfab_obj) {
		self.title_id = title_id;
		requests = {};
		session_ticket = undefined;
		enable_logs = true;
	}
}