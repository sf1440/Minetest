#include "native_item.h"

bool NativeItemStack::native_is_empty(LuaItemStack *o)
{
	ItemStack &item = o->m_stack;
    return item.empty();
}

const char* NativeItemStack::native_get_name(LuaItemStack *o)
{
	ItemStack &item = o->m_stack;
    return item.name.c_str();
}

bool NativeItemStack::native_set_name(LuaItemStack *o, std::string name)
{
	ItemStack &item = o->m_stack;

    bool status = true;
    item.name = name;
    if (item.name.empty() || item.empty()) {
        item.clear();
        status = false;
    }

    return status;
}

int NativeItemStack::native_get_count(LuaItemStack *o)
{
	ItemStack &item = o->m_stack;
    return item.count;
}

bool NativeItemStack::native_set_count(LuaItemStack *o, int count)
{
	ItemStack &item = o->m_stack;

    bool status;
    if (count > 0 && count <= 65535) {
        item.count = count;
	    status = true;
    } else {
        item.clear();
        status = false;
    }

    return status;
}

int NativeItemStack::native_get_wear(LuaItemStack *o)
{
	ItemStack &item = o->m_stack;
    return item.wear;
}

bool NativeItemStack::native_set_wear(LuaItemStack *o, int wear)
{
	ItemStack &item = o->m_stack;

    bool status;
    if (wear <= 65535) {
        item.wear = wear;
	    status = true;
    } else {
        item.clear();
        status = false;
    }

    return status;
}

ItemStack *NativeItemStack::native_get_meta(LuaItemStack *o)
{
	ItemStack *item = &o->m_stack;
	return item;
}

const char* NativeItemStack::native_get_metadata(LuaItemStack *o)
{
	ItemStack &item = o->m_stack;
	const std::string &value = item.metadata.getString("");
	return value.c_str();
}

bool NativeItemStack::native_set_metadata(LuaItemStack *o, size_t len, const char *ptr)
{
	ItemStack &item = o->m_stack;

    item.metadata.setString("", std::string(ptr, len));

    return true;
}

const char* NativeItemStack::native_get_description(LuaItemStack *o, IGameDef *gamedef)
{
	ItemStack *item = &o->m_stack;
	std::string desc = item->getDescription(gamedef->idef());
    return desc.c_str();
}

const char *NativeItemStack::native_get_short_description(LuaItemStack *o, IGameDef *gamedef)
{
	ItemStack *item = &o->m_stack;
	std::string desc = item->getShortDescription(gamedef->idef());
    return desc.c_str();
}

bool NativeItemStack::native_clear(LuaItemStack *o)
{
	ItemStack &item = o->m_stack;
    item.clear();
    return true;
}

bool NativeItemStack::native_replace(LuaItemStack *o, ItemStack *itemstack)
{
	ItemStack &item = o->m_stack;
	item = *itemstack;

    return true;
}

const char* NativeItemStack::native_to_string(LuaItemStack *o)
{
	ItemStack *item = &o->m_stack;
    return item->getItemString().c_str();
}

std::tuple<const char *, int, int, const std::string &, std::vector<std::tuple<std::string, std::string>>> NativeItemStack::native_to_table(LuaItemStack *o)
{
	ItemStack *item = &o->m_stack;

    const StringMap &fields = item->metadata.getStrings();
	std::vector<std::tuple<std::string, std::string>> fielddata(fields.size());

    for (const auto &field : fields) {
	    std::string name = field.first;
	    if (name.empty())
		    continue;
	    std::string value = field.second;
        std::tuple<std::string, std::string> record = make_tuple(name, value);
	    fielddata.push_back(record);
    }

    std::tuple<const char *, u16, u16, const std::string &,
		    std::vector<std::tuple<std::string, std::string>>>
		    result = make_tuple(
        item->name.c_str(),
        item->count,
        item->wear,
        item->metadata.getString(""),
        fielddata
    );

    return result;
}

int NativeItemStack::native_get_stack_max(LuaItemStack *o, IGameDef *gamedef)
{
	ItemStack &item = o->m_stack;
    return item.getStackMax(gamedef->idef());
}


int NativeItemStack::native_get_free_space(LuaItemStack *o, IGameDef *gamedef)
{
	ItemStack &item = o->m_stack;
    return item.freeSpace(gamedef->idef());
}

bool NativeItemStack::native_is_known(LuaItemStack *o, IGameDef *gamedef)
{
	ItemStack *item = &o->m_stack;
    return item->isKnown(gamedef->idef());
}

const char * NativeItemStack::native_get_definition(LuaItemStack *o){
	ItemStack &item = o->m_stack;
	return item.name.c_str();
}

ToolCapabilities NativeItemStack::native_get_tool_capabilities(LuaItemStack *o, IGameDef *gamedef)
{
	ItemStack *item = &o->m_stack;
    return item->getToolCapabilities(gamedef->idef());
}

bool NativeItemStack::native_add_wear(LuaItemStack *o, int amount, IGameDef *gamedef)
{
	ItemStack &item = o->m_stack;
    return item.addWear(amount, gamedef->idef());
}

ItemStack NativeItemStack::native_add_item(LuaItemStack *o, ItemStack *new_item, IGameDef *gamedef)
{
	ItemStack &item = o->m_stack;
    return item.addItem(*new_item, gamedef->idef());
}

std::tuple<bool, ItemStack> NativeItemStack::native_item_fits(LuaItemStack *o, ItemStack *new_item, IGameDef *gamedef)
{
	ItemStack &item = o->m_stack;
    ItemStack rest_item;
    bool fits = item.itemFits(*new_item, &rest_item, gamedef->idef());

    return std::tuple<bool, ItemStack>(fits, rest_item);
}

ItemStack NativeItemStack::native_take_item(LuaItemStack *o, int count)
{
	ItemStack &item = o->m_stack;
    return item.takeItem(count);
}

ItemStack NativeItemStack::native_peek_item(LuaItemStack *o, int count)
{
	ItemStack &item = o->m_stack;
    return item.peekItem(count);
}

/*
	ItemDefinition
*/

int NativeModApiItemMod::native_register_item_raw(Server *server, ItemDefinition *def,
		ContentFeatures *f, std::string name)
{

    IWritableItemDefManager *idef = server->getWritableItemDefManager();
    NodeDefManager *ndef = server->getWritableNodeDefManager();

	if (def->node_placement_prediction == "__default") {
	    if (def->type == ITEM_NODE)
		    def->node_placement_prediction = name;
	    else
		    def->node_placement_prediction = "";
    }

    idef->registerItem(*def);

    if (def->type == ITEM_NODE) {

	    if (f->name == "ignore")
		    return 0;

	    content_t id = ndef->set(f->name, *f);

	    if (id > MAX_REGISTERED_CONTENT) {
		    if (id > MAX_REGISTERED_CONTENT) {
			    throw LuaError("Number of registerable nodes (" +
					    itos(MAX_REGISTERED_CONTENT + 1) +
					    ") exceeded (" + name + ")");
		    }
	    }
    }

    return 0; 
}

int NativeModApiItemMod::native_unregister_item_raw(Server *server, std::string name)
{
    IWritableItemDefManager *idef = server->getWritableItemDefManager();
	
    if (idef->get(name).type == ITEM_NODE) {
        NodeDefManager *ndef = server->getWritableNodeDefManager();
        ndef->removeNode(name);
    }

    idef->unregisterItem(name);

    return 0;
}

int NativeModApiItemMod::native_register_alias_raw(Server *server, std::string name,
        std::string convert_to)
{
    IWritableItemDefManager *idef = server->getWritableItemDefManager();

    idef->registerAlias(name, convert_to);

    return 0;
}

content_t NativeModApiItemMod::native_get_content_id(IGameDef *def, std::string name)
{
	const IItemDefManager *idef = def->getItemDefManager();
	const NodeDefManager *ndef = def->getNodeDefManager();

    std::string alias_name = idef->getAlias(name);

    content_t content_id;
    if (alias_name != name) {
        if (!ndef->getId(alias_name, content_id)) {
		    throw LuaError("Unknown node: " + alias_name +
                " (from alias " + name + ")");
        } else if (!ndef->getId(name, content_id)) {
		throw LuaError("Unknown node: " + name);
        }
    }
    else {
	    content_id = 0;
    }

    return content_id;
}

const char* NativeModApiItemMod::native_get_name_from_content_id(IGameDef *def, content_t *c)
{
	const NodeDefManager *ndef = def->getNodeDefManager();
    return ndef->get(*c).name.c_str();
}