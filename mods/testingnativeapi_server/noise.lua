--Create noise generator to use for testing

testparam = {
   offset = 0,
   scale = 1,
   spread = {x=2048, y=2048, z=2048},
   seed = 1337,
   octaves = 6,
   persist = 0.6
}

mapDim = {x=3, y=3, z=3}

p = PerlinNoiseMap(testparam, mapDim);

loc = {x=1,y=1}
loc3d = {x=1,y=1,z=1}

sliceOffset={0,0,0}
sliceSize={2,2,2}

minetest.register_chatcommand("lua_noise_get2dmap", {
	description = "Invokes lua_api > l_noise.l_lua_noise_get_2d_map",
	func = function(self)
        local res = p:get_2d_map(loc);
        if res then
            return true, "Success, get_2d_map() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})


minetest.register_chatcommand("native_noise_get2dmap", {
	description = "Invokes lua_api > l_noise.l_native_noise_get_2d_map",
	func = function(self)
        local res = p:native_get_2d_map(loc);
        if res then
            return true, "Success, native_get_2d_map() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})

minetest.register_chatcommand("test_noise_get2dmap", {
	description = "Asserts lua api and native api behaviors for l_noise_get_2d_map",
	func = function(self)
		local lua = p:get_2d_map(loc);
		local native = p:native_get_2d_map(loc);
		if dump(lua) == dump(native) then
			return true, "(Success) [Noise] get_2d_map()"
		else
			return false, "(Fail) [Noise] get_2d_map()"
		end
	end
})

minetest.register_chatcommand("lua_noise_get2dmapflat", {
	description = "Invokes lua_api > l_noise.l_lua_noise_get_2d_map_flat",
	func = function(self)
        local res = p:get_2d_map_flat(loc,true);
        if res then
            return true, "Success, get_2d_map_flat() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})

minetest.register_chatcommand("native_noise_get2dmapflat", {
	description = "Invokes lua_api > l_noise.l_native_noise_get_2d_map_flat",
	func = function(self)
        local res = p:native_get_2d_map_flat(loc,true);
        if res then
            return true, "Success, native_get_2d_map_flat() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})

minetest.register_chatcommand("test_noise_get2dmapflat", {
	description = "Asserts lua api and native api behaviors for l_noise_get_2d_map_flat",
	func = function(self)
		local lua = p:get_2d_map_flat(loc,true);
		local native = p:native_get_2d_map_flat(loc,true);
		if dump(lua) == dump(native) then
			return true, "(Success) [Noise] get_2d_map_flat()"
		else
			return false, "(Fail) [Noise] get_2d_map_flat()"
		end
	end
})

minetest.register_chatcommand("lua_noise_get3dmap", {
	description = "Invokes lua_api > l_noise.l_lua_noise_get_3d_map",
	func = function(self)
        local res = p:get_3d_map(loc3d);
        if res then
            return true, "Success, get_3d_map() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})


minetest.register_chatcommand("native_noise_get3dmap", {
	description = "Invokes lua_api > l_noise.l_native_noise_get_3d_map",
	func = function(self)
        local res = p:native_get_3d_map(loc3d);
        if res then
            return true, "Success, native_get_3d_map() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})

minetest.register_chatcommand("test_noise_get3dmap", {
	description = "Asserts lua api and native api behaviors for l_noise_get_3d_map",
	func = function(self)
		local lua = p:get_3d_map(loc3d);
		local native = p:native_get_3d_map(loc3d);
		if dump(lua) == dump(native) then
			return true, "(Success) [Noise] get_3d_map()"
		else
			return false, "(Fail) [Noise] get_3d_map()"
		end
	end
})

minetest.register_chatcommand("lua_noise_get3dmapflat", {
	description = "Invokes lua_api > l_noise.l_lua_noise_get_3d_map_flat",
	func = function(self)
        local res = p:get_3d_map_flat(loc3d,false);
        if res then
            return true, "Success, get_3d_map_flat() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})


minetest.register_chatcommand("native_noise_get3dmapflat", {
	description = "Invokes lua_api > l_noise.l_native_noise_get_3d_map_flat",
	func = function(self)
        local res = p:native_get_3d_map_flat(loc3d,false);
        if res then
            return true, "Success, native_get_3d_map_flat() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})

minetest.register_chatcommand("test_noise_get3dmapflat", {
	description = "Asserts lua api and native api behaviors for l_noise_get_3d_map_flat",
	func = function(self)
		local lua = p:get_3d_map_flat(loc3d,false);
		local native = p:native_get_3d_map_flat(loc3d,false);
		if dump(lua) == dump(native) then
			return true, "(Success) [Noise] get_3d_map_flat()"
		else
			return false, "(Fail) [Noise] get_3d_map_flat()"
		end
	end
})

--NOTE: calc2dMap and calc3dMap return nothing to the lua stack

minetest.register_chatcommand("lua_noise_calc2dmap", {
	description = "Invokes lua_api > l_noise.l_lua_noise_calc_2d_map",
	func = function(self)
        local res = p:calc_2d_map(loc);
        return true, "Success, calc_2d_map() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_noise_calc2dmap", {
	description = "Invokes lua_api > l_noise.l_native_noise_calc_2d_map",
	func = function(self)
        local res = p:native_calc_2d_map(loc);
        return true, "Success, native_calc_2d_map() returned: "..dump(res)

	end
})

minetest.register_chatcommand("test_noise_calc2dmap", {
	description = "Asserts lua api and native api behaviors for l_noise_calc_2d_map",
	func = function(self)
		local lua = p:calc_2d_map(loc);
		local native = p:native_calc_2d_map(loc);
		if dump(lua) == dump(native) then
			return true, "(Success) [Noise] calc_2d_map()"
		else
			return false, "(Fail) [Noise] calc_2d_map()"
		end
	end
})


minetest.register_chatcommand("lua_noise_calc3dmap", {
	description = "Invokes lua_api > l_noise.l_lua_noise_calc_3d_map",
	func = function(self)
        local res = p:calc_3d_map(loc3d);
        return true, "Success, calc_3d_map() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_noise_calc3dmap", {
	description = "Invokes lua_api > l_noise.l_native_noise_calc_3d_map",
	func = function(self)
        local res = p:native_calc_3d_map(loc3d);
        return true, "Success, native_calc_3d_map() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_noise_calc3dmap", {
	description = "Asserts lua api and native api behaviors for l_noise_calc_3d_map",
	func = function(self)
		local lua = p:calc_3d_map(loc3d);
		local native = p:native_calc_3d_map(loc3d);
		if dump(lua) == dump(native) then
			return true, "(Success) [Noise] calc_3d_map()"
		else
			return false, "(Fail) [Noise] calc_3d_map()"
		end
	end
})

minetest.register_chatcommand("lua_noise_getmapslice", {
	description = "Invokes lua_api > l_noise.l_lua_noise_get_map_slice",
	func = function(self)
        local res = p:get_map_slice(sliceOffset,sliceSize,true);
        if res then
            return true, "Success, get_map_slice() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})

minetest.register_chatcommand("native_noise_getmapslice", {
	description = "Invokes lua_api > l_noise.l_native_noise_get_map_slice",
	func = function(self)
        local res = p:native_get_map_slice(sliceOffset,sliceSize,true);
        if res then
            return true, "Success, native_get_map_slice() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})

minetest.register_chatcommand("test_noise_getmapslice", {
	description = "Invokes lua_api > l_noise.l_native_noise_get_map_slice",
	func = function(self)
        local lua = p:get_map_slice(sliceOffset,sliceSize,true);
		local native = p:native_get_map_slice(sliceOffset,sliceSize,true);
		if dump(lua) == dump(native) then
			return true, "(Success) [Noise] get_map_slice()"
		else
			return false, "(Fail) [Noise] get_map_slice()"
		end
	end
})


--command to test entire class
minetest.register_chatcommand("test_noise", {
	description = "testing all noise methods",
	func = function()

		local methods = {
			"get2dmap",
			"get2dmapflat",
			"get3dmap",
			"get3dmapflat",
			"calc2dmap",
			"calc3dmap",
			"getmapslice"
		}

		return native_tests.test_class("noise", methods), 
		"Settings tests completed. See server_dump.txt for details."
	end
})