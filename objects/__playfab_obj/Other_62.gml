var request_id = async_load[? "id"];
if (!variable_struct_exists(requests, request_id)) exit;
var promise = requests[$ request_id];

// Catch generic and network request errors
try {
	var status = async_load[? "status"];
	if (status < 0) {
		if (enable_logs) {
			show_debug_message(date_datetime_string(date_current_datetime()) + " - [Playfab.ResponseError] " + promise.context + chr(13) + chr(10) + "Error: request generic error with status " + string(status) + chr(13) + chr(10) + "----------------------");
		}
		
		promise.execError({ error: "RequestError", code: 500, status: "RequestError", errorCode: status, errorMessage: "Request generic error" });
		exit;
	}

	var response = json_parse(async_load[? "result"]);
	
	// Catch API errors
	var httpStatus = async_load[? "http_status"];

	if (httpStatus < 200 || httpStatus > 299) {
		if (enable_logs) {
			show_debug_message(date_datetime_string(date_current_datetime()) + " - [Playfab.ResponseError] " + promise.context + chr(13) + chr(10) + "Error: " + json_stringify(response) + chr(13) + chr(10) + "----------------------");
		}
	
		promise.execError(response);
		exit;
	}
	
	// Success response
	if (enable_logs) {
		show_debug_message(date_datetime_string(date_current_datetime()) + " - [Playfab.Response] " + promise.context + chr(13) + chr(10) + "Response: " + json_stringify(response.data) + chr(13) + chr(10) + "----------------------");
	}
		
	promise.execSuccess(response.data);
} catch (error) {
	show_debug_message(error)
	if (enable_logs) {
		show_debug_message(date_datetime_string(date_current_datetime()) + " - [Playfab.ResponseError] " + promise.context + chr(13) + chr(10) + "Error: " + error.message + chr(13) + chr(10) + "----------------------");
	}
	
	promise.execError(error);
}