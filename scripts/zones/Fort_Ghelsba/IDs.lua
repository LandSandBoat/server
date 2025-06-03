-----------------------------------
-- Area: Fort_Ghelsba
-----------------------------------
zones = zones or {}

zones[xi.zone.FORT_GHELSBA] =
{
    text =
    {
        CONQUEST_BASE                 = 0,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6544, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6550, -- Obtained: <item>.
        GIL_OBTAINED                  = 6551, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6553, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6579, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7161, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7162, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7163, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7183, -- Your party is unable to participate because certain members' levels are restricted.
        CHEST_UNLOCKED                = 7374, -- You unlock the chest!
        COMMON_SENSE_SURVIVAL         = 7382, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        HUNDREDSCAR_HAJWAJ = GetFirstID('Hundredscar_Hajwaj'),
        ORCISH_PANZER      = GetFirstID('Orcish_Panzer'),
    },
    npc =
    {
        TREASURE_CHEST = GetFirstID('Treasure_Chest'),
    },
}

return zones[xi.zone.FORT_GHELSBA]
