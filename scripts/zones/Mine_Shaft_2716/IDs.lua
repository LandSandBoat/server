-----------------------------------
-- Area: Mine_Shaft_2716
-----------------------------------
zones = zones or {}

zones[xi.zone.MINE_SHAFT_2716] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        PARTY_MEMBERS_HAVE_FALLEN     = 7411, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7418, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7435, -- Tallying conquest results...
    },
    mob =
    {
        [1] =
        {
            MOBLIN_IDS = { 16830465, 16830466, 16830467, 16830468 }
        },
        [2] =
        {
            MOBLIN_IDS = { 16830470, 16830471, 16830472, 16830473 }
        },
        [3] =
        {
            MOBLIN_IDS = { 16830475, 16830476, 16830477, 16830478 }
        },
    },
    npc =
    {
    },
}

return zones[xi.zone.MINE_SHAFT_2716]
