-----------------------------------
-- Area: Toraimarai Canal (169)
-----------------------------------
zones = zones or {}

zones[xi.zone.TORAIMARAI_CANAL] =
{
    text =
    {
        SEALED_SHUT                   = 3,     -- It's sealed shut with incredibly strong magic.
        ITEM_CANNOT_BE_OBTAINED       = 6433,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6441,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6442,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6444,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6470,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7052,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7053,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7054,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7063,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7074,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7119,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7278,  -- You can't fish here.
        CHEST_UNLOCKED                = 7387,  -- You unlock the chest!
        PLAYER_OBTAINS_ITEM           = 7556,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7557,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7558,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7559,  -- You already possess that temporary item.
        NO_COMBINATION                = 7564,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9642,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 10690, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        HOMEPOINT_SET                 = 10718, -- Home point set!
    },
    mob =
    {
        CANAL_MOOCHER     = GetFirstID('Canal_Moocher'),
        KONJAC            = GetFirstID('Konjac'),
        MAGIC_SLUDGE      = GetFirstID('Magic_Sludge'),
        HINGE_OILS_OFFSET = GetFirstID('Hinge_Oil'),
        MIMIC             = GetFirstID('Mimic'),
    },
    npc =
    {
        TOME_OF_MAGIC_OFFSET = GetFirstID('Tome_of_Magic'),
        TREASURE_COFFER      = GetFirstID('Treasure_Coffer'),
    },
}

return zones[xi.zone.TORAIMARAI_CANAL]
