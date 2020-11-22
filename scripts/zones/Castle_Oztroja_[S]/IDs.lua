-----------------------------------
-- Area: Castle_Oztroja_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.CASTLE_OZTROJA_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET  = 7049, -- You can't fish here.
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

return zones[tpz.zone.CASTLE_OZTROJA_S]
