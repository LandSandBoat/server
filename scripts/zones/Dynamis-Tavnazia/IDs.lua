-----------------------------------
-- Area: Dynamis-Tavnazia
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.DYNAMIS_TAVNAZIA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login no. <number>...
        CONQUEST_BASE           = 7149, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN      = 7314, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND     = 7315, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1   = 7316, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2   = 7317, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED    = 7319, -- The sands of the hourglass have emptied...
        DIABOLOS                = 7328, -- You sense that something might happen if you possessed one of these...
        OMINOUS_PRESENCE        = 7330, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    mob =
    {
        TIME_EXTENSION =
        {
            {minutes = 10, ki = tpz.ki.CRIMSON_GRANULES_OF_TIME,   mob = 16949272},
            {minutes = 10, ki = tpz.ki.AZURE_GRANULES_OF_TIME,     mob = 16949292},
            {minutes = 10, ki = tpz.ki.AMBER_GRANULES_OF_TIME,     mob = 16949306},
            {minutes = 10, ki = tpz.ki.ALABASTER_GRANULES_OF_TIME, mob = 16949325},
            {minutes = 20, ki = tpz.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = 16949380},
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

return zones[tpz.zone.DYNAMIS_TAVNAZIA]
