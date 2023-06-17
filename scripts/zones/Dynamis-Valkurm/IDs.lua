-----------------------------------
-- Area: Dynamis-Valkurm
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.DYNAMIS_VALKURM] =
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
            { minutes = 10, ki = xi.ki.CRIMSON_GRANULES_OF_TIME,   mob = 16937214 },
            { minutes = 10, ki = xi.ki.AZURE_GRANULES_OF_TIME,     mob = 16937239 },
            { minutes = 10, ki = xi.ki.AMBER_GRANULES_OF_TIME,     mob = 16937264 },
            { minutes = 10, ki = xi.ki.ALABASTER_GRANULES_OF_TIME, mob = 16937289 },
            { minutes = 20, ki = xi.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = { 16937500, 16937525, 16937550, 16937575 } },
        },

        REFILL_STATUE =
        {
            {
                { mob = 16937208, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16937209, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937210, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937211, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16937212, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937213, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937233, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16937234, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937235, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937236, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16937237, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937238, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937258, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16937259, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937260, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937261, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16937262, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937263, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937283, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16937284, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937285, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937286, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16937287, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937288, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937494, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16937495, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937496, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937497, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16937498, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937499, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937519, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16937520, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937521, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937522, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16937523, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937524, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937544, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16937545, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937546, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937547, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16937548, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937549, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937569, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16937570, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937571, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16937572, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16937573, eye = xi.dynamis.eye.BLUE  },
                { mob = 16937574, eye = xi.dynamis.eye.GREEN },
            },
        },
    },

    npc =
    {
        QM =
        {
            -- [16937585] =
            -- {
            --     param = { 3456, 3470, 3471, 3472, 3473 },
            --     trade =
            --     {
            --         { item = 3456,                     mob = 16936961 }, -- Cirrate Christelle
            --         { item = { 3470, 3471, 3472, 3473 }, mob = 16937290 }, -- Arch Christelle
            --     }
            -- },
            -- [16937586] = { trade = { { item = 3461, mob = 16937311 } } }, -- Lost Nant'ina
            -- [16937587] = { trade = { { item = 3460, mob = 16937432 } } }, -- Lost Fairy Ring
            -- [16937588] = { trade = { { item = 3462, mob = 16937415 } } }, -- Lost Stcemqestcint
        },
    },
}

return zones[xi.zone.DYNAMIS_VALKURM]
