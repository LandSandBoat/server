-----------------------------------
-- Area: East_Ronfaure_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.EAST_RONFAURE_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6389, -- Obtained: <item>.
        GIL_OBTAINED             = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6392, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6403, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS      = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        LOGGING_IS_POSSIBLE_HERE = 7147, -- Logging is possible here if you have <item>.
        FISHING_MESSAGE_OFFSET   = 7731, -- You can't fish here.
        COMMON_SENSE_SURVIVAL    = 8958, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        GOBLINTRAP_PH =
        {
            [17109295] = 17109296, -- 156 0 -438
        },
        SKOGS_FRU_PH =
        {
            [17109268] = 17109338,
            [17109306] = 17109338,
            [17109307] = 17109338,
            [17109308] = 17109338,
        },
        MYRADROSH    = 17109235,
    },
    npc =
    {
        LOGGING =
        {
            17109782,
            17109783,
            17109784,
            17109785,
            17109786,
            17109787,
        },
    },
}

return zones[xi.zone.EAST_RONFAURE_S]
