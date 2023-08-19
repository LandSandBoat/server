-----------------------------------
-- Area: Dynamis-Tavnazia
-----------------------------------
zones = zones or {}

zones[xi.zone.DYNAMIS_TAVNAZIA] =
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
        CONQUEST_BASE                 = 7160, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN            = 7325, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND           = 7326, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1         = 7327, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2         = 7328, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED          = 7330, -- The sands of the hourglass have emptied...
        DYNAMIS_SUB_UNLOCKED          = 7335, -- Memories of skills long forgotten come flooding back to you...
        DIABOLOS                      = 7339, -- You sense that something might happen if you possessed one of these...
        OMINOUS_PRESENCE              = 7342, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    mob =
    {
        TIME_EXTENSION =
        {
            { minutes = 10, ki = xi.ki.CRIMSON_GRANULES_OF_TIME,   mob = 16949272 },
            { minutes = 10, ki = xi.ki.AZURE_GRANULES_OF_TIME,     mob = 16949292 },
            { minutes = 10, ki = xi.ki.AMBER_GRANULES_OF_TIME,     mob = 16949306 },
            { minutes = 10, ki = xi.ki.ALABASTER_GRANULES_OF_TIME, mob = 16949325 },
            { minutes = 20, ki = xi.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = 16949380 },
        },

        REFILL_STATUE =
        {
            {
                { mob = 16949269, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16949270, eye = xi.dynamis.eye.BLUE  },
                { mob = 16949271, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16949289, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16949290, eye = xi.dynamis.eye.BLUE  },
                { mob = 16949291, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16949303, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16949304, eye = xi.dynamis.eye.BLUE  },
                { mob = 16949305, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16949322, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16949323, eye = xi.dynamis.eye.BLUE  },
                { mob = 16949324, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16949356, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16949357, eye = xi.dynamis.eye.BLUE  },
                { mob = 16949358, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16949362, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16949363, eye = xi.dynamis.eye.BLUE  },
                { mob = 16949364, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16949369, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16949370, eye = xi.dynamis.eye.BLUE  },
                { mob = 16949371, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16949376, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16949377, eye = xi.dynamis.eye.BLUE  },
                { mob = 16949378, eye = xi.dynamis.eye.GREEN },
            },
        },
    },

    npc =
    {
        QM =
        {
            [16949396] =
            {
                param = { 3459, 3483, 3484, 3485, 3486 },
                trade =
                {
                    { item = 3459,                       mob = { 16949249, 16949250, 16949251, 16949252 } }, -- Diabolos Spade/Heart/Diamond/Club
                    { item = { 3483, 3484, 3485, 3486 }, mob = { 16949326, 16949327, 16949328, 16949329 } }, -- Diabolos Somnus/Nox/Umbra/Letum
                }
            },
        },
    },
}

return zones[xi.zone.DYNAMIS_TAVNAZIA]
