-----------------------------------
-- Area: The_Boyahda_Tree
-----------------------------------
zones = zones or {}

zones[xi.zone.THE_BOYAHDA_TREE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6409,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6424,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7006,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028,  -- Your party is unable to participate because certain members' levels are restricted.
        CHEST_WONT_OPEN               = 7072,  -- It won't open.
        FISHING_MESSAGE_OFFSET        = 7073,  -- You can't fish here.
        CHEST_UNLOCKED                = 7182,  -- You unlock the chest!
        CAN_SEE_SKY                   = 7195,  -- You can see the sky from here.
        SOMETHING_NOT_RIGHT           = 7196,  -- Something is not right!
        CANNOT_SEE_MOON               = 7197,  -- You cannot see the moon right now.
        CONQUEST_BASE                 = 7198,  -- Tallying conquest results...
        REGION_POINTS_SANDORIA        = 7263,  -- San d'Oria's region points have increased!
        WARDEN_SPEECH                 = 7357,  -- Pi...!
        WARDEN_TRANSLATION            = 7358,  -- The warden appears to want something from you...
        SENSE_OMINOUS_PRESENCE        = 7418,  -- You sense an ominous presence...
        REGIME_REGISTERED             = 10361, -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 11413, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 11414, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 11415, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 11416, -- You already possess that temporary item.
        NO_COMBINATION                = 11421, -- You were unable to enter a combination.
        HOMEPOINT_SET                 = 11459, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 11517, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
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
