/**
 * Get the account info of a player
 *
 * @param {String} [email] User email address for the account to find (if no Username is specified).
 * @param {String} [playfab_id] Unique Playfab identifier of the user. Defaults to the authenticated user if no other arguments are set.
 * @param {String} [username] PlayFab Username for the account to find (if no PlayfabId is specified).
 * @param {Function} [on_callback] Optional response callback
 *
 * @return {Struct<Promise>}
 */
function playfab_account_get_info(email = undefined, playfab_id = undefined, username = undefined, on_callback = undefined) {
	var body = {};
	if (email != undefined) body.Email = email;
	if (playfab_id != undefined) body.PlayFabId = email;
	if (username != undefined) body.Username = username;
	
	var promise = __playfab_call_api("Client/GetAccountInfo", body);
	if (on_callback != undefined) promise.addCallback(on_callback);
	return promise;
}