-----------------------------------
-- Area: Dynamis-Buburimu
-----------------------------------
zones = zones or {}

zones[xi.zone.DYNAMIS_BUBURIMU] =
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
            { minutes = 10, ki = xi.ki.CRIMSON_GRANULES_OF_TIME,   mob = { 16941121, 16941138 } },
            { minutes = 10, ki = xi.ki.AZURE_GRANULES_OF_TIME,     mob = { 16941156, 16941174 } },
            { minutes = 10, ki = xi.ki.AMBER_GRANULES_OF_TIME,     mob = { 16941193, 16941211 } },
            { minutes = 10, ki = xi.ki.ALABASTER_GRANULES_OF_TIME, mob = { 16941071, 16941086, 16941101 } },
            { minutes = 20, ki = xi.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = { 16941384, 16941398, 16941414, 16941428, 16941443, 16941458, 16941474, 16941488 } },
        },

        REFILL_STATUE =
        {
            {
                { mob = 16941068, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16941069, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941070, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941083, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16941084, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941085, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941098, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16941099, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941100, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941118, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16941119, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941120, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941135, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16941136, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941137, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941153, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16941154, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941155, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941171, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16941172, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941173, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941190, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16941191, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941192, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941208, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16941209, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941210, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941381, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16941382, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941383, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941395, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 16941396, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941397, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941411, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16941412, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941413, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941425, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 16941426, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941427, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941440, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16941441, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941442, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941455, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 16941456, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941457, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941471, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16941472, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941473, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 16941485, eye = xi.dynamis.eye.RED   }, -- Manifest_Icon
                { mob = 16941486, eye = xi.dynamis.eye.BLUE  },
                { mob = 16941487, eye = xi.dynamis.eye.GREEN },
            },
        },

        GOSSPIX_BLABBERLIPS_PH      = { [16941089] = 16941097 }, -- Vanguard_Enchanter
        SHAMBLIX_ROTTENHEART_PH     = { [16941078] = 16941082 }, -- Vanguard_Tinkerer
        WOODNIX_SHRILLWHISTLE_PH    = { [16941060] = 16941066 }, -- Vanguard_Pathfinder
        HAMFIST_GUKHBUK_PH          = { [16941124] = 16941133 }, -- Vanguard_Grappler
        FLAMECALLER_ZOEQDOQ_PH      = { [16941103] = 16941115 }, -- Vanguard_Mesmerizer
        LYNCEAN_JUWGNEG_PH          = { [16941127] = 16941134 }, -- Vanguard_Predator
        ELVAANSTICKER_BXAFRAFF_PH   = { [16941113] = 16941116 }, -- Vanguard_Impaler
        QUPHO_BLOODSPILLER_PH       = { [16941139] = 16941151 }, -- Vanguard_Vindicator
        GIBHE_FLESHFEASTER_PH       = { [16941142] = 16941152 }, -- Vanguard_Constable
        TEZHA_IRONCLAD_PH           = { [16941162] = 16941170 }, -- Vanguard_Defender
        VARHU_BODYSNATCHER_PH       = { [16941161] = 16941169 }, -- Vanguard_Purloiner
        REE_NATA_THE_MELOMANIC_PH   = { [16941184] = 16941188 }, -- Vanguard_Chanter
        KOO_RAHI_THE_LEVINBLADE_PH  = { [16941185] = 16941189 }, -- Vanguard_Persecutor
        DOO_PEKU_THE_FLEETFOOT_PH   = { [16941202] = 16941205 }, -- Vanguard_Assassin
        BAA_DAVA_THE_BIBLIOPHAGE_PH = { [16941203] = 16941206 }, -- Vanguard_Oracle
    },

    npc =
    {
        QM =
        {
            -- [16941676] =
            -- {
            --     param = { 3457, 3474, 3475, 3476, 3477, 3478 },
            --     trade =
            --     {
            --         { item = 3457,                             mob = 16941057 }, -- Apocalyptic Beast
            --         { item = { 3474, 3475, 3476, 3477, 3478 }, mob = 16941368 }, -- Arch Apocalyptic Beast
            --     }
            -- },
            -- [16941677] = { trade = { { item = 3463, mob = 16941552 } } }, -- Lost Stihi
            -- [16941678] = { trade = { { item = 3464, mob = 16941520 } } }, -- Lost Barong
            -- [16941679] = { trade = { { item = 3465, mob = 16941576 } } }, -- Lost Alklha
            -- [16941680] = { trade = { { item = 3466, mob = 16941666 } } }, -- Lost Aitvaras
        },
    },
}

return zones[xi.zone.DYNAMIS_BUBURIMU]
