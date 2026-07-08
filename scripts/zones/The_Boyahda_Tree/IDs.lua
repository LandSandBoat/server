-----------------------------------
-- Area: The_Boyahda_Tree
-----------------------------------
zones = zones or {}

zones[xi.zone.THE_BOYAHDA_TREE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6395,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6408,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6423,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027,  -- Your party is unable to participate because certain members' levels are restricted.
        CHEST_WONT_OPEN               = 7071,  -- It won't open.
        FISHING_MESSAGE_OFFSET        = 7072,  -- You can't fish here.
        CHEST_UNLOCKED                = 7181,  -- You unlock the chest!
        CAN_SEE_SKY                   = 7194,  -- You can see the sky from here.
        SOMETHING_NOT_RIGHT           = 7195,  -- Something is not right!
        CANNOT_SEE_MOON               = 7196,  -- You cannot see the moon right now.
        CONQUEST_BASE                 = 7197,  -- Tallying conquest results...
        REGION_POINTS_SANDORIA        = 7262,  -- San d'Oria's region points have increased!
        WARDEN_SPEECH                 = 7356,  -- Pi...!
        WARDEN_TRANSLATION            = 7357,  -- The warden appears to want something from you...
        SENSE_OMINOUS_PRESENCE        = 7417,  -- You sense an ominous presence...
        REGIME_REGISTERED             = 10360, -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 11412, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 11413, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 11414, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 11415, -- You already possess that temporary item.
        NO_COMBINATION                = 11420, -- You were unable to enter a combination.
        HOMEPOINT_SET                 = 11458, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 11516, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        AGAS              = GetFirstID('Agas'),
        AQUARIUS          = GetFirstID('Aquarius'),
        BEET_LEAFHOPPER   = GetFirstID('Beet_Leafhopper'),
        ELLYLLON          = GetFirstID('Ellyllon'),
        FAFNIR            = GetFirstID('Fafnir'),
        LESHONKI          = GetFirstID('Leshonki'),
        MIMIC             = GetFirstID('Mimic'),
        UNUT              = GetFirstID('Unut'),
        VOLUPTUOUS_VIVIAN = GetFirstID('Voluptuous_Vivian'),
    },
    npc =
    {
        STRANGE_HAPPENINGS_CHEST = GetFirstID('Treasure_Chest'),
        TREASURE_COFFER          = GetFirstID('Treasure_Coffer'),
    },
}

return zones[xi.zone.THE_BOYAHDA_TREE]
