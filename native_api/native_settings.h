#pragma once
#include "util/string.h"
#include "./../lua_api/l_settings.h"
#include "settings.h"
#include "../../noise.h"

class Settings;

class NativeSettings
{
public:
	static std::string native_get(LuaSettings *o, std::string key);
	static bool native_get_bool(LuaSettings *o, std::string key);
	static bool native_get_np_group(LuaSettings *o, std::string key, NoiseParams &np);
	//static auto native_get_flags(LuaSettings *o,std::string key);
	static bool native_set(LuaSettings *o, std::string key, const char *value);
	static bool native_set_bool(LuaSettings *o,std::string key, bool value);
	static bool native_set_np_group(LuaSettings *o, std::string key, NoiseParams &val);
	static bool native_remove(LuaSettings *o,std::string key);
	static std::vector<std::string> native_get_names(LuaSettings *o);
	static bool native_write(LuaSettings *o);
	static std::vector<std::string> native_to_table(LuaSettings *o);

	//Helpers






};
