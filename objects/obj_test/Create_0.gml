playfab_init("A60CB"); // Set the game ID

// Player Guest Login
playfab_login_custom("test")
.next(function(resp) {
	show_debug_message("Logged in! User ID: " + resp.PlayFabId);
})
.next(function() {
	return playfab_player_update_statistic("leaderboard", 50.5);
})
.next(function() {
	return playfab_player_get_leaderboard("leaderboard");
})
.next(function(scores) {
	show_debug_message("My scores: " + json_stringify(scores));
})
.error(show_debug_message)