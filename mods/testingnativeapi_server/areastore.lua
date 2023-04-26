local p1 = {}
p1.x = tonumber(0)
p1.y = tonumber(0)
p1.z = tonumber(0)

local p2 = {}
p2.x = tonumber(100)
p2.y = tonumber(100)
p2.z = tonumber(100)

local p3 = {}
p3.x = tonumber(101)
p3.y = tonumber(101)
p3.z = tonumber(101)

local p4 = {}
p4.x = tonumber(200)
p4.y = tonumber(200)
p4.z = tonumber(200)

-- get_area()
minetest.register_chatcommand("lua_areastore_getarea", {
	description = "Invokes lua_api > l_areastore.l_get_area",
	func = function(self)
        local areastore = AreaStore();
		local res = areastore:get_area(1, true, true)
        
		return true, "Success,get_area() Returned"..dump(res)
	end
})

minetest.register_chatcommand("native_areastore_getarea", {
	description = "Invokes lua_api > l_areastore.l_native_get_area > native_areastore.native_get_area",
	func = function(self)
        local areastore = AreaStore();
		local res = areastore:native_get_area(1, true, true)

		return true, "Success, native_get_area() Returned"..dump(res)
	end
})

minetest.register_chatcommand("test_areastore_getarea", {
	description = "Asserts lua api and native api behaviors for l_areastore.get_area",
	func = function(self)
        local areastore = AreaStore();
		local lua = areastore:get_area(1, true, true)
		local native = areastore:native_get_area(1, true, true)
		if lua == native then
			return true, "(Success) [AreaStore] get_area()"
		else
			return false, "(Fail) [AreaStore] get_area()"
		end
	end
})

-- get_areas_for_pos()
minetest.register_chatcommand("lua_areastore_getareasforpos", {
	description = "Invokes lua_api > l_areastore.l_get_areas_for_pos",
	func = function(self)
        local areastore = AreaStore();
		local res = areastore:get_areas_for_pos(p1, true, true)
		print("Success, get_areas_for_pos() returned: ")
        for key, value in pairs(res) do
    		print(key, value)
		end
		return true, ""
	end
})

minetest.register_chatcommand("native_areastore_getareasforpos", {
	description = "Invokes lua_api > l_areastore.l_native_get_areas_for_pos > native_areastore.native_get_areas_for_pos",
	func = function(self)
        local areastore = AreaStore();
		local res = areastore:native_get_areas_for_pos(p1, true, true)
		print("Success, native_get_areas_for_pos() returned: ")
        for key, value in pairs(res) do
    		print(key, value)
		end
		return true, ""
	end
})

minetest.register_chatcommand("test_areastore_getareasforpos", {
	description = "Asserts lua api and native api behaviors for l_areastore.get_areas_for_pos",
	func = function(self)
        local areastore = AreaStore();
		local lua = areastore:get_areas_for_pos(p1, true, true)
		local native = areastore:native_get_areas_for_pos(p1, true, true)
		if dump(lua) == dump(native) then
			return true, "(Success) [AreaStore] get_areas_for_pos()"
		else
			return false, "(Fail) [AreaStore] get_areas_for_pos()"
		end
	end
})

-- get_areas_in_area()
minetest.register_chatcommand("lua_areastore_getareasinarea", {
	description = "Invokes lua_api > l_areastore.l_get_areas_in_area",
	func = function(self)
        local areastore = AreaStore();
		local res = areastore:get_areas_in_area(p1, p2, true, true, true)
		print("Success, get_areas_in_area() returned: ")
        for key, value in pairs(res) do
    		print(key, value)
		end
		return true, ""
	end
})

minetest.register_chatcommand("native_areastore_getareasinarea", {
	description = "Invokes lua_api > l_areastore.l_native_get_areas_in_area > native_areastore.native_get_areas_in_area",
	func = function(self)
        local areastore = AreaStore();
		local res = areastore:native_get_areas_in_area(p1, p2, true, true, true)
		print("Success, native_get_areas_in_area() returned: ")
        for key, value in pairs(res) do
    		print(key, value)
		end
		return true, ""
	end
})

minetest.register_chatcommand("test_areastore_getareasinarea", {
	description = "Asserts lua api and native api behaviors for l_areastore.get_areas_in_area",
	func = function(self)
        local areastore = AreaStore();
		local lua = areastore:get_areas_in_area(p1, p2, true, true, true)
		local native = areastore:native_get_areas_in_area(p1, p2, true, true, true)
		if dump(lua) == dump(native) then
			return true, "(Success) [AreaStore] get_areas_in_area()"
		else
			return false, "(Fail) [AreaStore] get_areas_in_area()"
		end
	end
})

-- insert_area()
minetest.register_chatcommand("lua_areastore_insertarea", {
	description = "Invokes lua_api > l_areastore.l_insert_area",
	func = function(self)
        local areastore = AreaStore();
		local res = areastore:insert_area(p1, p2, "test", 1)
		return true, "Success, insert_area() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("native_areastore_insertarea", {
	description = "Invokes lua_api > l_areastore.l_native_insert_area > native_areastore.native_insert_area",
	func = function(self)
        local areastore = AreaStore();
		local res = areastore:native_insert_area(p1, p2, "test", 1)
		return true, "Success, native_insert_area() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("test_areastore_insertarea", {
	description = "Asserts lua api and native api behaviors for l_areastore.insert_area",
	func = function(self)
        local areastore = AreaStore();
		local lua = areastore:insert_area(p1, p2, "test", 1)
		local native = areastore:native_insert_area(p3, p4, "test2", 2)
		
		if (dump(lua) + 1) == native then
			return true, "(Success) [AreaStore] insert_area()"
		else
			return false, "(Fail) [AreaStore] insert_area()"
		end
	end
})

-- reserve()
minetest.register_chatcommand("lua_areastore_reserve", {
	description = "Invokes lua_api > l_areastore.l_reserve",
	func = function(self)
        local areastore = AreaStore();
		local res = areastore:reserve(1)
		return true, "Success, reserve()"
	end
})

minetest.register_chatcommand("native_areastore_reserve", {
	description = "Invokes lua_api > l_areastore.l_native_reserve > native_areastore.native_reserve",
	func = function(self)
        local areastore = AreaStore();
		local res = areastore:native_reserve(1)
		return true, "Success, native_reserve()"
	end
})

minetest.register_chatcommand("test_areastore_reserve", {
	description = "Asserts lua api and native api behaviors for l_areastore.reserve",
	func = function(self)
        local areastore = AreaStore();
		local lua = areastore:native_reserve(1)
		local native = areastore:native_reserve(1)

		if lua == native then
			return true, "(Success) [AreaStore] reserve()"
		else
			return false, "(Fail) [AreaStore] reserve()"
		end

	end
})

-- remove_area()
minetest.register_chatcommand("lua_areastore_removearea", {
	description = "Invokes lua_api > l_areastore.l_remove_area",
	func = function(self)
        local areastore = AreaStore();
		local res = areastore:remove_area(1)
		return true, "Success, remove_area() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("native_areastore_removearea", {
	description = "Invokes lua_api > l_areastore.l_native_remove_area > native_areastore.native_remove_area",
	func = function(self)
        local areastore = AreaStore();
		local res = areastore:native_remove_area(1)
		return true, "Success, native_remove_area() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("test_areastore_removearea", {
	description = "Asserts lua api and native api behaviors for l_areastore.remove_area",
	func = function(self)
        local areastore = AreaStore();
		local lua = areastore:remove_area(1)
		local native = areastore:native_remove_area(1)
		if lua == native then
			return true, "(Success) [AreaStore] remove_area()"
		else
			return false, "(Fail) [AreaStore] remove_area()"
		end
	end
})

-- set_cache_params()
minetest.register_chatcommand("lua_areastore_setcacheparams", {
	description = "Invokes lua_api > l_areastore.l_set_cache_parames",
	func = function(self)
        local areastore = AreaStore();
		local res = areastore:set_cache_params({1, 1, 1})
		return true, "Success, set_cache_params()"
	end
})

minetest.register_chatcommand("native_areastore_setcacheparams", {
	description = "Invokes lua_api > l_areastore.l_native_set_cache_params > native_areastore.native_set_cache_params",
	func = function(self)
        local areastore = AreaStore();
		local res = areastore:native_set_cache_params({1, 1, 1})
		return true, "Success, native_set_cache_params()"
	end
})

minetest.register_chatcommand("test_areastore_setcacheparams", {
	description = "Asserts lua api and native api behaviors for l_areastore_set_cache_params",
	func = function(self)
        local areastore = AreaStore();
		local lua = areastore:set_cache_params({1, 1, 1})
		local native = areastore:native_set_cache_params({1, 1, 1})

		if lua == native then
			return true, "(Success) [AreaStore] set_cache_params()"
		else
			return false, "(Fail) [AreaStore] set_cache_params()"
		end

	end
})

-- to_string()
minetest.register_chatcommand("lua_areastore_tostring", {
	description = "Invokes lua_api > l_areastore.l_to_string",
	func = function(self)
        local areastore = AreaStore();
		areastore:insert_area(p1, p2, "test-tostring", 3)
		local res = areastore:to_string()
		return true, "Success, to_string() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("native_areastore_tostring", {
	description = "Invokes lua_api > l_areastore.l_native_to_string > native_areastore.native_to_string",
	func = function(self)
        local areastore = AreaStore();
		areastore:insert_area(p1, p2, "test-tostring", 3)
		local res = areastore:native_to_string()
		return true, "Success, native_to_string() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("test_areastore_tostring", {
	description = "Asserts lua api and native api behaviors for l_areastore.to_string",
	func = function(self)
        local areastore = AreaStore();
		areastore:insert_area(p1, p2, "test-tostring", 3)
		local lua = areastore:to_string()
		local native = areastore:native_to_string()
		if lua == native then
			return true, "(Success) [AreaStore] to_string()"
		else
			return false, "(Fail) [AreaStore] to_string()"
		end
	end
})

-- to_file()
--Current location is in the directory of the world

minetest.register_chatcommand("lua_areastore_tofile", {
	description = "Invokes lua_api > l_areastore.l_to_file",
	func = function(self)
        local areastore = AreaStore();
		areastore:insert_area(p1, p2, "test", 1)
		local res = areastore:to_file(minetest.get_worldpath().."/test.txt")
		return true, "Success, to_file() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("native_areastore_tofile", {
	description = "Invokes lua_api > l_areastore.l_native_to_file > native_areastore.native_to_file",
	func = function(self)
        local areastore = AreaStore();
		areastore:insert_area(p1, p2, "test", 1)
		local res = areastore:native_to_file(minetest.get_worldpath().."/test.txt")
		return true, "Success, native_to_file() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("test_areastore_tofile", {
	description = "Asserts lua api and native api behaviors for l_areastore.to_file",
	func = function(self)
        local areastore = AreaStore();
		areastore:insert_area(p1, p2, "test-both", 3)
		local lua = areastore:to_file(minetest.get_worldpath().."/test.txt")
		local native = areastore:native_to_file(minetest.get_worldpath().."/test2.txt")
		if lua == native then
			return true, "(Success) [AreaStore] to_file()"
		else
			return false, "(Fail) [AreaStore] to_file()"
		end
	end
})

-- from_string()
minetest.register_chatcommand("lua_areastore_fromstring", {
	description = "Invokes lua_api > l_areastore.l_from_string",
	func = function(self)
        local areastore = AreaStore();
		areastore:insert_area(p1, p2, "test-tostring", 3)
		local str = areastore:to_string()
		local res = areastore:from_string(str)
		return true, "Success, from_string() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("native_areastore_fromstring", {
	description = "Invokes lua_api > l_areastore.l_native_from_string > native_areastore.native_from_string",
	func = function(self)
        local areastore = AreaStore();
		areastore:insert_area(p1, p2, "test-tostring", 3)
		local str = areastore:to_string()
		local res = areastore:native_from_string(str)
		return true, "Success, native_from_string() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("test_areastore_fromstring", {
	description = "Asserts lua api and native api behaviors for l_areastore.from_string",
	func = function(self)
        local areastore = AreaStore();
		areastore:insert_area(p1, p2, "test-tostring", 3)
		local str = areastore:to_string()
		local lua = areastore:from_string(str)
		local native = areastore:native_from_string(str)
		if lua == native then
			return true, "(Success) [AreaStore] from_string()"
		else
			return false, "(Fail) [AreaStore] from_string()"
		end
	end
})

-- from_file()
minetest.register_chatcommand("lua_areastore_fromfile", {
	description = "Invokes lua_api > l_areastore.l_from_file",
	func = function(self)
        local areastore = AreaStore();
		areastore:insert_area(p1, p2, "test-read", 3)
		areastore:to_file(minetest.get_worldpath().."/test2.txt")
		local res = areastore:from_file(minetest.get_worldpath().."/test2.txt")
		return true, "Success, from_file() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("native_areastore_fromfile", {
	description = "Invokes lua_api > l_areastore.l_native_from_file > native_areastore.native_from_file",
	func = function(self)
        local areastore = AreaStore();
		areastore:insert_area(p1, p2, "test-read", 3)
		areastore:to_file(minetest.get_worldpath().."/test2.txt")
		local res = areastore:native_from_file(minetest.get_worldpath().."/test2.txt")
		return true, "Success, native_from_file() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("test_areastore_fromfile", {
	description = "Asserts lua api and native api behaviors for l_areastore.from_file",
	func = function(self)
        local areastore = AreaStore();
		areastore:insert_area(p1, p2, "test-read", 3)
		local lua = areastore:from_file(minetest.get_worldpath().."/test2.txt")
		local native = areastore:native_from_file(minetest.get_worldpath().."/test2.txt")
		if lua == native then
			return true, "(Success) [AreaStore] from_file()"
		else
			return false, "(Fail) [AreaStore] from_file()"
		end
	end
})

--command to test entire class
minetest.register_chatcommand("test_areastore", {
	description = "testing all areastore methods",
	func = function()

		local methods = {
			"getarea",
			"getareasforpos",
			"getareasinarea",
			"insertarea",
			"reserve",
			"removearea",
			"setcacheparams",
			"tostring",
			"fromstring",
			"tofile",
			"fromfile"
		}

		return native_tests.test_class("areastore", methods), 
		"Areastore tests completed. See server_dump.txt for details."
	end
})