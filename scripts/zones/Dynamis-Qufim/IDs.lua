-----------------------------------
-- Area: Dynamis-Qufim
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.DYNAMIS_QUFIM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CONQUEST_BASE           = 7149, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN      = 7314, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND     = 7315, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1   = 7316, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2   = 7317, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED    = 7319, -- The sands of the hourglass have emptied...
        OMINOUS_PRESENCE        = 7330, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    mob =
    {
        TIME_EXTENSION =
        {
            {minutes = 10, ki = tpz.ki.CRIMSON_GRANULES_OF_TIME,   mob = {16945163, 16945173, 16945183}},
            {minutes = 10, ki = tpz.ki.AZURE_GRANULES_OF_TIME,     mob = {16945193, 16945203, 16945213}},
            {minutes = 10, ki = tpz.ki.AMBER_GRANULES_OF_TIME,     mob = {16945223, 16945233, 16945243}},
            {minutes = 10, ki = tpz.ki.ALABASTER_GRANULES_OF_TIME, mob = {16945253, 16945263, 16945273}},
            {minutes = 20, ki = tpz.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = {16945480, 16945491, 16945500, 16945509, 16945530, 16945539, 16945548, 16945568, 16945578, 16945588, 16945608, 16945618, 16945628}},
        },
        REFILL_STATUE =
        {
            {
                {mob = 16945160, eye = dynamis.eye.RED  }, -- Serjeant_Tombstone
                {mob = 16945161, eye = dynamis.eye.BLUE },
                {mob = 16945162, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945170, eye = dynamis.eye.RED  }, -- Serjeant_Tombstone
                {mob = 16945171, eye = dynamis.eye.BLUE },
                {mob = 16945172, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945180, eye = dynamis.eye.RED  }, -- Serjeant_Tombstone
                {mob = 16945181, eye = dynamis.eye.BLUE },
                {mob = 16945182, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945190, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 16945191, eye = dynamis.eye.BLUE },
                {mob = 16945192, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945200, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 16945201, eye = dynamis.eye.BLUE },
                {mob = 16945202, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945210, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 16945211, eye = dynamis.eye.BLUE },
                {mob = 16945212, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945220, eye = dynamis.eye.RED  }, -- Manifest_Icon
                {mob = 16945221, eye = dynamis.eye.BLUE },
                {mob = 16945222, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945230, eye = dynamis.eye.RED  }, -- Manifest_Icon
                {mob = 16945231, eye = dynamis.eye.BLUE },
                {mob = 16945232, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945240, eye = dynamis.eye.RED  }, -- Manifest_Icon
                {mob = 16945241, eye = dynamis.eye.BLUE },
                {mob = 16945242, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945250, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 16945251, eye = dynamis.eye.BLUE },
                {mob = 16945252, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945260, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 16945261, eye = dynamis.eye.BLUE },
                {mob = 16945262, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945270, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 16945271, eye = dynamis.eye.BLUE },
                {mob = 16945272, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945477, eye = dynamis.eye.RED  }, -- Serjeant_Tombstone
                {mob = 16945478, eye = dynamis.eye.BLUE },
                {mob = 16945479, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945488, eye = dynamis.eye.RED  }, -- Serjeant_Tombstone
                {mob = 16945489, eye = dynamis.eye.BLUE },
                {mob = 16945490, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945497, eye = dynamis.eye.RED  }, -- Serjeant_Tombstone
                {mob = 16945498, eye = dynamis.eye.BLUE },
                {mob = 16945499, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945506, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 16945507, eye = dynamis.eye.BLUE },
                {mob = 16945508, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945527, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 16945528, eye = dynamis.eye.BLUE },
                {mob = 16945529, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945536, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 16945537, eye = dynamis.eye.BLUE },
                {mob = 16945538, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945545, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 16945546, eye = dynamis.eye.BLUE },
                {mob = 16945547, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945565, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 16945566, eye = dynamis.eye.BLUE },
                {mob = 16945567, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945575, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 16945576, eye = dynamis.eye.BLUE },
                {mob = 16945577, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945585, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 16945586, eye = dynamis.eye.BLUE },
                {mob = 16945587, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945605, eye = dynamis.eye.RED  }, -- Manifest_Icon
                {mob = 16945606, eye = dynamis.eye.BLUE },
                {mob = 16945607, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945615, eye = dynamis.eye.RED  }, -- Manifest_Icon
                {mob = 16945616, eye = dynamis.eye.BLUE },
                {mob = 16945617, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 16945625, eye = dynamis.eye.RED  }, -- Manifest_Icon
                {mob = 16945626, eye = dynamis.eye.BLUE },
                {mob = 16945627, eye = dynamis.eye.GREEN},
            },
        },
    },
    npc =
    {
        QM =
        {
            -- [16945638] =
            -- {
            --     param = {3458, 3479, 3480, 3481, 3482},
            --     trade =
            --     {
            --         {item = 3458,                     mob = 16945153}, -- Antaeus
            --         {item = {3479, 3480, 3481, 3482}, mob = 16945403}, -- Arch Antaeus
            --     }
            -- },
            -- [16945639] = {trade = {{item = 3468, mob = 16945421}}}, -- Lost Stringes
            -- [16945640] = {trade = {{item = 3467, mob = 16945457}}}, -- Lost Scolopendra
            -- [16945641] = {trade = {{item = 3469, mob = 16945470}}}, -- Lost Suttung
        },
    },
}

return zones[tpz.zone.DYNAMIS_QUFIM]
