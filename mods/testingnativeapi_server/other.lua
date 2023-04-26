minetest.register_chatcommand("log", {
	description = "testing get_player_by_name and object:get_look_dir",
	func = function(name)
		local player = minetest.get_player_by_name(name)
		local msg
		if player then
			local dir = player:get_look_dir()
			print("-------------------------------------GLOBAL TABLE-------------------------------------")
			for key, value in pairs(_G) do
    				print(key, value)
			end
			print("------------------------------------MINETEST TABLE-----------------------------------")
			for key, value in pairs(_G["minetest"]) do
    				print(key, value)
			end
			return true, "Successfully logged to console"
		else
			msg = "Could not find player with name " .. name
			return false, msg
		end
	end
})

minetest.register_chatcommand("pathest", {
	description = "get current world path",
	func = function()
		print(minetest.get_worldpath())
		return true, "Got path"
	end
})