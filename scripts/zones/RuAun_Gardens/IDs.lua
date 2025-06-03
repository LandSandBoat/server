-----------------------------------
-- Area: RuAun_Gardens
-----------------------------------
zones = zones or {}

zones[xi.zone.RUAUN_GARDENS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6389,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6391,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6392,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6400,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6405,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7002,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7068,  -- You can't fish here.
        CONQUEST_BASE                 = 7168,  -- Tallying conquest results...
        IT_IS_ALREADY_FUNCTIONING     = 7328,  -- It is already functioning.
        CHEST_UNLOCKED                = 7362,  -- You unlock the chest!
        SKY_GOD_OFFSET                = 7379,  -- A strange insignia pointing north is carved into the wall.
        PLAYER_OBTAINS_ITEM           = 7581,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7582,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7583,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7584,  -- You already possess that temporary item.
        NO_COMBINATION                = 7589,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9745,  -- New training regime registered!
        HOMEPOINT_SET                 = 11666, -- Home point set!
        COMMON_SENSE_SURVIVAL         = 11686, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        DESPOT = GetFirstID('Despot'),
        MIMIC  = GetFirstID('Mimic'),
        GENBU  = GetFirstID('Genbu'),
        SEIRYU = GetFirstID('Seiryu'),
        BYAKKO = GetFirstID('Byakko'),
        SUZAKU = GetFirstID('Suzaku'),
    },

    npc =
    {
        TREASURE_COFFER    = GetFirstID('Treasure_Coffer'),
        PINCERSTONE_OFFSET = GetFirstID('Pincerstone'),
        PORTAL_OFFSET      = GetFirstID('_3mc'),
        OVERSEER_BASE      = GetFirstID('Conquest_Banner'),
    },
}

return zones[xi.zone.RUAUN_GARDENS]
