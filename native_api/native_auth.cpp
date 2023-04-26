#include "native_auth.h"


//SELECT
bool NativeModApiAuth::native_auth_read(AuthEntry& authEntry, AuthDatabase* auth_db, const char* name)
{
    if (auth_db && auth_db->getAuth(std::string(name), authEntry))
		return true;
    return false;
}

//UPDATE
bool NativeModApiAuth::native_auth_save(AuthEntry& authEntry, AuthDatabase* auth_db, bool* fields)
{
    //TODO: for some reason getting privileges (fields[3]) is failing for native, even though it works for native_read()
    if (fields[0] && fields[1] && fields[2] && fields[4]) {
        return auth_db->saveAuth(authEntry);
    }   
    return false;
}

//INSERT
bool NativeModApiAuth::native_auth_create(AuthEntry& authEntry, AuthDatabase* auth_db, bool* fields)
{
    //TODO: for some reason getting privileges (fields[2]) is failing for native, even though it works for native_read()
    if (auth_db && fields[0] && fields[1] && fields[3]) {
        return auth_db->createAuth(authEntry);
    }   
    return false;
}

//DELETE
bool NativeModApiAuth::native_auth_delete(AuthDatabase* auth_db, std::string name)
{
	return auth_db->deleteAuth(name);
}

std::vector<std::string> NativeModApiAuth::native_auth_list_names(AuthDatabase* auth_db)
{
	std::vector<std::string> names;
	auth_db->listNames(names);
    return names;
}

int NativeModApiAuth::native_auth_reload(AuthDatabase* auth_db)
{
	if (auth_db)
		auth_db->reload();
    return 0;
}