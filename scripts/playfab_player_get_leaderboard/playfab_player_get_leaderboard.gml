/**
 * Update the player statistic
 *
 * @param {String} [statisticName] Unique name of the statistic to update
 * @param {Real} [start] Position in the leaderboard to start this listing (defaults to the first entry).
 * @param {Real} [limit] Maximum number of entries to retrieve. Default 10, maximum 100.
 * @param {Function} [on_callback] Optional response callback
 *
 * @return {Struct<Promise>}
 */
function playfab_player_get_leaderboard(statisticName, start = undefined, limit = undefined, on_callback = undefined) {
	var body = {
		StatisticName: statisticName
	};
	
	if (start != undefined) body.StartPosition = start;
	if (limit != undefined) body.MaxResultsCount = limit;
	
	var promise = __playfab_call_api("Client/GetLeaderboard", body)
	
	//.next(function(resp) {
	//	return resp.Leaderboard;
	//});
	
	if (on_callback != undefined) promise.addCallback(on_callback);
	return promise;
}