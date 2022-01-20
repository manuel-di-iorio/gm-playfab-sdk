/**
 * Log a request/response message/error
 */
function __playfab_log(prefix, group, resource_url, msg) {
	show_debug_message("[" + prefix + "Playfab." + group + "] " + date_datetime_string(date_current_datetime()) + " - Resource: " +
		resource_url + chr(13) + chr(10) + "Data: " + msg + chr(13) + chr(10) + "----------------------");		
}