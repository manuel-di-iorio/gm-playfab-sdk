var request_id = async_load[? "id"];
if (!variable_struct_exists(requests, request_id)) exit;
var promise = requests[$ request_id];

// Catch generic and network request errors
var status = async_load[? "status"];
if (status < 0) {
	promise.execError({ error: "RequestError", code: 500, status: "RequestError", errorCode: status, errorMessage: "Request generic error" });
	exit;
}

try {
	var response = json_parse(async_load[? "result"]);
	
	// Catch API errors
	var httpStatus = async_load[? "http_status"];
	if (httpStatus < 200 || httpStatus > 299) {
		promise.execError(response);
		exit;
	}
	
	// Success response
	if (enable_logs) {
		show_debug_message("[Playfab.Response] " + promise.context + chr(13) + chr(10) + "Response: " + json_stringify(response.data) + chr(13) + chr(10) + "----------------------");
	}
		
	promise.execSuccess(response.data);
} catch (error) {
	// JSON errors
	show_debug_message(promise)
	promise.execError(error);
}