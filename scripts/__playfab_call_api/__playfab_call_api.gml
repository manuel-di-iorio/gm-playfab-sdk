/**
 * Make a HTTP call to the Playfab API
 * @internal
 *
 * @param {String} resource_url Resource URL to call
 * @param {Struct|String} body Map of body parameters 
 * @param {Map} headers Map of headers 
 * @param {Boolean} [hasAuth] If to append the authentication header with the session ticket
 *
 * @return {Struct<Promise>} Promise
 */
function __playfab_call_api(resource_url, body = {}, headers = ds_map_create(), hasAuth = true) {
	headers[? "content-type"] = "application/json";
	
	with (__playfab_obj) {
		if (hasAuth) {
			headers[? "x-authorization"] = session_ticket;
		}	
		
		var json = is_struct(body) ? json_stringify(body) : body;
		
		// Remove the decimal part of the values
		var isNumber = false;
		for (var i=1, count=string_length(json); i<=count; i++) {
			var char = string_char_at(json, i);
			if (char == "§" && !isNumber) {
				
			}
		}
		
		// Log
		if (enable_logs) {
			show_debug_message(date_datetime_string(date_current_datetime()) + " - [Playfab.Request] " + resource_url + chr(13) + chr(10) + "Body: " + json + chr(13) + chr(10) + "----------------------");		
		}
		
		var closure = {
			title_id: title_id,
			resource_url: resource_url,
			headers: headers,
			json: json
		};
		
		// Create the promise
		var promise = new Promise(method(closure, function(promise) {
			var request_id = http_request("https://" + title_id + ".playfabapi.com/" + resource_url, "POST", headers, json);
			
			// Store this request in the requests list
			__playfab_obj.requests[$ request_id] = promise;
		}), resource_url);
		
		return promise;
	}
}