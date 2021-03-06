#if defined _kse_included
 #endinput
#endif
#define _kse_included

/**
 *   Выдает доступ к меню при kse_private_mode 1
 *	 Gives access to the menu when kse_private_mode 1
 *   -
 *   @param индекс игрока. 
 *			index player.
 *   -
 *   @return true or false
*/
native bool KSE_GrantAccess(const int client);

stock bool PrivateModCheck()
{
    return GetConVarBool(FindConVar("kse_private_mode"));
}

public SharedPlugin __pl_kse = 
{
	name = "kse",
	file = "kill_screen_ex.smx",
    #if defined REQUIRE_PLUGIN
        required = 1
    #else
        required = 0
    #endif
};

#if !defined REQUIRE_PLUGIN
public void __pl_kse_SetNTVOptional()
{
    MarkNativeAsOptional("KSE_GrantAccess");
}
#endif