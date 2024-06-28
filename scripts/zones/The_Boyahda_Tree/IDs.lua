-----------------------------------
-- Area: The_Boyahda_Tree
-----------------------------------
zones = zones or {}

zones[xi.zone.THE_BOYAHDA_TREE] =
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
        FISHING_MESSAGE_OFFSET        = 7064,  -- You can't fish here.
        CHEST_UNLOCKED                = 7172,  -- You unlock the chest!
        CAN_SEE_SKY                   = 7185,  -- You can see the sky from here.
        SOMETHING_NOT_RIGHT           = 7186,  -- Something is not right!
        CANNOT_SEE_MOON               = 7187,  -- You cannot see the moon right now.
        CONQUEST_BASE                 = 7188,  -- Tallying conquest results...
        WARDEN_SPEECH                 = 7347,  -- Pi...!
        WARDEN_TRANSLATION            = 7348,  -- The warden appears to want something from you...
        SENSE_OMINOUS_PRESENCE        = 7408,  -- You sense an ominous presence...
        REGIME_REGISTERED             = 10351, -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 11403, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 11404, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 11405, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 11406, -- You already possess that temporary item.
        NO_COMBINATION                = 11411, -- You were unable to enter a combination.
        HOMEPOINT_SET                 = 11449, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 11507, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        ELLYLLON          = GetFirstID('Ellyllon'),
        AQUARIUS          = GetFirstID('Aquarius'),
        UNUT              = GetFirstID('Unut'),
        LESHONKI          = GetFirstID('Leshonki'),
        VOLUPTUOUS_VIVIAN = GetFirstID('Voluptuous_Vivian'),
        MIMIC             = GetFirstID('Mimic'),
        AGAS              = GetFirstID('Agas'),
        BEET_LEAFHOPPER   = GetFirstID('Beet_Leafhopper'),
    },
    npc =
    {
        TREASURE_COFFER = GetFirstID('Treasure_Coffer'),
    },
}

return zones[xi.zone.THE_BOYAHDA_TREE]
