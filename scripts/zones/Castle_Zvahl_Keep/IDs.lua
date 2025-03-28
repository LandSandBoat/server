-----------------------------------
-- Area: Castle_Zvahl_Keep
-----------------------------------
zones = zones or {}

zones[xi.zone.CASTLE_ZVAHL_KEEP] =
{
    text =
    {
        CONQUEST_BASE                 = 0,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6544, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6550, -- Obtained: <item>.
        GIL_OBTAINED                  = 6551, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6553, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6564, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6579, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7161, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7162, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7163, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7183, -- Your party is unable to participate because certain members' levels are restricted.
        CHEST_UNLOCKED                = 7242, -- You unlock the chest!
        ITEMS_ITEMS_LA_LA             = 7251, -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7257, -- The Goblin slipped away when you were not looking...
        HOMEPOINT_SET                 = 7300, -- Home point set!
    },
    mob =
    {
        BARON_VAPULA   = GetFirstID('Baron_Vapula'),
        BARONET_ROMWE  = GetFirstID('Baronet_Romwe'),
        COUNT_BIFRONS  = GetFirstID('Count_Bifrons'),
        VISCOUNT_MORAX = GetFirstID('Viscount_Morax'),
    },
    npc =
    {
        TREASURE_CHEST = GetFirstID('Treasure_Chest'),
        CRAGGY_PILLAR  = GetTableOfIDs('Craggy_Pillar'),
        TELE_CENTER    = GetFirstID('_4iy'),
        TELE_NW        = GetFirstID('_4iu'),
        TELE_SW        = GetFirstID('_4iv'),
        TELE_NE        = GetFirstID('_4iw'),
        TELE_SE        = GetFirstID('_4ix'),
        TELE_N         = GetFirstID('_4is'),
        TELE_S         = GetFirstID('_4ir'),
        TELE_HIDDEN    = GetFirstID('_4it'),
    },
}

return zones[xi.zone.CASTLE_ZVAHL_KEEP]
