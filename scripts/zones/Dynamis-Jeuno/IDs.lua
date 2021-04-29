-----------------------------------
-- Area: Dynamis-Jeuno
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.DYNAMIS_JEUNO] =
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
        CONQUEST_BASE           = 7056, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN      = 7215, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND     = 7216, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1   = 7217, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2   = 7218, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED    = 7220, -- The sands of the hourglass have emptied...
        OMINOUS_PRESENCE        = 7232, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    mob =
    {
        TIME_EXTENSION =
        {
            {minutes = 10, ki = xi.ki.CRIMSON_GRANULES_OF_TIME,   mob = {17547301, 17547302, 17547303}},
            {minutes = 10, ki = xi.ki.AZURE_GRANULES_OF_TIME,     mob = 17547389},
            {minutes = 10, ki = xi.ki.AMBER_GRANULES_OF_TIME,     mob = 17547390},
            {minutes = 15, ki = xi.ki.ALABASTER_GRANULES_OF_TIME, mob = 17547420},
            {minutes = 15, ki = xi.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = 17547467},
        },
        REFILL_STATUE =
        {
            {
                {mob = 17547295, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 17547296, eye = dynamis.eye.BLUE },
                {mob = 17547297, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17547391, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 17547392, eye = dynamis.eye.BLUE },
                {mob = 17547393, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17547421, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 17547422, eye = dynamis.eye.BLUE },
                {mob = 17547423, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17547456, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 17547457, eye = dynamis.eye.BLUE },
                {mob = 17547458, eye = dynamis.eye.GREEN},
            },
        },
    },
    npc =
    {
        QM =
        {
            [17547509] =
            {
                param = {3356, 3419, 3420, 3421, 3422, 3423},
                trade =
                {
                    {item = 3356,                           mob = 17547265}, -- Goblin Golem
                    {item = {3419, 3420, 3421, 3422, 3423}, mob = 17547499}, -- Arch Goblin Golem
                }
            },
            [17547510] = {trade = {{item = 3392, mob = 17547493}}}, -- Quicktrix Hexhands
            [17547511] = {trade = {{item = 3393, mob = 17547494}}}, -- Feralox Honeylips
            [17547512] = {trade = {{item = 3394, mob = 17547496}}}, -- Scourquix Scaleskin
            [17547513] = {trade = {{item = 3395, mob = 17547498}}}, -- Wilywox Tenderpalm
        },
    },
}

return zones[xi.zone.DYNAMIS_JEUNO]
