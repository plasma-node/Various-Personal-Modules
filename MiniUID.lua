-- Mini UID system. Not a stand in for Roblox's UUID.
-- Intented use is for unique runtime IDs, pertaining to each script, and unique only to this server.
local module = {}
local AlphaNumeric = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",0,1,2,3,4,5,6,7,8,9};
local Rand = Random.new(os.clock() * os.time());


function module:Generate (Length)
	local get = "";
	
	for i = 1, Length or 6, 1 do -- Default is six
		get ..= AlphaNumeric[Rand:NextInteger(1, 36)];
	end
	
	return get;
end

return module
