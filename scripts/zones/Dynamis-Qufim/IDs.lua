-----------------------------------
-- Area: Dynamis-Qufim
-----------------------------------
zones = zones or {}

zones[xi.zone.DYNAMIS_QUFIM] =
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
        OMINOUS_PRESENCE              = 7342, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    mob =
    {
        TIME_EXTENSION =
        {
            { minutes = 10, ki = xi.ki.CRIMSON_GRANULES_OF_TIME,   mob = { 16945163, 16945173, 16945183 } },
            { minutes = 10, ki = xi.ki.AZURE_GRANULES_OF_TIME,     mob = { 16945193, 16945203, 16945213 } },
            { minutes = 10, ki = xi.ki.AMBER_GRANULES_OF_TIME,     mob = { 16945223, 16945233, 16945243 } },
            { minutes = 10, ki = xi.ki.ALABASTER_GRANULES_OF_TIME, mob = { 16945253, 16945263, 16945273 } },
            { minutes = 20, ki = xi.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = { 16945480, 16945491, 16945500, 16945509, 16945530, 16945539, 16945548, 16945568, 16945578, 16945588, 16945608, 16945618, 16945628 } },
        },

        REFILL_STATUE =
        {
            {
                { mob = 16945160, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16945161, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945162, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945170, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16945171, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945172, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945180, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16945181, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945182, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945190, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16945191, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945192, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945200, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16945201, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945202, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945210, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16945211, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945212, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945220, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16945221, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945222, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945230, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16945231, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945232, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945240, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16945241, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945242, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945250, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16945251, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945252, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945260, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16945261, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945262, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945270, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16945271, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945272, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945477, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16945478, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945479, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945488, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16945489, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945490, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945497, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16945498, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945499, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945506, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16945507, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945508, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945527, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16945528, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945529, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945536, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16945537, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945538, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945545, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16945546, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945547, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945565, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16945566, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945567, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945575, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16945576, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945577, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945585, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16945586, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945587, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945605, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16945606, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945607, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945615, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16945616, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945617, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16945625, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16945626, eye = xi.dynamis.eye.BLUE  },
                { mob = 16945627, eye = xi.dynamis.eye.GREEN },
            },
        },
    },

    npc =
    {
        QM =
        {
            -- [16945638] =
            -- {
            --     param = { 3458, 3479, 3480, 3481, 3482 },
            --     trade =
            --     {
            --         { item = 3458,                       mob = 16945153 }, -- Antaeus
            --         { item = { 3479, 3480, 3481, 3482 }, mob = 16945403 }, -- Arch Antaeus
            --     }
            -- },
            -- [16945639] = { trade = { { item = 3468, mob = 16945421 } } }, -- Lost Stringes
            -- [16945640] = { trade = { { item = 3467, mob = 16945457 } } }, -- Lost Scolopendra
            -- [16945641] = { trade = { { item = 3469, mob = 16945470 } } }, -- Lost Suttung
        },
    },
}

return zones[xi.zone.DYNAMIS_QUFIM]
