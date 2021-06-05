-----------------------------------
-- Area: Dynamis-Tavnazia
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.DYNAMIS_TAVNAZIA] =
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
        CONQUEST_BASE           = 7150, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN      = 7315, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND     = 7316, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1   = 7317, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2   = 7318, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED    = 7320, -- The sands of the hourglass have emptied...
        DIABOLOS                = 7329, -- You sense that something might happen if you possessed one of these...
        OMINOUS_PRESENCE        = 7332, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    mob =
    {
        TIME_EXTENSION =
        {
            {minutes = 10, ki = xi.ki.CRIMSON_GRANULES_OF_TIME,   mob = 16949272},
            {minutes = 10, ki = xi.ki.AZURE_GRANULES_OF_TIME,     mob = 16949292},
            {minutes = 10, ki = xi.ki.AMBER_GRANULES_OF_TIME,     mob = 16949306},
            {minutes = 10, ki = xi.ki.ALABASTER_GRANULES_OF_TIME, mob = 16949325},
            {minutes = 20, ki = xi.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = 16949380},
        },
        REFILL_STATUE =
        {
            {
                {mob = 16949269, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 16949270, eye = dynamis.eye.BLUE },
                {mob = 16949271, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16949289, eye = dynamis.eye.RED  }, -- Serjeant_Tombstone
                {mob = 16949290, eye = dynamis.eye.BLUE },
                {mob = 16949291, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16949303, eye = dynamis.eye.RED  }, -- Manifest_Icon
                {mob = 16949304, eye = dynamis.eye.BLUE },
                {mob = 16949305, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16949322, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 16949323, eye = dynamis.eye.BLUE },
                {mob = 16949324, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16949356, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 16949357, eye = dynamis.eye.BLUE },
                {mob = 16949358, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16949362, eye = dynamis.eye.RED  }, -- Manifest_Icon
                {mob = 16949363, eye = dynamis.eye.BLUE },
                {mob = 16949364, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16949369, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 16949370, eye = dynamis.eye.BLUE },
                {mob = 16949371, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16949376, eye = dynamis.eye.RED  }, -- Serjeant_Tombstone
                {mob = 16949377, eye = dynamis.eye.BLUE },
                {mob = 16949378, eye = dynamis.eye.GREEN},
            },
        },
    },
    npc =
    {
        QM =
        {
            [16949396] =
            {
                param = {3459, 3483, 3484, 3485, 3486},
                trade =
                {
                    {item = 3459,                     mob = {16949249, 16949250, 16949251, 16949252}}, -- Diabolos Spade/Heart/Diamond/Club
                    {item = {3483, 3484, 3485, 3486}, mob = {16949326, 16949327, 16949328, 16949329}}, -- Diabolos Somnus/Nox/Umbra/Letum
                }
            },
        },
    },
}

return zones[xi.zone.DYNAMIS_TAVNAZIA]
