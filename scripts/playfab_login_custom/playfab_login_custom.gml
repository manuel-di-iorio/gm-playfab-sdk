/**
 * Performs the custom authentication
 *
 * @param {String} [custom_id] Custom ID to identify the user. If not specified then a UUID is used as user identification (aka guest login)
 * @param {Boolean} [create_account] If to create the account if it does not exists (defaults to true)
 * @param {Function} [on_callback] Optional response callback
 *
 * @return {Struct<Promise>}
 */
function playfab_login_custom(custom_id = undefined, create_account = true, on_callback = undefined) {
	var body = {
		TitleId: __playfab_obj.title_id,
		CreateAccount: true,
		CustomId: custom_id == undefined ? __uuid_generate() : "test"
	};
	
	var promise = __playfab_call_api("Client/LoginWithCustomID", body, "POST", ds_map_create(), false)
	
	.next(function(resp) {
		__playfab_obj.session_ticket = resp.SessionTicket;		
		return resp;
	});
	
	if (on_callback != undefined) promise.addCallback(on_callback);
	
	return promise;
}