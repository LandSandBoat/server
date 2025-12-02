-----------------------------------
-- Area: Dynamis-Buburimu
-----------------------------------
zones = zones or {}

zones[xi.zone.DYNAMIS_BUBURIMU] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7168, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN            = 7333, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND           = 7334, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1         = 7335, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2         = 7336, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED          = 7338, -- The sands of the hourglass have emptied...
        DYNAMIS_SUB_UNLOCKED          = 7343, -- Memories of skills long forgotten come flooding back to you...
        OMINOUS_PRESENCE              = 7350, -- You feel an ominous presence, as if something might happen if you possessed <item>.
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

        GOSSPIX_BLABBERLIPS      = GetFirstID('Gosspix_Blabberlips'),
        SHAMBLIX_ROTTENHEART     = GetFirstID('Shamblix_Rottenheart'),
        WOODNIX_SHRILLWHISTLE    = GetFirstID('Woodnix_Shrillwhistle'),
        HAMFIST_GUKHBUK          = GetFirstID('Hamfist_Gukhbuk'),
        FLAMECALLER_ZOEQDOQ      = GetFirstID('Flamecaller_Zoeqdoq'),
        LYNCEAN_JUWGNEG          = GetFirstID('Lyncean_Juwgneg'),
        ELVAANSTICKER_BXAFRAFF   = GetFirstID('Elvaansticker_Bxafraff'),
        QUPHO_BLOODSPILLER       = GetFirstID('QuPho_Bloodspiller'),
        GIBHE_FLESHFEASTER       = GetFirstID('GiBhe_Fleshfeaster'),
        TEZHA_IRONCLAD           = GetFirstID('TeZha_Ironclad'),
        VARHU_BODYSNATCHER       = GetFirstID('VaRhu_Bodysnatcher'),
        REE_NATA_THE_MELOMANIC   = GetFirstID('Ree_Nata_the_Melomanic'),
        KOO_RAHI_THE_LEVINBLADE  = GetFirstID('Koo_Rahi_the_Levinblade'),
        DOO_PEKU_THE_FLEETFOOT   = GetFirstID('Doo_Peku_the_Fleetfoot'),
        BAA_DAVA_THE_BIBLIOPHAGE = GetFirstID('Baa_Dava_the_Bibliophage'),
    },

    npc =
    {
        QM =
        {
            -- [16941677] =
            -- {
            --     param = { 3457, 3474, 3475, 3476, 3477, 3478 },
            --     trade =
            --     {
            --         { item = 3457,                             mob = 16941057 }, -- Apocalyptic Beast
            --         { item = { 3474, 3475, 3476, 3477, 3478 }, mob = 16941368 }, -- Arch Apocalyptic Beast
            --     }
            -- },
            -- [16941678] = { trade = { { item = 3463, mob = 16941552 } } }, -- Lost Stihi
            -- [16941679] = { trade = { { item = 3464, mob = 16941520 } } }, -- Lost Barong
            -- [16941680] = { trade = { { item = 3465, mob = 16941576 } } }, -- Lost Alklha
            -- [16941681] = { trade = { { item = 3466, mob = 16941666 } } }, -- Lost Aitvaras
        },
    },
}

return zones[xi.zone.DYNAMIS_BUBURIMU]
