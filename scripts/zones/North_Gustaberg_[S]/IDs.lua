-----------------------------------
-- Area: North_Gustaberg_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.NORTH_GUSTABERG_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        LYCOPODIUM_ENTRANCED    = 7057, -- The lycopodium is entranced by a sparkling light...
        FISHING_MESSAGE_OFFSET  = 7356, -- You can't fish here.
        MINING_IS_POSSIBLE_HERE = 7545, -- Mining is possible here if you have <item>.
        COMMON_SENSE_SURVIVAL   = 9077, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        ANKABUT_PH =
        {
            [17137701] = 17137705, -- 656.399 -11.580 507.091
        },
        GLOOMANITA_PH =
        {
            [17137820] = 17137821, -- -19.961 0.5 623.989
        },
    },
    npc =
    {
        MINING =
        {
            17138511,
            17138512,
            17138513,
            17138514,
            17138515,
            17138516,
        },
    },
}

return zones[xi.zone.NORTH_GUSTABERG_S]
