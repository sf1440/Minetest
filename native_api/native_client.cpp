#include "native_client.h"

std::string NativeModApiClient::native_get_current_modname(std::string current_mod)
{
	//TO DO: can't write native version of this right now (will have to modify internal classes)
	//see ModNameStorer in script/cpp_api/s_base.cpp
	return current_mod;
}

std::string NativeModApiClient::native_get_modpath(std::string modname)
{
	return modname += ':';
}

const char* NativeModApiClient::native_get_last_run_mod(
		std::string current_mod, ScriptApiBase *scriptApiBase)
{
	return scriptApiBase->getOrigin().c_str();
}

bool NativeModApiClient::native_set_last_run_mod(
		const char *mod, ScriptApiBase *scriptApiBase)
{
	scriptApiBase->setOriginDirect(mod);
	return true;
}

int NativeModApiClient::native_print(std::string text)
{
	rawstream << text << std::endl;
	return 0;
}

bool NativeModApiClient::native_display_chat_message(std::string message, Client *client)
{
	client->pushToChatQueue(new ChatMessage(utf8_to_wide(message)));
	return true;
}

int NativeModApiClient::native_send_chat_message(std::string message, Client *client)
{
	client->sendChatMessage(utf8_to_wide(message));
	return 0;
}

int NativeModApiClient::native_get_chat_size(Client *client)
{
	return client->getChatSize();
}

int NativeModApiClient::native_clear_out_chat_queue(Client *client)
{
	client->clearOutChatQueue();
	return 0;
}

const std::list<std::string>& NativeModApiClient::native_get_player_names(Client *client)
{
	return client->getConnectedPlayerNames();
}

bool NativeModApiClient::native_show_formspec(
		std::string *formname, std::string *formspec, Client *client)
{
	ClientEvent *event = new ClientEvent();
	event->type = CE_SHOW_LOCAL_FORMSPEC;
	event->show_formspec.formname = formname;
	event->show_formspec.formspec = formspec;
	client->pushToEventQueue(event);
	return true;
}

int NativeModApiClient::native_send_respawn(Client *client)
{
	client->sendRespawn();
	return 0;
}

bool NativeModApiClient::native_disconnect(Client *client, MainGameCallback *g_gamecallback)
{
	if (client->isShutdown()) return false;
	g_gamecallback->disconnect();
	return true;
}

std::string NativeModApiClient::native_gettext(std::string text)
{
	return strgettext(text);
}

std::tuple<MapNode, const NodeDefManager*> NativeModApiClient::native_get_node_or_nil(
		v3s16 pos, Client *client)
{
	std::tuple<MapNode, const NodeDefManager*> result;

	bool pos_ok;
	std::get<0>(result) = client->CSMGetNode(pos, &pos_ok);
	if (pos_ok) {
		std::get<1>(result) = client->ndef();
	} else {
		std::get<1>(result) = nullptr;
	}
	return result;
}

std::tuple<std::string, std::string> NativeModApiClient::native_get_language()
{
	#ifdef _WIN32
		char *locale = setlocale(LC_ALL, NULL);
	#else
		char *locale = setlocale(LC_MESSAGES, NULL);
	#endif
		std::string lang = gettext("LANG_CODE");
		if (lang == "LANG_CODE")
			lang = "";

	std::tuple<std::string, std::string> result;
	std::get<0>(result) = locale;
	std::get<1>(result) = lang;
	return result;
}


NodeMetadata* NativeModApiClient::native_get_meta(v3s16 p, Environment *env)
{
	return env->getMap().getNodeMetadata(p);
}

s32 NativeModApiClient::native_sound_play(Client *client, SimpleSoundSpec spec, float gain,
				float pitch, bool looped, v3f *pos)
{
	ISoundManager *sound = client->getSoundManager();

	s32 handle;
	if (pos != nullptr) {
		handle = sound->playSoundAt(spec.name, looped, gain * spec.gain, *pos, pitch);
		return handle;
	}

	return sound->playSound(spec.name, looped, gain * spec.gain, spec.fade, pitch);
}

int NativeModApiClient::native_sound_stop(s32 handle, Client *client)
{
	client->getSoundManager()->stopSound(handle);
	return 0;
}

int NativeModApiClient::native_sound_fade(s32 handle, float step, float gain, Client *client)
{
	client->getSoundManager()->fadeSound(handle, step, gain);
	return 0;
}

std::tuple<std::string, std::string, int, int>
NativeModApiClient::native_get_server_info(Client *client)
{
	std::string addressName = client->getAddressName();
	Address serverAddress = client->getServerAddress();
	std::string ip = serverAddress.serializeString();
	int port = serverAddress.getPort();
	int protocol_version = client->getProtoVersion();

	return std::tuple<std::string, std::string, int, int>(
			addressName, ip, port, protocol_version);
}

const ItemDefinition *NativeModApiClient::native_get_item_def(IGameDef *gdef, std::string name)
{
	assert(gdef);

	IItemDefManager *idef = gdef->idef();
	assert(idef);

	if (!idef->isKnown(name))
		return nullptr;
	const ItemDefinition &def = idef->get(name);

	return &def;
}

const ContentFeatures *NativeModApiClient::native_get_node_def(IGameDef *gdef, std::string name)
{
	assert(gdef);

	const NodeDefManager *ndef = gdef->ndef();
	assert(ndef);

	const ContentFeatures &cf = ndef->get(ndef->getId(name));
	if (cf.name != name)
		return nullptr;

	return &cf;
}

const std::unordered_set<std::string>& NativeModApiClient::native_get_privilege_list(Client *client)
{
	return client->getPrivilegeList();
}

std::string NativeModApiClient::native_get_builtin_path()
{
	return std::string(BUILTIN_MOD_NAME ":");
}

std::map<const char *, bool>  NativeModApiClient::native_get_csm_restrictions(Client *client, const NativeCSMFlagDesc *flagdesc)
{
	u64 flags = client->getCSMRestrictionFlags();

	std::map<const char *, bool> result;
	for (int i = 0; flagdesc[i].name; i++) {
		result.insert(std::pair<const char *, bool>(
				flagdesc[i].name, !!(flags & flagdesc[i].flag)));
	}
	return result;
}