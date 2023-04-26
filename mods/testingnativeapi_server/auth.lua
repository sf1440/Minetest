--Note, functions are declared as 'l_auth_funcname', then registered as 'funcname' (different than other classes)
--IMPORTANT: by default core.auth (namespace with auth functions) is not available to mods (need to comment out line 9 in builtin\game\auth.lua) 
--builtin\game\auth.lua defines handler functions that modders interface with instead of core.auth
--see builtin\game\auth.lua for examples of how auth functions are used (they're not included in lua_api.txt)

minetest.register_chatcommand("lua_auth_read", {
	description = "Invokes lua_api > l_auth.lua_auth_read",
	func = function(self)
        local res = core.auth.read("singleplayer")
        if res then
            return true, "Success, read() returned: "..minetest.serialize(res)
        else
            return false, "Fail, auth entry for user not found" 
        end
	end
})

minetest.register_chatcommand("native_auth_read", {
	description = "Invokes lua_api > l_auth.l_native_auth_read > native_auth.native_auth_read",
	func = function(self)
        local res = core.auth.native_read("singleplayer")
        if res then
            return true, "Success, native_read() returned: "..minetest.serialize(res)
        else
            return false, "Fail, auth entry for user not found" 
        end
	end
})

minetest.register_chatcommand("test_auth_read", {
	description = "Asserts lua api and native api behaviors for l_auth.auth_read",
	func = function(self)
        local lua = core.auth.read("singleplayer")
        local native = core.auth.native_read("singleplayer")
        if lua and native then
            if minetest.serialize(lua) == minetest.serialize(native) then
                return true, "(Success) read()"
            else
                return false, "(Fail) read(), authEntries for singleplayer user are different"
            end
        else
            return false, "(Fail) read(), auth entries for user not found"
        end
	end
})

minetest.register_chatcommand("lua_auth_save", {
	description = "Invokes lua_api > l_auth.lua_auth_save",
	func = function(self)
        local user = "singleplayer"
        local entry = core.auth.read(user)

        if entry then
            entry.last_login = 1337
            core.auth.save(entry)
            entry = core.auth.read(user)

            if entry.last_login == 1337 then
                return true, "Success, save() updated last_login: "..entry.last_login
            else
                return false, "Fail, save() did not update last_login: "..entry.last_login
            end
        else
            return false, "Fail, save() could not read user "..user
        end
	end
})

minetest.register_chatcommand("native_auth_save", {
	description = "Invokes lua_api > l_auth.l_native_auth_save > native_auth.native_auth_save",
	func = function(self)
        local user = "singleplayer"
        local entry = core.auth.read(user)

        if entry then
            entry.last_login = 7331
            core.auth.native_save(entry)
            entry = core.auth.read(user)

            if entry.last_login == 7331 then
                return true, "Success, native_save() updated last_login: "..entry.last_login
            else
                return false, "Fail, native_save() did not update last_login: "..entry.last_login
            end
        else
            return false, "Fail, native_save() could not read user "..user
        end
	end
})

minetest.register_chatcommand("test_auth_save", {
	description = "Asserts lua api and native api behaviors for l_auth.auth_save",
	func = function(self)
        local user = "singleplayer"
        local entry = core.auth.read(user)

        if entry then
            entry.last_login = 42069
            core.auth.save(entry)
            entry = core.auth.read(user)

            if entry.last_login ~= 42069 then
                return false, "(Fail), save(), last_login was not updated"
            end

            entry.last_login = entry.last_login + 10
            core.auth.native_save(entry)
            entry = core.auth.read(user)

            if entry.last_login ~= 42079 then
                return false, "(Fail) native_save(), last_login was not updated"
            end
            return true, "(Success) save()"
        else
            return false, "(Fail) save(), could not read user "..user
        end
	end
})

--name needs to be unique
--default_privs = interact && shout (see https://wiki.minetest.net/Privileges for more details)
minetest.register_chatcommand("lua_auth_create", {
	description = "Invokes lua_api > l_auth.lua_auth_create",
	func = function(self)
        math.randomseed(os.time()) math.random(1,1000) math.random(1,1000)
        local name = "lua_user_"..math.random()
        local res = core.auth.create({
                name = name, 
                password = "pass123", 
                privileges = core.string_to_privs(core.settings:get("default_privs")),
                last_login = os.time()
            })
        if res then
            return true, "Success, create() returned: "..minetest.serialize(res)
        else
            return false, "Fail, create() could not create user "..user
        end
	end
})

minetest.register_chatcommand("native_auth_create", {
	description = "Invokes lua_api > l_auth.l_native_auth_create > native_auth.native_auth_create",
	func = function(self)
        math.randomseed(os.time()) math.random(1,1000) math.random(1,1000)
        local name = "native_user_"..math.random()
        local res = core.auth.native_create({
                name = name, 
                password = "pass123", 
                privileges = core.string_to_privs(core.settings:get("default_privs")),
                last_login = os.time()
            })
        if res then
            return true, "Success, native_create() returned: "..minetest.serialize(res)
        else
            return false, "Fail, native_create() could not create user "..user
        end
	end
})

minetest.register_chatcommand("test_auth_create", {
	description = "Asserts lua api and native api behaviors for l_auth.auth_create",
	func = function(self)
        math.randomseed(os.time()) math.random(1,1000) math.random(1,1000)
        local name1 = "test_user_"..math.random(1,1000)
        local name2 = "test_user_"..math.random(1,1000)
        local lua = core.auth.create({
            name = name1, 
            password = "pass123", 
            privileges = core.string_to_privs(core.settings:get("default_privs")),
            last_login = os.time()
        })
        local native = core.auth.create({
            name = name2, 
            password = "pass123", 
            privileges = core.string_to_privs(core.settings:get("default_privs")),
            last_login = os.time()
        })
        if lua and native then
            if lua.password == native.password then
                return true, "(Success), native_create()"
            else
                return false, "(Fail) create(), native and lua user are different"
            end
        else
            return false, "Fail, native_create() could not create lua and native users"
        end
	end
})

minetest.register_chatcommand("lua_auth_delete", {
	description = "Invokes lua_api > l_auth.lua_auth_delete",
	func = function(self)
        math.randomseed(os.time()) math.random(1,1000) math.random(1,1000)
        local name = "lua_user_"..math.random(1,1000)
        local user = core.auth.create({
            name = name, 
            password = "pass123", 
            privileges = core.string_to_privs(core.settings:get("default_privs")),
            last_login = os.time()
        })
        local res = core.auth.list_names()
        print("T1")
        if user and res then
            for k,v in pairs(res) do
                if v ~= "singleplayer" then
                    print("T2 - "..v)
                    if not core.auth.delete(v) then
                        return false, "Fail, delete() could not delete user "..v
                    end
                end
            end
            return true, "Success, delete() deleted all users except singleplayer"
        else
            return false, "Fail, no user to delete"
        end
	end
})

minetest.register_chatcommand("native_auth_delete", {
	description = "Invokes lua_api > l_auth.l_native_auth_delete > native_auth.native_auth_delete",
	func = function(self)
        math.randomseed(os.time()) math.random(1,1000) math.random(1,1000)
        local name = "lua_user_"..math.random(1,1000)
        local user = core.auth.create({
            name = name, 
            password = "pass123", 
            privileges = core.string_to_privs(core.settings:get("default_privs")),
            last_login = os.time()
        })
        local res = core.auth.list_names()

        if user and res then
            for k,v in pairs(res) do
                if v ~= "singleplayer" then
                    if not core.auth.native_delete(v) then
                        return false, "Fail, native_delete() could not delete user "..v
                    end
                end
            end
            return true, "Success, native_delete() deleted all users except singleplayer"
        else
            return false, "Fail, no user to delete"
        end
	end
})

minetest.register_chatcommand("test_auth_delete", {
	description = "Asserts lua api and native api behaviors for l_auth.auth_list_names",
	func = function(self)
        math.randomseed(os.time()) math.random(1,1000) math.random(1,1000)
        local name1 = "test_user_"..math.random(1,1000)
        local name2 = "test_user_"..math.random(1,1000)

        local lua = core.auth.create({
            name = name1, 
            password = "pass123", 
            privileges = core.string_to_privs(core.settings:get("default_privs")),
            last_login = os.time()
        })
        local native = core.auth.create({
            name = name2, 
            password = "pass123", 
            privileges = core.string_to_privs(core.settings:get("default_privs")),
            last_login = os.time()
        })

        if lua and native then
            if core.auth.delete(lua.name) and core.auth.native_delete(native.name) then
                local users = core.auth.list_names()
                for k,v in pairs(users) do
                    if v == lua.name or v == native.name then
                        return false, "(Fail) delete(), could not delete user "..v
                    end
                end
                return true, "(Success) delete(), deleted users "..lua.name.." and "..native.name
            else
                return false, "(Fail) delete(), could not delete users "..lua.name.." and "..native.name
            end
        else
            return false, "(Fail) delete(), no users to delete"
        end
	end
})

minetest.register_chatcommand("lua_auth_list_names", {
	description = "Invokes lua_api > l_auth.lua_auth_list_names",
	func = function(self)
        local res = core.auth.list_names()
		return true, "Success, list_names() returned: "..minetest.serialize(res)
	end
})

minetest.register_chatcommand("native_auth_list_names", {
	description = "Invokes lua_api > l_auth.l_native_auth_list_names > native_auth.native_auth_list_names",
	func = function(self)
        local res = core.auth.native_list_names()
		return true, "Success, native_list_names() returned: "..minetest.serialize(res)
	end
})

minetest.register_chatcommand("test_auth_list_names", {
	description = "Asserts lua api and native api behaviors for l_auth.auth_list_names",
	func = function(self)
        local lua = core.auth.list_names()
        local native = core.auth.native_list_names()
        if minetest.serialize(lua) == minetest.serialize(native) then
            return true, "(Success) list_names()"
        else
            return false, "(Fail) list_names(), lists of authenticated users are different"
        end
	end
})

--not sure if reload even does anything. underlying def is empty... 
minetest.register_chatcommand("lua_auth_reload", {
	description = "Invokes lua_api > l_auth.lua_auth_reload",
	func = function(self)
        core.auth.reload()
		return true, "Success, reload"
	end
})

minetest.register_chatcommand("native_auth_reload", {
	description = "Invokes lua_api > l_auth.l_native_auth_reload > native_auth.native_auth_reload",
	func = function(self)
        core.auth.native_reload()
		return true, "Success, native_reload"
	end
})

minetest.register_chatcommand("test_auth_reload", {
	description = "Asserts lua api and native api behaviors for l_auth.auth_reload",
	func = function(self)
        core.auth.reload()
        core.auth.native_reload()
        return true, minetest.serialize(core.auth.list_names())
	end
})

--command to test entire class
minetest.register_chatcommand("test_auth", {
	description = "testing all auth methods",
	func = function()

		local methods = {
			"read",
			"save",
			"create",
			"delete",
			"list_names",
			"reload"
		}

		return native_tests.test_class("auth", methods), 
		"Auth tests completed. See server_dump.txt for details."
	end
})