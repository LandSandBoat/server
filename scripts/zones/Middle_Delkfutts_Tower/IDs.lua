-----------------------------------
-- Area: Middle_Delkfutts_Tower
-----------------------------------
zones = zones or {}

zones[xi.zone.MIDDLE_DELKFUTTS_TOWER] =
{
    text =
    {
        CONQUEST_BASE                 = 4,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6547, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6553, -- Obtained: <item>.
        GIL_OBTAINED                  = 6554, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6556, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6567, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6568, -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6582, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7164, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7165, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7166, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7186, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7227, -- You can't fish here.
        CHEST_UNLOCKED                = 7335, -- You unlock the chest!
        PLAYER_OBTAINS_ITEM           = 7383, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7384, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7385, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7386, -- You already possess that temporary item.
        NO_COMBINATION                = 7391, -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9469, -- New training regime registered!
    },
    mob =
    {
        EURYTOS                  = GetFirstID('Eurytos'),
        POLYBOTES                = GetFirstID('Polybotes'),
        RHOITOS                  = GetFirstID('Rhoitos'),
        OPHION                   = GetFirstID('Ophion'),
        OGYGOS                   = GetFirstID('Ogygos'),
        RHOIKOS                  = GetFirstID('Rhoikos'),
        BLADE_OF_EVIL_MOB_OFFSET = GetFirstID('Gerwitzs_Scythe'),
    },
    npc =
    {
        TREASURE_CHEST = GetFirstID('Treasure_Chest'),
    },
}

return zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
