-----------------------------------
-- Area: Castle_Oztroja_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.CASTLE_OZTROJA_S] =
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
        FISHING_MESSAGE_OFFSET        = 7060, -- You can't fish here.
        PARTY_MEMBERS_HAVE_FALLEN     = 8032, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 8039, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
    },
    mob =
    {
        AA_XALMO_THE_SAVAGE_PH =
        {
            [17182827] = 17182843,
            [17182838] = 17182843,
        },
        ZHUU_BUXU_THE_SILENT_PH =
        {
            [17182813] = 17182813,
        },
        DUU_MASA_THE_ONECUT    = 17182790,
        DEE_ZELKO_THE_ESOTERIC = 17183031,
        MARQUIS_FORNEUS        = 17183032,
        LOO_KUTTO_THE_PENSIVE  = 17183033,
        FLESHGNASHER           = 17183034,
        VEE_LADU_THE_TITTERER  = 17183035,
        MAA_ILLMU_THE_BESTOWER = 17183036,
        ASTERION               = 17183037,
        SUU_XICU_THE_CANTABILE = 17183038,
    },
    npc =
    {
    },
}

return zones[xi.zone.CASTLE_OZTROJA_S]
