-----------------------------------
-- Area: Castle_Zvahl_Keep
-----------------------------------
zones = zones or {}

zones[xi.zone.CASTLE_ZVAHL_KEEP] =
{
    text =
    {
        CONQUEST_BASE                 = 0,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6543, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6549, -- Obtained: <item>.
        GIL_OBTAINED                  = 6550, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6552, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6563, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6578, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7160, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7161, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7162, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7182, -- Your party is unable to participate because certain members' levels are restricted.
        CHEST_UNLOCKED                = 7234, -- You unlock the chest!
        ITEMS_ITEMS_LA_LA             = 7243, -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7249, -- The Goblin slipped away when you were not looking...
        HOMEPOINT_SET                 = 7292, -- Home point set!
    },
    mob =
    {
        BARON_VAPULA_PH   =
        {
            [17440962] = 17440963, -- -254.000 -52.125 86.000
            [17440960] = 17440963, -- -227.007 -52.125 83.768
        },
        BARONET_ROMWE_PH  =
        {
            [17440985] = 17440986, -- -335.444 -52.125 15.148
            [17440984] = 17440986, -- -317.070 -52.125 14.052
        },
        COUNT_BIFRONS_PH  =
        {
            [17440968] = 17440969, -- -204.000 -52.125 -95.000
        },
        VISCOUNT_MORAX_PH =
        {
            [17440973] = 17440975, -- -365.684 -52.125 -136.540
        },
    },
    npc =
    {
        TREASURE_CHEST = 17441088,
    },
}

return zones[xi.zone.CASTLE_ZVAHL_KEEP]
