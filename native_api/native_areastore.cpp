#include "native_areastore.h"
#include "util/areastore.h"
#include "filesys.h"
#include <fstream>
#include <tuple>

static std::tuple<bool*, v3s16*, v3s16*, std::string*> push_area(
	const Area *a, bool include_borders, bool include_data)
{
	std::tuple<bool*, v3s16*, v3s16*, std::string*> result = std::make_tuple(nullptr, nullptr, nullptr, nullptr);
	if (!include_borders && !include_data) {
		*std::get<0>(result) = true;
		return result;
	}
	if (include_borders) {
		*std::get<1>(result) = a->minedge;
		*std::get<2>(result) = a->maxedge;
	}
	if (include_data) {
		*std::get<3>(result) = a->data.c_str();
	}
	return result;
}

static std::map<u32, std::tuple<bool*, v3s16*, v3s16*, std::string*>> push_areas(
	const std::vector<Area *> &areas, bool include_borders,bool include_data)
{
	size_t cnt = areas.size();
	std::map<u32, std::tuple<bool*, v3s16*, v3s16*, std::string*>> result;
	for (size_t i = 0; i < cnt; i++) {
		// TODO: some sort of save for area to id?
		result[areas[i]->id] =
				push_area(areas[i], include_borders, include_data);
	}

	return result;
}

std::tuple<bool, const char *> NativeAreaStore::deserialization_helper(
		AreaStore *as, std::istream &is)
{
	std::tuple<bool, const char *> result;
	try {
		as->deserialize(is);
	} catch (const SerializationError &e) {
		std::get<0>(result) = false;
		std::get<1>(result) = e.what();
		return result;
	}
	std::get<0>(result) = true;
	return result;
}

std::tuple<bool*, v3s16*, v3s16*, std::string*> NativeAreaStore::native_get_area(const Area *res, u32 id,
	bool include_borders, bool include_data)
{
	return push_area(res, include_borders, include_data);
}

std::map<u32, std::tuple<bool*, v3s16*, v3s16*, std::string*>> NativeAreaStore::native_get_areas_for_pos(LuaAreaStore *o, v3s16 pos,
	bool include_borders, bool include_data)
{
	AreaStore *ast = o->as;
	std::vector<Area *> res;

	ast->getAreasForPos(&res, pos);
	return push_areas(res, include_borders, include_data);
}

std::map<u32, std::tuple<bool*, v3s16*, v3s16*, std::string*>> NativeAreaStore::native_get_areas_in_area(LuaAreaStore *o, v3s16 minedge,
	v3s16 maxedge, bool include_borders,
	bool include_data, bool accept_overlap)
{
	AreaStore *ast = o->as;
	std::vector<Area *> res;

	ast->getAreasInArea(&res, minedge, maxedge, accept_overlap);
	return push_areas(res, include_borders, include_data);
}

int NativeAreaStore::native_insert_area(LuaAreaStore *o, v3s16 edge1,
	v3s16 edge2, std::string data,
	int *id)
{
	AreaStore *ast = o->as;

	// believe these are minedge and maxedge based off of of origian lua index
	Area a(edge1, edge2);

	a.data = data;

	if (id != nullptr)
		a.id = *id;

	// Insert & assign a new ID if necessary
	if (!ast->insertArea(&a))
		return 0;
	//changed from -1, may not be necessary.

	return a.id;
}

int NativeAreaStore::native_reserve(LuaAreaStore *o, size_t count)
{
	AreaStore *ast = o->as;

	ast->reserve(count);
	return 0;
}

bool NativeAreaStore::native_remove_area(LuaAreaStore *o, u32 id)
{
	AreaStore *ast = o->as;

	return ast->removeArea(id);
}

int NativeAreaStore::native_set_cache_params(LuaAreaStore *o, bool *enabled,
	u8 *block_radius, size_t *limit)
{
	AreaStore *ast = o->as;

	ast->setCacheParams(*enabled, *block_radius, *limit);
	return 0;
}

std::string NativeAreaStore::native_to_string(LuaAreaStore *o)
{
	std::ostringstream os(std::ios_base::binary);
	o->as->serialize(os);
	return os.str();
}

bool NativeAreaStore::native_to_file(LuaAreaStore *o, std::string filename)
{
	AreaStore *ast = o->as;

	std::ostringstream os(std::ios_base::binary);
	ast->serialize(os);

	return fs::safeWriteToFile(filename, os.str());
}

std::tuple<bool, const char*> NativeAreaStore::native_from_string(LuaAreaStore *o, std::string str)
{
	AreaStore *ast = o->as;

	std::istringstream is(str, std::ios::binary);
	return deserialization_helper(ast, is);
}

std::tuple<bool, const char*> NativeAreaStore::native_from_file(LuaAreaStore *o, std::string filename)
{
	AreaStore *ast = o->as;

	std::ifstream is(filename, std::ios::binary);
	return deserialization_helper(ast, is);
}
