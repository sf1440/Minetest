#pragma once
#include "database/database.h"

class NativeModApiAuth
{
public:

    static bool native_auth_read(AuthEntry& authEntry, AuthDatabase* auth_db, const char* name);
    static bool native_auth_save(AuthEntry& authEntry, AuthDatabase* auth_db, bool* fields);
    static bool native_auth_create(AuthEntry& authEntry, AuthDatabase* auth_db, bool* fields);
    static bool native_auth_delete(AuthDatabase* auth_db, std::string name);
    static std::vector<std::string> native_auth_list_names(AuthDatabase* auth_db);
    static int native_auth_reload(AuthDatabase* auth_db);

};