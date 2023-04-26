#pragma once

#include "inventory.h"  // ItemStack
#include "tool.h" 
#include "server.h"
#include "nodedef.h"
#include "itemdef.h"
#include "log.h"
#include <tuple>
#include "../lua_api/l_item.h" // LuaItemStack
#include "../cpp_api/s_item.h"  // I think LuaItemStack
#include <utility>

class NativeItemStack {
public:
	static bool native_is_empty(LuaItemStack *o);
	static const char* native_get_name(LuaItemStack *o);
	static bool native_set_name(LuaItemStack *o, std::string name);
	static int native_get_count(LuaItemStack *o);
	static bool native_set_count(LuaItemStack *o, int count);
	static int native_get_wear(LuaItemStack *o);
	static bool native_set_wear(LuaItemStack *o, int wear);
	static ItemStack* native_get_meta(LuaItemStack *o);
	static const char *native_get_metadata(LuaItemStack *o);
	static bool native_set_metadata(LuaItemStack *o, size_t len, const char *ptr);
	static const char* native_get_description(LuaItemStack *o, IGameDef *gamedef);
	static const char* native_get_short_description(LuaItemStack *o, IGameDef *gamedef);
	static bool native_clear(LuaItemStack *o);
	static bool native_replace(LuaItemStack *o, ItemStack *itemstack);
	static const char* native_to_string(LuaItemStack *o);
	static std::tuple<const char *, int, int, const std::string &, std::vector<std::tuple<std::string, std::string>>> native_to_table(LuaItemStack *o);
	static int native_get_stack_max(LuaItemStack *o, IGameDef *gamedef);
	static int native_get_free_space(LuaItemStack *o, IGameDef *gamedef);
	static bool native_is_known(LuaItemStack *o, IGameDef *gamedef);
	static const char *native_get_definition(LuaItemStack *o);
	static ToolCapabilities native_get_tool_capabilities(LuaItemStack *o, IGameDef *gamedef);
	static bool native_add_wear(LuaItemStack *o, int amount, IGameDef *gamedef);
	static ItemStack native_add_item(LuaItemStack *o, ItemStack *new_item, IGameDef *gamedef);
	static std::tuple<bool, ItemStack> native_item_fits(LuaItemStack *o, ItemStack *new_item, IGameDef *gamedef);
	static ItemStack native_take_item(LuaItemStack *o, int count);
	static ItemStack native_peek_item(LuaItemStack *o, int count);
};

class NativeModApiItemMod {
public:
	static int native_register_item_raw(Server *server, ItemDefinition *def,
			ContentFeatures *f, std::string name);
	static int native_unregister_item_raw(Server *server, std::string name);
	static int native_register_alias_raw(Server *server, std::string name, std::string convert_to);
	static content_t native_get_content_id(IGameDef *def, std::string name);
	static const char* native_get_name_from_content_id(IGameDef *def, content_t *c);
};