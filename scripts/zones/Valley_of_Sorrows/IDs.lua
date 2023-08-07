-----------------------------------
-- Area: Valley_of_Sorrows
-----------------------------------
zones = zones or {}

zones[xi.zone.VALLEY_OF_SORROWS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6399,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        AURA_THREATENS                = 6408,  -- An aura of irrepressible might threatens to overwhelm you...
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060,  -- Tallying conquest results...
        SOMETHING_BURRIED             = 7319,  -- It looks like something was buried here.
        PLAYER_OBTAINS_ITEM           = 7509,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7510,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7511,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7512,  -- You already possess that temporary item.
        NO_COMBINATION                = 7517,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7579,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9695,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 10814, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        ADAMANTOISE   = 17301537,
        ASPIDOCHELONE = 17301538,
    },
    npc =
    {
        ADAMANTOISE_QM = 17301567,
    },
}

return zones[xi.zone.VALLEY_OF_SORROWS]
