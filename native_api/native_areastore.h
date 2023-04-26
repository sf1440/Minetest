#pragma once
#include "irr_v3d.h"
#include <tuple>
#include <string>
#include <map>
#include "util/areastore.h"
#include "./../lua_api/l_areastore.h"

class NativeAreaStore
{
public:
	static std::tuple<bool*, v3s16*, v3s16*, std::string*> native_get_area(const Area *res, u32 id,
		bool include_borders, bool include_data);
	static std::map<u32, std::tuple<bool*, v3s16*, v3s16*, std::string*>> native_get_areas_for_pos(LuaAreaStore *o, v3s16 pos,
		bool include_borders,bool include_data);
	static std::map<u32, std::tuple<bool*, v3s16*, v3s16*, std::string*>> native_get_areas_in_area(LuaAreaStore *o, v3s16 minedge,
		v3s16 maxedge, bool include_borders,
		bool include_data, bool accept_overlap);
	static int native_insert_area(LuaAreaStore *o, v3s16 edge1,
		v3s16 edge2, std::string data,
		int *id = nullptr);
	static int native_reserve(LuaAreaStore *o, size_t count);
	static bool native_remove_area(LuaAreaStore *o, u32 id);
	static int native_set_cache_params(LuaAreaStore *o, bool *enabled = nullptr,
		u8 *block_radius = nullptr, size_t *limit = nullptr);
	static std::string native_to_string(LuaAreaStore *o);
	static bool native_to_file(LuaAreaStore *o, std::string filename);
	static std::tuple<bool, const char*> native_from_string(LuaAreaStore *o, std::string str);
	static std::tuple<bool, const char*> native_from_file(LuaAreaStore *o, std::string filename);
	static std::tuple<bool, const char *> deserialization_helper(AreaStore *as, std::istream &is);
};
