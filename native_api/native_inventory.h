#pragma once

#include "inventory.h"
#include "inventorymanager.h"
#include "server.h"
#include <vector>
#include "../script/lua_api/l_inventory.h"
#include "common/c_content.h"

class RemotePlayer;

class NativeInvRef
{
public:
	InventoryLocation m_loc;

	static bool native_is_empty(Inventory *inv, InventoryList *list);

	static int native_get_size(Inventory *inv, InventoryList *list);

	static int native_get_width(Inventory *inv, InventoryList *list);

	static bool native_set_size(Inventory *inv, const char *listname,
			InventoryList *list, int size);

	static int native_set_width(Inventory *inv, InventoryList *list, int size);

	static ItemStack native_get_stack(Inventory *inv, InventoryList *list, int i);

	static bool native_set_stack(
			Inventory *inv, InventoryList *list, int i, ItemStack item);

	// native_get_list - WRITTEN
	const InventoryList *native_get_list(Inventory *inv, const char *listname);

	// native_set_list -WIP Requires read_inventory_list(), will rewrite later
	static int NativeInvRef::native_set_list(Inventory *inv, const char *listname,
			std::vector<ItemStack> items, int forcesize = -1);

	// native_get_lists

	static std::vector<const InventoryList *> native_get_lists(Inventory *inv);

	static int native_set_lists(Inventory *inv, const char *listname,
			std::vector<ItemStack> items, int forcesize = -1);

	// native_set_lists -WIP Requires read_inventory_list(), will rewrite later

	// native_add_item -WIP requires LuaItemStack::create() , will rewrite later

	static bool native_room_for_item(
			Inventory *inv, InventoryList *list, ItemStack item);

	static bool native_contains_item(Inventory *inv, InventoryList *list,
			ItemStack item, bool match_meta);

	static ItemStack native_remove_item(
			Inventory *inv, InventoryList *list, ItemStack item);

	static int read_inventory_list_native(Inventory *inv, const char *name,
			int forcesize, std::vector<ItemStack> is);
};