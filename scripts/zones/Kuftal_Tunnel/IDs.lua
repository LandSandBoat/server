-----------------------------------
-- Area: Kuftal_Tunnel
-----------------------------------
zones = zones or {}

zones[xi.zone.KUFTAL_TUNNEL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7064,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7223,  -- You can't fish here.
        CHEST_UNLOCKED                = 7331,  -- You unlock the chest!
        DO_NOT_SEE_ANYTHING           = 7346,  -- You do not see anything out of the ordinary.
        FELL                          = 7349,  -- The piece of wood fell off the cliff!
        EVIL                          = 7350,  -- You sense an evil presence...
        FISHBONES                     = 7364,  -- Fish bones lie scattered about the area...
        SENSE_OMINOUS_PRESENCE        = 7366,  -- You sense an ominous presence...
        REGIME_REGISTERED             = 10350, -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 11402, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 11403, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 11404, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 11405, -- You already possess that temporary item.
        NO_COMBINATION                = 11410, -- You were unable to enter a combination.
        COMMON_SENSE_SURVIVAL         = 11434, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 11498, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        AMEMET               = GetFirstID('Amemet'),
        ARACHNE              = GetFirstID('Arachne'),
        BLOODTHIRSTER_MADKIX = GetFirstID('Bloodthirster_Madkix'),
        PELICAN              = GetFirstID('Pelican'),
        SABOTENDER_MARIACHI  = GetFirstID('Sabotender_Mariachi'),
        YOWIE                = GetFirstID('Yowie'),
        TALEKEEPER_OFFSET    = GetFirstID('Gordovs_Ghost'),
        MIMIC                = GetFirstID('Mimic'),
        CANCER               = GetFirstID('Cancer'),
        PHANTOM_WORM         = GetFirstID('Phantom_Worm'),
        GUIVRE               = GetFirstID('Guivre'),
        KETTENKAEFER         = GetFirstID('Kettenkaefer'),
    },
    npc =
    {
        PHANTOM_WORM_QM = GetFirstID('qm1'),
        DOOR_ROCK       = GetFirstID('_4u0'),
        TREASURE_COFFER = GetFirstID('Treasure_Coffer'),
    },
}

return zones[xi.zone.KUFTAL_TUNNEL]
