--functions in this file are intended for client commands that cannot use server-side api functions for testing
--set conditions needed to test certain client commands

--### l_client

--moves player when send_respawn() from client is sent
minetest.register_on_respawnplayer(function(player)
	local pos = player:get_pos()
	pos.y = pos.y + 5
	player:set_pos(pos)
	minetest.chat_send_player(player:get_player_name(), "RESPAWNED")
	return false
end)

--usage: /set_meta_below field val
minetest.register_chatcommand("set_meta_below", {
	description = "fills the block underneath the player with metadata",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		local pos = player:get_pos()
		pos.y = pos.y - 1

		local parts = param:split(" ")
		local field = parts[1]
		local val = parts[2]

		local meta = minetest.get_meta(pos)
		meta:set_string(field, val)

		return true, "metadata added to block below"
	end
})

--### driver (run this to setup preconditions)

minetest.register_chatcommand("client_side_config", {
	description = "set preconditions on server for testing client-side-mods",
	func = function(name)

		--usage: command = parameters
		local conditions = {
			set_meta_below = "test 123"
		}

		native_tests.print_to_everything("Setting preconditions for client-side testing...")
		for k,v in pairs(conditions) do

			local func = minetest.registered_chatcommands[k]
			local pre = "CONFIG ".."["..k.."]: "
			local eflag, res, msg
			if func then
				eflag, res, msg = pcall(func.func, name, v)
				if eflag then
					if res then
						native_tests.print_to_everything(pre.."COMPLETED; "..msg)
					else
						native_tests.print_to_everything(pre.."FAILED; "..msg)
					end
				else
					native_tests.print_to_everything(pre.."EXCEPTION; "..res)
				end
			else
				native_tests.print_to_everything(pre.."NOT FOUND\n")
			end
		end

		return true, "Finished setting preconditions on server"
	end
})