#pragma once
#include <string>
#include <tuple>
#include <map>
#include <list>
#include "client/client.h"
#include "client/sound.h"
#include <script\cpp_api\s_base.h>
#include "chatmessage.h"
#include <nodemetadata.h>
#include "client/clientevent.h"
#include "nodedef.h"
#include <gettext.h>
#include "map.h"
#include "gui/mainmenumanager.h"

struct NativeCSMFlagDesc
{
	const char *name;
	u64 flag;
	NativeCSMFlagDesc(const char* name, u64 flag) : name(name), flag(flag) {}
};

const static NativeCSMFlagDesc native_flagdesc_csm_restriction[] = {
	{"load_client_mods",  CSM_RF_LOAD_CLIENT_MODS},
	{"chat_messages",     CSM_RF_CHAT_MESSAGES},
	{"read_itemdefs",     CSM_RF_READ_ITEMDEFS},
	{"read_nodedefs",     CSM_RF_READ_NODEDEFS},
	{"lookup_nodes",      CSM_RF_LOOKUP_NODES},
	{"read_playerinfo",   CSM_RF_READ_PLAYERINFO},
	{NULL,      0}
};

class NativeModApiClient
{
public:
	static std::string native_get_current_modname(std::string current_mod);
	static std::string native_get_modpath(std::string modname);
	static const char* native_get_last_run_mod(std::string current_mod, ScriptApiBase *scriptApiBase);
	static bool native_set_last_run_mod(const char *mod, ScriptApiBase *scriptApiBase);
	static int native_print(std::string text);
	static bool NativeModApiClient::native_display_chat_message(std::string message, Client *client);
	static int native_send_chat_message(std::string message, Client *client);
	static int native_get_chat_size(Client *client);
	static int native_clear_out_chat_queue(Client *client);
	static const std::list<std::string>& native_get_player_names(Client *client);
	static bool native_show_formspec(std::string *formname, std::string *formspec,
		Client *client);
	static int native_send_respawn(Client *client);
	static bool native_disconnect(Client *client, MainGameCallback *g_gamecallback);
	static std::string native_gettext(std::string text);
	static std::tuple<MapNode, const NodeDefManager*> native_get_node_or_nil(v3s16 pos, Client *client);
	static std::tuple<std::string, std::string> native_get_language();
	static NodeMetadata *native_get_meta(v3s16 p, Environment *env);
	static s32 native_sound_play(Client *client, SimpleSoundSpec spec, float gain, 
		float pitch, bool looped, v3f *pos);
	static int native_sound_stop(s32 handle, Client *client);
	static int native_sound_fade(s32 handle, float step,
		float gain, Client *client);
	static std::tuple<std::string, std::string, int, int> native_get_server_info(Client *client);
	static const ItemDefinition *native_get_item_def(IGameDef *gdef, std::string name);
	static const ContentFeatures *native_get_node_def(IGameDef *gdef, std::string name);
	static const std::unordered_set<std::string>& native_get_privilege_list(Client *client);
	static std::string native_get_builtin_path();
	static std::map<const char *, bool> native_get_csm_restrictions(Client *client, const NativeCSMFlagDesc *flagdesc);
};
