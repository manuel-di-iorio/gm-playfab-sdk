/**
 * Update the player statistic
 *
 * @param {String} [statisticName] Unique name of the statistic to update
 * @param {Real} [value] Value
 * @param {Real} [version] For updates to an existing statistic value for a player, the version of the statistic when it was loaded. Set it to undefined when setting the statistic value for the first time
 * @param {Function} [on_callback] Optional response callback
 *
 * @return {Struct<Promise>}
 */
function playfab_player_update_statistic(statisticName, value, version = undefined, on_callback = undefined) {
	var stat = {
		StatisticName: statisticName,
		Value: value
	};
	
	if (version != undefined) {
		stat.Version = version;
	}
	
	var body = json_stringify({ Statistics: [stat] });
	body = string_replace_all(body, ".0", "");
	
	var promise = __playfab_call_api("Client/UpdatePlayerStatistics", body);
	if (on_callback != undefined) promise.addCallback(on_callback);
	return promise;
}