#include "native_settings.h"

std::string NativeSettings::native_get(LuaSettings *o, std::string key)
{
	if (o->l_getSettings()->exists(key))
		return (o->l_getSettings()->get(key));
	else
		return "";
}

//RETURN TO
bool NativeSettings::native_get_bool(LuaSettings *o, std::string key)
{
	return o->l_getSettings()->getBool(key);
}
		


bool NativeSettings::native_get_np_group(LuaSettings *o,std::string key, NoiseParams &np)
{
	return o->l_getSettings()->getNoiseParams(key, np);
}

bool NativeSettings::native_set_np_group(LuaSettings *o, std::string key, NoiseParams &val)
{
	return o->l_getSettings()->setNoiseParams(key, val);
}


//RETURN
/*
auto NativeSettings::native_get_flags(LuaSettings *o, std::string key)
{
	u32 flags = 0;
	auto flagdesc = o->l_getSettings()->getFlagDescFallback(key);
	return flagdesc;
}
*/

bool NativeSettings::native_set(LuaSettings *o,std::string key, const char *value)
{
	if (!o->l_getSettings()->set(key, value))
		throw LuaError("Invalid sequence found in setting parameters");

	return true;
}

bool NativeSettings::native_set_bool(LuaSettings *o, std::string key, bool value)
{
	return o->l_getSettings()->setBool(key, value);
}


bool NativeSettings::native_remove(LuaSettings *o,std::string key)
{
	bool s = o->l_getSettings()->remove(key);
	return s;
}

std::vector<std::string> NativeSettings::native_get_names(LuaSettings *o)
{
	std::vector<std::string> keys = o->l_getSettings()->getNames();
	return keys;
}
//CHECK, do we throw C++ exception here??
bool NativeSettings::native_write(LuaSettings *o)
{
	if (!o->l_getWriteAllowed()) {
		throw std::runtime_error("Settings: writing " + o->l_getFilename() +
				" not allowed: mod security is on.");
	}

	return o->l_getSettings()->updateConfigFile(o->l_getFilename().c_str());
}

std::vector<std::string> NativeSettings::native_to_table(LuaSettings *o)
{
	std::vector<std::string> keys = o->l_getSettings()->getNames();
	return keys;
}
