-----------------------------------
-- Area: Bhaflau_Thickets
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.BHAFLAU_THICKETS] =
{
    text =
    {
        NOTHING_HAPPENS             = 119, -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED     = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6388, -- Obtained: <item>.
        GIL_OBTAINED                = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6391, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET       = 6417, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS         = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET      = 7049, -- You can't fish here.
        DIG_THROW_AWAY              = 7062, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                = 7064, -- You dig and you dig, but find nothing.
        RESPONSE                    = 7329, -- There is no response...
        HARVESTING_IS_POSSIBLE_HERE = 7561, -- Harvesting is possible here if you have <item>.
        CANNOT_ENTER                = 7584, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                   = 7585, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS              = 7589, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR              = 7593, -- One or more party members are too far away from the entrance. Unable to enter area.
        HOMEPOINT_SET               = 7692, -- Home point set!
    },
    mob =
    {
        MAHISHASURA_PH     =
        {
            [16990296] = 16990306, -- 215.000 -18.000 372.000
        },
        EMERGENT_ELM_PH    =
        {
            [16990374] = 16990376, -- 86.000 -35.000 621.000
        },
        NIS_PUK_PH         =
        {
            [16990383] = 16990403, -- -135 -18 -648
            [16990384] = 16990403, -- -104 -18 -636
            [16990385] = 16990403, -- -123 -16 -638
            [16990391] = 16990403, -- -106 -16 -613
            [16990392] = 16990403, -- -109 -15 -600
            [16990393] = 16990403, -- -128 -15 -602
            [16990394] = 16990403, -- -132 -16 -612
            [16990398] = 16990403, -- -119 -15 -651
        },
        HARVESTMAN         = 16990252,
        LIVIDROOT_AMOOSHAH = 16990473,
        DEA                = 16990474,
    },
    npc =
    {
        HARVESTING =
        {
            16990607,
            16990608,
            16990609,
            16990610,
            16990611,
            16990612,
        },
    },
}

return zones[tpz.zone.BHAFLAU_THICKETS]
