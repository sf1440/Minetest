#include "native_inventory.h"
#include "server.h"

bool NativeInvRef::native_is_empty(Inventory* inv, InventoryList* list)
{
	if (list && list->getUsedSlots() > 0) {
		return false;
	} 
	else {
		return true;
	}
}

int NativeInvRef::native_get_size(Inventory* inv, InventoryList* list)
{
	if (list) {
		return list->getSize();
	} else {
		return 0;
	}
}

int NativeInvRef::native_get_width(Inventory *inv, InventoryList *list)
{
	if (list) {
		return list->getWidth();
	} else {
		return 0;
	}
}

bool NativeInvRef::native_set_size(
		Inventory *inv, const char *listname, InventoryList *list, int size)
{
	if (size < 0) {
		return false;
	}
	if (inv == NULL) {
		return false;
	}
	if (size == 0) {
		inv->deleteList(listname);
		return true;
	}
	if (list) {
		list->setSize(size);
	} 
	else {
		list = inv->addList(listname, size);
		if (!list) {
			return false;
		}
	}
	return true;
}

int NativeInvRef::native_set_width(Inventory *inv, InventoryList *list, int size)
{
	if (inv == NULL) {
		return 0;
	}
	if (list) {
		list->setWidth(size);
	} 
	else {
		return 0;
	}
	return 0;
}

ItemStack NativeInvRef::native_get_stack(Inventory *inv, InventoryList *list, int i)
{
	ItemStack item;
	if (list != NULL && i >= 0 && i < (int)list->getSize()) {
		item = list->getItem(i);
	}
	return item;
}

bool NativeInvRef::native_set_stack(
		Inventory *inv, InventoryList *list, int i, ItemStack item)
{
	if (list != NULL && i >= 0 && i < (int)list->getSize()) {
		list->changeItem(i, item);
		return true;
	} 
	else {
		return false;
	}
}

// native_get_list

const InventoryList *NativeInvRef::native_get_list(Inventory *inv, const char *listname)
{
	if (inv) {
		return inv->getList(listname);
		// do I return a ref here?
	} else {
		return nullptr;
	}
}

// native_set_list -- How to write this?


int NativeInvRef::native_set_list(Inventory *inv, const char *listname,
		std::vector<ItemStack> items, int forcesize)
{
	read_inventory_list_native(inv, listname, forcesize, items);
	return 0;
}


std::vector<const InventoryList *> NativeInvRef::native_get_lists(Inventory *inv)
{
	std::vector<const InventoryList *> lists = inv->getLists();
	return lists;
}

int NativeInvRef::native_set_lists(Inventory *inv, const char *listname,
		std::vector<ItemStack> items, int forcesize)
{
	read_inventory_list_native(inv, listname, forcesize, items);
	return 0;
}

// native_add_item

/*
bool NativeInvRef::native_add_item(Inventory *inv, InventoryList *list, ItemStack item,
const char *listname)
{
	/*

	if (list) {
		ItemStack leftover = list->addItem(item);
		if (leftover.count != item.count)
			inv->addItem(listname, leftover);
	} else {
		inv->addItem(listname, item);
	}
}
	*/


bool NativeInvRef::native_room_for_item(
		Inventory *inv, InventoryList *list, ItemStack item)
{
	if (list) {
		return list->roomForItem(item);
	} 
	else {
		return false;
	}
}

bool NativeInvRef::native_contains_item(
		Inventory *inv, InventoryList *list, ItemStack item, bool match_meta)
{
	if (list) {
		return list->containsItem(item, match_meta);
	} 
	else {
		return false;
	}
}

ItemStack NativeInvRef::native_remove_item(
		Inventory *inv, InventoryList *list, ItemStack item)
{
	if (list) {
		ItemStack removed = list->removeItem(item);
		if (!removed.empty()) {
			return removed;
		} 
		else {
			return ItemStack();
		}
	}
}

//takes in a vector of itemstacks from read_inventorylist_helper

int NativeInvRef::read_inventory_list_native(Inventory *inv, const char *name, int forcesize, std::vector<ItemStack> is)
{
	int listsize = (forcesize != -1) ? forcesize : is.size();
	InventoryList *invlist = inv->addList(name, listsize);
	int index = 0;
	for (std::vector<ItemStack>::const_iterator i = is.begin(); i != is.end();
			++i) {
		if (forcesize != -1 && index == forcesize)
			break;
		invlist->changeItem(index, *i);
		index++;
	}
	while (forcesize != -1 && index < forcesize) {
		invlist->deleteItem(index);
		index++;
	}
	return 1;
}




