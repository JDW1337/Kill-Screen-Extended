#include <sourcemod>
#include <vip_core>
#include <kse>
#include <devcolors>

#pragma semicolon 1
#pragma newdecls required
#pragma tabsize 0

public Plugin myinfo = 
{
	name = "[VIP]Kill Screen Extended",
	author = "JDW",
	version = "1.0",
	url = "devengine.tech"
};

static const char feature[] = "KSE";

public void OnPluginStart()
{
    LoadTranslations("kse.phrases");

    if(VIP_IsVIPLoaded())
    {
        VIP_OnVIPLoaded();
    }
}

public void OnPluginEnd()
{
    VIP_UnregisterMe();
}

public void OnConfigsExecuted()
{
    if(!PrivateModCheck())
    {
        SetFailState("kse_private_mode variable must be true (1)");
    }
}

public void VIP_OnVIPLoaded()
{
    VIP_RegisterFeature(feature, BOOL, HIDE);
}

public void VIP_OnVIPClientLoaded(int client)
{
    CreateTimer(3.0, Timer_CheckFunctionAccess, GetClientUserId(client));
}

public Action Timer_CheckFunctionAccess(Handle timer, int userId)
{
    static int client;
    client = GetClientOfUserId(userId);

    if(client && VIP_GetClientFeatureStatus(client, feature) != NO_ACCESS)
    {
        KSE_GrantAccess(client);
        DCPrintToChat(client, "%T%T", "PREFIX", client, "WELCOME", client);
    } 

    return Plugin_Stop;
}