var request_id = async_load[? "id"];
if (!variable_struct_exists(requests, request_id)) exit;
var promise = requests[$ request_id];

// Catch generic and network request errors
try {
	// Handle network and generic HTTP errors
	var status = async_load[? "status"];
	if (status < 0) {
		if (enable_logs) __playfab_log("🡄 ", "ResponseError", promise.context, "Request generic error with status " + string(status));		
		promise.execError({ error: "RequestError", code: 500, status: "RequestError", errorCode: status, errorMessage: "Request generic error" });
		exit;
	}

	// Process the result
	var result = async_load[? "result"];
	if (!is_string(result)) exit;
	var response = json_parse(result);
	
	// Handle API errors
	var httpStatus = async_load[? "http_status"];

	if (httpStatus < 200 || httpStatus > 299) {
		if (enable_logs) __playfab_log("🡄 ", "ResponseError", promise.context, json_stringify(response));
		promise.execError(response);
		exit;
	}
	
	// Success response
	if (enable_logs) __playfab_log("🡄 ", "Response", promise.context, json_stringify(response.data));
	promise.execSuccess(response.data);
} catch (error) {
	if (enable_logs) __playfab_log("🡄 ", "ResponseError", promise.context, error.message);
	promise.execError(error);
}