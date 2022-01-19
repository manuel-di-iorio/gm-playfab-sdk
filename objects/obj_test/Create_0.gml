playfab_init("A60CB"); // Set the game ID

// Player Guest Login
playfab_login_custom()
.next(function(resp) {
	show_debug_message("Logged in! User ID: " + resp.PlayFabId);
})
.next(function() {
	return playfab_player_update_statistic("leaderboard", 50);
})
.next(function() {
	return playfab_player_get_leaderboard("leaderboard");	
})
.next(function(scores) {
	show_debug_message(scores);
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