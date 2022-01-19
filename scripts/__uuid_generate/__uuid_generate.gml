/// @func __uuid_generate()
/// @desc Generate an UUID. Script adapted from https://marketplace.yoyogames.com/assets/5353/uuid-v4
/// @license https://marketplace.yoyogames.com/eula
function __uuid_generate() {

	// Randomize the seed
	var originalSeed = random_get_seed();
	randomize();

	// Get the epoch
	var epoch = round(date_second_span(date_create_datetime(2016,1,1,0,0,1), date_current_datetime()));

	// Create the UUID
	var d = current_time + epoch * 10000
	var uuid = array_create(32)
	var i = 0
	var r;
	var len = array_length(uuid);

	for (i=0;i<len;++i) {
		r = floor((d + random(1) * 16)) mod 16;
    
		if (i == 16)
		    uuid[i] = __dec_to_hex(r & $3|$8);
		else
		    uuid[i] = __dec_to_hex(r);
	}

	uuid[12] = "4";

	// Implode the UUID array into a string
	var str = "", arr = uuid;
	i = 0;

	repeat 8 str += arr[i++];
	str += "-";

	repeat 4 str += arr[i++];
	str += "-";

	repeat 4 str += arr[i++];
	str += "-";

	repeat 4 str += arr[i++];
	str += "-";

	repeat 12 str += arr[i++];

	// Set the seed back to the original
	random_set_seed(originalSeed);

	return str;
}
