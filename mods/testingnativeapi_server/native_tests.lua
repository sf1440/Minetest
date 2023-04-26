local native_tests = {}

native_tests.file = nil
native_tests.dump_path = minetest.get_worldpath().."/server_dump.txt"

--can't clear dump file while open
function native_tests.clear_file ()
	if not native_tests.file then
		io.open(native_tests.dump_path, "w"):close()
	end
end

--only opens file if .file fd is set to nil (not open)
function native_tests.open_file ()
	if not native_tests.file then
		native_tests.file = io.open(native_tests.dump_path, "a")
		io.output(native_tests.file)
	end
end

--write text, table, or custom minetest obj to file
function native_tests.write (obj)
	if native_tests.file then
		if type(obj) == "table" then
			native_tests.file:write(minetest.serialize(obj))
		elseif type(obj) == "string" then
			native_tests.file:write(obj)
		else
			native_tests.file:write(dump(obj))
		end
	end
end

--close file if there is an open fd
function native_tests.close_file ()
	if native_tests.file then
		io.close(native_tests.file)
		native_tests.file = nil
	end
end

--send a string to console
function native_tests.log(msg)
	minetest.log("action", msg)
end

--send a string to chat and console
function native_tests.print_to_everything(msg)
	minetest.log("action", msg)
	minetest.chat_send_all(msg)
end

--pcall is used to test command, stack traces are not preserved
--message logged with test will be the message returned from the invoked chat command
function native_tests.test_command (class, method)

	local api = {"lua", "native", "test"}
	local hits = 0

	for v,k in pairs(api) do

		local cmd = k.."_"..class.."_"..method
		local entry = minetest.registered_chatcommands[cmd]
		native_tests.write("["..cmd.."] ")

		if entry then
			local eflag, res, msg = pcall(minetest.registered_chatcommands[cmd].func)
	
			if eflag then
				if res then
					native_tests.write("PASSED: "..msg.."\n")
					hits = hits + 1
				else
					native_tests.write("FAILED: "..msg.."\n")
				end
			else
				native_tests.write("EXCEPTION: "..res.."\n")
			end
		else
			native_tests.write("NOT FOUND\n")
		end
	end

	return hits
end

--invokes test_command for each command in methods table
function native_tests.test_class (class, methods)

	native_tests.open_file()
	native_tests.write("-----"..string.upper(class).." TESTS-----\n")

	local total = 0
	local hits = 0
	for k,v in pairs(methods) do
		local res = native_tests.test_command(class, v)
		hits = hits + res
		total = total + 3
	end

	native_tests.write(string.upper(class).." TESTS COMPLETED: "..hits.." PASSED, "..total-hits.." FAILED\n\n")
	native_tests.close_file();

	if (total-hits) ~= 0 then return false else return true end
end

return native_tests