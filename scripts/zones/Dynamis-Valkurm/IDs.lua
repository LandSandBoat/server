-----------------------------------
-- Area: Dynamis-Valkurm
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.DYNAMIS_VALKURM] =
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
        OMINOUS_PRESENCE        = 7332, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    mob =
    {
        TIME_EXTENSION =
        {
            {minutes = 10, ki = xi.ki.CRIMSON_GRANULES_OF_TIME,   mob = 16937214},
            {minutes = 10, ki = xi.ki.AZURE_GRANULES_OF_TIME,     mob = 16937239},
            {minutes = 10, ki = xi.ki.AMBER_GRANULES_OF_TIME,     mob = 16937264},
            {minutes = 10, ki = xi.ki.ALABASTER_GRANULES_OF_TIME, mob = 16937289},
            {minutes = 20, ki = xi.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = {16937500, 16937525, 16937550, 16937575}},
        },
        REFILL_STATUE =
        {
            {
                {mob = 16937208, eye = dynamis.eye.RED  }, -- Serjeant_Tombstone
                {mob = 16937209, eye = dynamis.eye.BLUE },
                {mob = 16937210, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937211, eye = dynamis.eye.RED  }, -- Serjeant_Tombstone
                {mob = 16937212, eye = dynamis.eye.BLUE },
                {mob = 16937213, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937233, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 16937234, eye = dynamis.eye.BLUE },
                {mob = 16937235, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937236, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 16937237, eye = dynamis.eye.BLUE },
                {mob = 16937238, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937258, eye = dynamis.eye.RED  }, -- Manifest_Icon
                {mob = 16937259, eye = dynamis.eye.BLUE },
                {mob = 16937260, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937261, eye = dynamis.eye.RED  }, -- Manifest_Icon
                {mob = 16937262, eye = dynamis.eye.BLUE },
                {mob = 16937263, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937283, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 16937284, eye = dynamis.eye.BLUE },
                {mob = 16937285, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937286, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 16937287, eye = dynamis.eye.BLUE },
                {mob = 16937288, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937494, eye = dynamis.eye.RED  }, -- Serjeant_Tombstone
                {mob = 16937495, eye = dynamis.eye.BLUE },
                {mob = 16937496, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937497, eye = dynamis.eye.RED  }, -- Serjeant_Tombstone
                {mob = 16937498, eye = dynamis.eye.BLUE },
                {mob = 16937499, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937519, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 16937520, eye = dynamis.eye.BLUE },
                {mob = 16937521, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937522, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 16937523, eye = dynamis.eye.BLUE },
                {mob = 16937524, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937544, eye = dynamis.eye.RED  }, -- Manifest_Icon
                {mob = 16937545, eye = dynamis.eye.BLUE },
                {mob = 16937546, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937547, eye = dynamis.eye.RED  }, -- Manifest_Icon
                {mob = 16937548, eye = dynamis.eye.BLUE },
                {mob = 16937549, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937569, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 16937570, eye = dynamis.eye.BLUE },
                {mob = 16937571, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16937572, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 16937573, eye = dynamis.eye.BLUE },
                {mob = 16937574, eye = dynamis.eye.GREEN},
            },
        },
    },
    npc =
    {
        QM =
        {
            -- [16937585] =
            -- {
            --     param = {3456, 3470, 3471, 3472, 3473},
            --     trade =
            --     {
            --         {item = 3456,                     mob = 16936961}, -- Cirrate Christelle
            --         {item = {3470, 3471, 3472, 3473}, mob = 16937290}, -- Arch Christelle
            --     }
            -- },
            -- [16937586] = {trade = {{item = 3461, mob = 16937311}}}, -- Lost Nant'ina
            -- [16937587] = {trade = {{item = 3460, mob = 16937432}}}, -- Lost Fairy Ring
            -- [16937588] = {trade = {{item = 3462, mob = 16937415}}}, -- Lost Stcemqestcint
        },
    },
}

return zones[xi.zone.DYNAMIS_VALKURM]
