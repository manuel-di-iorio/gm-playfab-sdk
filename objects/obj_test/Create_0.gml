playfab_init("A60CB"); // Set the game ID

// Player Guest Login (with promise pattern!)
playfab_login_custom()
.next(function(resp) {
	show_debug_message("Logged in!");
})
.next(playfab_account_get_info)
.next(function(account_info) {
	show_debug_message("Account info: " + json_stringify(account_info))
})
.error(function(error) {
	show_debug_message(error)
})


// Callback pattern:
//playfab_login_custom("test", true, function(err, resp) {
//	if (err != undefined) return show_debug_message(err);
//	show_debug_message(resp)
	
//	playfab_account_get_info(undefined, undefined, undefined, function(err, account_info) {
//		if (err != undefined) return show_debug_message(err);
//		show_debug_message("Account info: " + json_stringify(account_info))
//	});
//})