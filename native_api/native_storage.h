#ifndef NATIVE_STORAGE_H
#define NATIVE_STORAGE_H

#include "lua_api/l_storage.h"
#include "l_internal.h"
#include "content/mods.h"
#include "server.h"
#include <memory>
#include <string>

class ModApiStorage {
public:
    static int l_get_mod_storage(lua_State* L);
    static std::shared_ptr<ModMetadata> get_mod_storage_cpp(const std::string& mod_name, IGameDef* gamedef);
    static void Initialize(lua_State* L, int top);
};

#endif // NATIVE_STORAGE_H
