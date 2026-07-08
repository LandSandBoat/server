-----------------------------------
-- Area: RuAun_Gardens
-----------------------------------
zones = zones or {}

zones[xi.zone.RUAUN_GARDENS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6390,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6394,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6395,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6403,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6408,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7005,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027,  -- Your party is unable to participate because certain members' levels are restricted.
        CHEST_WONT_OPEN               = 7071,  -- It won't open.
        FISHING_MESSAGE_OFFSET        = 7072,  -- You can't fish here.
        CONQUEST_BASE                 = 7173,  -- Tallying conquest results...
        IT_IS_ALREADY_FUNCTIONING     = 7333,  -- It is already functioning.
        CHEST_UNLOCKED                = 7367,  -- You unlock the chest!
        SKY_GOD_OFFSET                = 7384,  -- A strange insignia pointing north is carved into the wall.
        PLAYER_OBTAINS_ITEM           = 7586,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7587,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7588,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7589,  -- You already possess that temporary item.
        NO_COMBINATION                = 7594,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9750,  -- New training regime registered!
        HOMEPOINT_SET                 = 11671, -- Home point set!
        COMMON_SENSE_SURVIVAL         = 11691, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        BYAKKO        = GetFirstID('Byakko'),
        DESPOT        = GetFirstID('Despot'),
        GENBU         = GetFirstID('Genbu'),
        KIRIN         = GetFirstID('Kirin'),
        KIRINS_AVATAR = GetFirstID('Kirins_Avatar'),
        MIMIC         = GetFirstID('Mimic'),
        SEIRYU        = GetFirstID('Seiryu'),
        SUZAKU        = GetFirstID('Suzaku'),
    },

    npc =
    {
        OVERSEER_BASE            = GetFirstID('Conquest_Banner'),
        PINCERSTONE_OFFSET       = GetFirstID('Pincerstone'),
        PORTAL_OFFSET            = GetFirstID('_3mc'),
        STRANGE_HAPPENINGS_CHEST = GetFirstID('Treasure_Chest'),
        TREASURE_COFFER          = GetFirstID('Treasure_Coffer'),
    },
}

return zones[xi.zone.RUAUN_GARDENS]
