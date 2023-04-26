--is_empty()

--make one player and inventory
--replace every instance of name with �singleplayer"
--stack = ItemStack(�default:stone 99�)


minetest.register_chatcommand("lua_inventory_isempty", {
	description = "Invokes lua_api > l_inventory.l_is_empty()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:is_empty("main");
		if res then
			return true, "Success, is_empty() returned: true"
		else
			return true, "Success, is_empty() returned: false"
		end
	end
})

minetest.register_chatcommand("native_inventory_isempty", {
	description = "Invokes lua_api > l_inventory.l_native_is_empty()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:native_is_empty("main");
		if res then
			return true, "Success, native_is_empty() returned: true"
		else
			return true, "Success, native_is_empty() returned: false"
		end
	end
})

minetest.register_chatcommand("test_inventory_isempty", {
	description = "Compares output of lua and native command for is_empty()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local lres = inv:is_empty("main")
		local nres = inv:native_is_empty("main")
		if lres then
			print("l_is_empty() returned true")
		else
			print("l_is_empty() returned false")
		end
		if nres then
			print("native_is_empty() returned true")
		else
			print("native_is_empty() returned false")
		end
		if lres == nres then
			return true, "Success, function output matches - check console for more details"
		else
			return false, "Failure, function output does not match - check console for more details"
		end
	end
})

--get_size()
minetest.register_chatcommand("lua_inventory_getsize", {
	description = "Invokes lua_api > l_inventory.l_get_size()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:get_size("main");
		return true, "Success, get_size() returned: "..res
	end
})

minetest.register_chatcommand("native_inventory_getsize", {
	description = "Invokes lua_api > l_inventory.l_native_get_size()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:native_get_size("main");
		return true, "Success, native_get_size() returned: "..res
	end
})

minetest.register_chatcommand("test_inventory_getsize", {
	description = "Compares output of lua and native command for get_size()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local lres = inv:get_size("main")
		local nres = inv:native_get_size("main")
		print("l_get_size() returned: "..lres)
		print("native_get_size() returned: "..nres)
		if lres == nres then
			return true, "Success, function output matches - check console for more details"
		else
			return false, "Failure, function output does not match - check console for more details"
		end
	end
})

--set_size()
minetest.register_chatcommand("lua_inventory_setsize", {
	description = "Invokes lua_api > l_inventory.l_set_size()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:set_size("main", 16);
		if res then
			return true, "Success, set_size() returned: true"
		else
			return true, "Success, set_size() returned: false"
		end
	end
})

minetest.register_chatcommand("native_inventory_setsize", {
	description = "Invokes lua_api > l_inventory.l_native_set_size()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:native_set_size("main", 16);
		if res then
			return true, "Success, native_set_size() returned: true"
		else
			return true, "Success, native_set_size() returned: false"
		end
	end
})

minetest.register_chatcommand("test_inventory_setsize", {
	description = "Compares output of lua and native command for set_size()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		inv:set_size("main", 16)
		lres = inv:get_size("main")
		inv:native_set_size("main", 16)
		nres = inv:get_size("main")
		print("l_set_size() set inventory to size: "..lres)
		print("native_set_size() set inventory to sizef: "..nres)
		if lres == nres then
			return true, "Success, function output matches - check console for more details"
		else
			return false, "Failure, function output does not match - check console for more details"
		end
	end
})

--get_width()
minetest.register_chatcommand("lua_inventory_getwidth", {
	description = "Invokes lua_api > l_inventory.l_get_width()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:get_width("main");
		return true, "Success, get_width() returned: "..res
	end
})

minetest.register_chatcommand("native_inventory_getwidth", {
	description = "Invokes lua_api > l_inventory.l_native_get_width()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:native_get_width("main");
		return true, "Success, native_get_width() returned: "..res
	end
})

minetest.register_chatcommand("test_inventory_getwidth", {
	description = "Compares output of lua and native command for get_width()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local lres = inv:get_width("main")
		local nres = inv:native_get_width("main")
		print("l_get_width() returned: "..lres)
		print("native_get_width() returned: "..nres)
		if lres == nres then
			return true, "Success, function output matches - check console for more details"
		else
			return false, "Failure, function output does not match - check console for more details"
		end
	end
})

--set_width()

minetest.register_chatcommand("lua_inventory_setwidth", {
	description = "Invokes lua_api > l_inventory.l_set_width()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:set_width("main", 6);
		if res then
			return true, "Success, set_width() returned: true"
		else
			return true, "Success, set_width() returned: false"
		end
	end
})

minetest.register_chatcommand("native_inventory_setwidth", {
	description = "Invokes lua_api > l_inventory.l_native_set_width()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:native_set_width("main", 8);
		return true, "Success, native_set_width() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("test_inventory_setwidth", {
	description = "Compares output of lua and native command for set_width()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()

		inv:set_width("main", 6)
		lres = inv:get_width("main")
		inv:native_set_width("main", 6)
		nres = inv:get_width("main")

		print("l_set_width() set inventory to size: "..tostring(lres))
		print("native_set_width() set inventory to sizef: "..tostring(nres))
		if lres == nres then
			return true, "Success, function output matches - check console for more details"
		else
			return false, "Failure, function output does not match - check console for more details"
		end
	end
})

--get_stack()
--TODO: Find way to display info about item stack
minetest.register_chatcommand("lua_inventory_getstack", {
	description = "Invokes lua_api > l_inventory.l_get_stack()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:get_stack("main", 1);
		return true, "Success, get_stack() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("native_inventory_getstack", {
	description = "Invokes lua_api > l_inventory.l_native_get_stack()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:native_get_stack("main",1);
		return true, "Success, native_get_stack() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("test_inventory_getstack", {
	description = "Compares output of lua and native command for get_stack()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()

		local lres = inv:get_stack("main", 1)
		local nres = inv:native_get_stack("main", 1)
		print("l_get_stack() returned: "..tostring(lres))
		print("native_get_stack() returned: "..tostring(nres))
		if tostring(lres) == tostring(nres) then
			return true, "Success, function output matches - check console for more details"
		else
			return false, "Failure, function output does not match - check console for more details"
		end
	end
})

--set_stack()

minetest.register_chatcommand("lua_inventory_setstack", {
	description = "Invokes lua_api > l_inventory.l_set_stack()",
	func = function(self)
		local items = ItemStack("default:stone 99")
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:set_stack("main", 1, items);
		return true, "Success, set_stack() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("native_inventory_setstack", {
	description = "Invokes lua_api > l_inventory.l_native_set_stack()",
	func = function(self)
		local items = ItemStack("default:stone 99")
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:native_set_stack("main", 1, items);
		return true, "Success, native_set_stack() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("test_inventory_setstack", {
	description = "Compares output of lua and native command for set_stack()",
	func = function(self)

		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local items = ItemStack("default:stone 99")

		inv:set_stack("main", 1, items)
		lres = inv:get_stack("main", 1)
		inv:native_set_stack("main", 1, items)
		nres = inv:get_stack("main", 1)

		print("l_set_stack() set stack to "..tostring(lres))
		print("native_set_stack() set stack to: "..tostring(nres))
		if tostring(lres) == tostring(nres) then
			return true, "Success, function output matches - check console for more details"
		else
			return false, "Failure, function output does not match - check console for more details"
		end
	end
})

--get_list()

minetest.register_chatcommand("lua_inventory_getlist", {
	description = "Invokes lua_api > l_inventory.l_get_list()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:get_list("main");

		return true, "Success, get_list() returned: " ..dump(res)
	end


	--iterate over each element in table
})


minetest.register_chatcommand("native_inventory_getlist", {
	description = "Invokes lua_api > l_inventory.l_native_get_list()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:native_get_list("main");

		return true, "Success, native_get_list() returned: " ..dump(res)
	end
})

minetest.register_chatcommand("test_inventory_getlist", {
	description = "Compares output of lua and native command for get_list()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local lua = inv:get_list("main")
		local native = inv:native_get_list("main")

		if lua == native then
			return true, "Success, function output matches - check console for more details"
		else
			return false, "Failure, function output does not match - check console for more details"
		end
	end
})



--set_list()

minetest.register_chatcommand("lua_inventory_setlist", {
	description = "Invokes lua_api > l_inventory.l_get_list()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local testDirt = ItemStack("default:dirt 1")
		inv:add_item("main", testDirt)
		local stack = ItemStack("default:stone 99")
		inv:add_item("craft", stack)
		local list = inv:get_list("craft")

		local res = inv:set_list("main", list);
		return true, "Success, set_list() returned: "..tostring(res)
	end
})


minetest.register_chatcommand("native_inventory_setlist", {
	description = "Invokes lua_api > l_inventory.l_native_set_list()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local stack = ItemStack("default:diamondblock 99")
		inv:add_item("craft", stack)

		local testDirt = ItemStack("default:dirt 1")
		inv:add_item("main", testDirt)

		local list = inv:get_list("craft")
		local res = inv:native_set_list("main", list)

		return true, "Success, set_list() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("test_inventory_setlist", {
	description = "Compares output of lua and native command for set_list()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()

		local testDirt = ItemStack("default:dirt 1")
		inv:add_item("main", testDirt)

		local stack = ItemStack("default:diamondblock 99")
		inv:add_item("craft", stack)
		local list = inv:get_list("craft")

		local lua = inv:set_list("main", list)

		local stack2 = ItemStack("default:sand 99")
		inv:remove_item("craft", stack)
		inv:add_item("craft", stack2)
		local list = inv:get_list("craft")
		local native = inv:native_set_list("main", list)

		if tostring(lua) == tostring(native) then
			return true, "Success, function output matches - check console for more details"
		else
			return false, "Failure, function output does not match - check console for more details"
		end

	end
})

--]]

--get_lists()

minetest.register_chatcommand("lua_inventory_getlists", {
	description = "Invokes lua_api > l_inventory.l_get_lists()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:get_lists();
		return true, "Success, get_lists() returned: "..dump(res)
	end
	
})

minetest.register_chatcommand("native_inventory_getlists", {
	description = "Invokes lua_api > l_inventory.l_native_gets_lists()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:native_get_lists();
		return true, "Success, native_get_lists() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_inventory_getlists", {
	description = "Compares output of lua and native command for get_lists()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()

		local lres = inv:get_lists()
		local nres = inv:native_get_lists()
		print("l_get_lists() returned: "..dump(lres))
		print("native_get_lists() returned: "..dump(nres))
		if dump(lres) == dump(nres) then
			return true, "Success, function output matches - check console for more details"
		else
			return false, "Failure, function output does not match - check console for more details"
		end
	end
})


--set_lists()
--[[
minetest.register_chatcommand("lua_inventory_setlists", {
	description = "Invokes lua_api > l_inventory.l_set_lists()",
	func = function(name, param)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local testDirt = ItemStack("default:dirt 1")
		
		local res = inv:set_lists("main", "craft", testDirt)
		return true, "Success, set_lists() returned: "..res
	end
})

minetest.register_chatcommand("native_setlists", {
	description = "Invokes lua_api > l_inventory.l_native_set_lists()",
	func = function(name, param)
	end
})

minetest.register_chatcommand("test_setlists", {
	description = "Compares output of lua and native command for set_lists()",
	func = function(name, param)
	end
})

--]]

--add_item()

minetest.register_chatcommand("lua_inventory_additem", {
	description = "Invokes lua_api > l_inventory.l_add_item()",
	func = function(self)
		local items = ItemStack("default:stone 99")
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:add_item("main", items);
		return true, "Success, add_item() returned: "..tostring(res)
	end
})

--[[
minetest.register_chatcommand("native_additem", {
	description = "Invokes lua_api > l_inventory.l_native_add_item()",
	
})

minetest.register_chatcommand("test_additem", {
	description = "Compares output of lua and native command for add_item()",
	func = function(name, param)
	end
})

--]]

--room_for_item()

minetest.register_chatcommand("lua_inventory_roomforitem", {
	description = "Invokes lua_api > l_inventory.l_room_for_item()",
	func = function(self)
		local items = ItemStack("default:stone 99")
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:room_for_item("main", items);
		return true, "Success, room_for_item() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("native_inventory_roomforitem", {
	description = "Invokes lua_api > l_inventory.l_native_room_for_item()",
	func = function(self)
		local items = ItemStack("default:stone 99")
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:native_room_for_item("main", items);
		return true, "Success, native_room_for_item() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("test_inventory_roomforitem", {
	description = "Compares output of lua and native command for room_for_item()",
	func = function(self)
		local items = ItemStack("default:stone 99")
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()

		local lres = inv:room_for_item("main", items)
		local nres = inv:native_room_for_item("main", items)
		print("l_room_for_item() returned: "..tostring(lres))
		print("native_room_for_item() returned: "..tostring(nres))
		if lres == nres then
			return true, "Success, function output matches - check console for more details"
		else
			return false, "Failure, function output does not match - check console for more details"
		end
	end
})

--contains_item()

minetest.register_chatcommand("lua_inventory_containsitem", {
	description = "Invokes lua_api > l_inventory.l_contains_item()",
	func = function(self)
		local items = ItemStack("default:stone 99")
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:contains_item("main",items)
		return true, "Success, contains_item() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("native_inventory_containsitem", {
	description = "Invokes lua_api > l_inventory.l_native_contains_item()",
	func = function(self)
		local items = ItemStack("default:stone 99")
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:native_contains_item("main", items)
		return true, "Success, native_contains_item() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("test_inventory_containsitem", {
	description = "Compares output of lua and native command for contains_item()",
	func = function(self)
		local items = ItemStack("default:stone 99")
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()

		local lres = inv:contains_item("main", item)
		local nres = inv:native_contains_item("main", item)
		print("l_contains_item() returned: "..tostring(lres))
		print("native_contains_item() returned: "..tostring(nres))
		if lres == nres then
			return true, "Success, function output matches - check console for more details"
		else
			return false, "Failure, function output does not match - check console for more details"
		end
	end
})

--remove_item()

minetest.register_chatcommand("lua_inventory_removeitem", {
	description = "Invokes lua_api > l_inventory.l_remove_item()",
	func = function(self)
		local items = ItemStack("default:stone 99")
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:remove_item("main", items)
		return true, "Success, remove_item() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("native_inventory_removeitem", {
	description = "Invokes lua_api > l_inventory.l_native_remove_item()",
	func = function(self)
		local items = ItemStack("default:stone 99")
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:native_remove_item("main", items)
		return true, "Success, native_remove_item() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("test_inventory_removeitem", {
	description = "Compares output of lua and native command for remove_item()",
	func = function(self)
		local items = ItemStack("default:stone 99")
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		inv:add_item("main", items)
		inv:add_item("main", items)
		local lres = inv:remove_item("main", items)
		local nres = inv:native_remove_item("main", items)

		print("l_remove_item() returned: "..tostring(lres))
		print("native_remove_item() returned: "..tostring(nres))

		if tostring(lres) == tostring(nres) then
			return true, "Success, function output matches - check console for more details"
		else
			return false, "Failure, function output does not match - check console for more details"
		end
	end
})


--get_location()

minetest.register_chatcommand("lua_inventory_getlocation", {
	description = "Invokes lua_api > l_inventory.l_get_location()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer")
		local inv = player:get_inventory()
		local res = inv:get_location()
		return true, "Success, get_location() returned: "..tostring(res)
	end
})

--[[



minetest.register_chatcommand("native_getlocation", {
	description = "Invokes lua_api > l_inventory.l_get_location()",
	func = function(name, param)
	end
	
})

minetest.register_chatcommand("test_getlocation", {
	description = "Compares output of lua and native command for get_location()",
	func = function(name, param)
	end
})

--]]

minetest.register_chatcommand("test_inventory", {
	description = "testing all inventory methods",
	func = function()

		local methods = {
			"isempty",
			"getsize",
			"setsize",
			"getwidth",
			"setwidth",
			"getstack",
			"setstack",
			"setlist",
			"getlists",
			"roomforitem",
			"containsitem",
			"removeitem"
		}

		return native_tests.test_class("inventory", methods), 
		"Inventory tests completed. See server_dump.txt for details."
	end
})
