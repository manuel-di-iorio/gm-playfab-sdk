/**
 * Make a HTTP call to the Playfab API
 * @internal
 *
 * @param {String} api_method API method to use
 * @param {String} resource_url Resource URL to call
 * @param {Boolean} [hasAuth] If to append the authentication header
 * @param {Map} headers Map of headers
 * @param {Map} body Map of body parameters
 *
 * @return {Struct<Promise>} Promise
 */
function __playfab_call_api(resource_url, body = {}, api_method = "POST", headers = ds_map_create(), hasAuth = true) {
	headers[? "Content-Type"] = "application/json";
	
	with (__playfab_obj) {
		if (hasAuth) {
			headers[? "X-Authorization"] = session_ticket;
		}	
		
		var json = json_stringify(body);
		
		if (enable_logs) {
			show_debug_message("[Playfab.Request] " + api_method + " " + resource_url + chr(13) + chr(10) + "Body: " + json + chr(13) + chr(10) + "----------------------");		
		}
	
		var request_id = http_request("https://" + title_id + ".playfabapi.com/" + resource_url, api_method, headers, json);
		var promise = new Promise(api_method + " " + resource_url);	
	
		// Store this request in the requests list
		__playfab_obj.requests[$ request_id] = promise;
		
		return promise;
	}
}