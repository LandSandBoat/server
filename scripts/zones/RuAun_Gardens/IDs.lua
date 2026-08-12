-----------------------------------
-- Area: RuAun_Gardens
-----------------------------------
zones = zones or {}

zones[xi.zone.RUAUN_GARDENS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6391,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6404,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6409,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7006,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028,  -- Your party is unable to participate because certain members' levels are restricted.
        CHEST_WONT_OPEN               = 7072,  -- It won't open.
        FISHING_MESSAGE_OFFSET        = 7073,  -- You can't fish here.
        CONQUEST_BASE                 = 7174,  -- Tallying conquest results...
        IT_IS_ALREADY_FUNCTIONING     = 7334,  -- It is already functioning.
        CHEST_UNLOCKED                = 7368,  -- You unlock the chest!
        SKY_GOD_OFFSET                = 7385,  -- A strange insignia pointing north is carved into the wall.
        ITEMS_ITEMS_LA_LA             = 7399,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7405,  -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM           = 7587,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7588,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7589,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7590,  -- You already possess that temporary item.
        NO_COMBINATION                = 7595,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9751,  -- New training regime registered!
        HOMEPOINT_SET                 = 11672, -- Home point set!
        COMMON_SENSE_SURVIVAL         = 11692, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
