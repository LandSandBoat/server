-----------------------------------
-- Area: Yughott Grotto (142)
-----------------------------------
zones = zones or {}

zones[xi.zone.YUGHOTT_GROTTO] =
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
        GEOMAGNETRON_ATTUNED          = 7172, -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7183, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7227, -- You can't fish here.
        CHEST_UNLOCKED                = 7353, -- You unlock the chest!
        MINING_IS_POSSIBLE_HERE       = 7361, -- Mining is possible here if you have <item>.
        HOMEPOINT_SET                 = 7461, -- Home point set!
    },
    mob =
    {
        ASHMAKER_GOTBLUT = GetFirstID('Ashmaker_Gotblut'),
    },
    npc =
    {
        TREASURE_CHEST = GetFirstID('Treasure_Chest'),
        MINING         = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.YUGHOTT_GROTTO]
