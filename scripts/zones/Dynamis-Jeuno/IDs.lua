-----------------------------------
-- Area: Dynamis-Jeuno
-----------------------------------
zones = zones or {}

zones[xi.zone.DYNAMIS_JEUNO] =
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
        CONQUEST_BASE                 = 7074, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN            = 7233, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND           = 7234, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1         = 7235, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2         = 7236, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED          = 7238, -- The sands of the hourglass have emptied...
        OMINOUS_PRESENCE              = 7250, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    mob =
    {
        TIME_EXTENSION =
        {
            { minutes = 10, ki = xi.ki.CRIMSON_GRANULES_OF_TIME,   mob = { 17547301, 17547302, 17547303 } },
            { minutes = 10, ki = xi.ki.AZURE_GRANULES_OF_TIME,     mob = 17547389 },
            { minutes = 10, ki = xi.ki.AMBER_GRANULES_OF_TIME,     mob = 17547390 },
            { minutes = 15, ki = xi.ki.ALABASTER_GRANULES_OF_TIME, mob = 17547420 },
            { minutes = 15, ki = xi.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = 17547467 },
        },

        REFILL_STATUE =
        {
            {
                { mob = 17547295, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 17547296, eye = xi.dynamis.eye.BLUE  },
                { mob = 17547297, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 17547391, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 17547392, eye = xi.dynamis.eye.BLUE  },
                { mob = 17547393, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 17547421, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 17547422, eye = xi.dynamis.eye.BLUE  },
                { mob = 17547423, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 17547456, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 17547457, eye = xi.dynamis.eye.BLUE  },
                { mob = 17547458, eye = xi.dynamis.eye.GREEN },
            },
        },

        GABBLOX_MAGPIETONGUE    = GetFirstID('Gabblox_Magpietongue'),
        TUFFLIX_LOGLIMBS        = GetFirstID('Tufflix_Loglimbs'),
        CLOKTIX_LONGNAIL        = GetFirstID('Cloktix_Longnail'),
        HERMITRIX_TOOTHROT      = GetFirstID('Hermitrix_Toothrot'),
        WYRMWIX_SNAKESPECS      = GetFirstID('Wyrmwix_Snakespecs'),
        MORTILOX_WARTPAWS       = GetFirstID('Mortilox_Wartpaws'),
        RUTRIX_HAMGAMS          = GetFirstID('Rutrix_Hamgams'),
        ANVILIX_SOOTWRISTS      = GetFirstID('Anvilix_Sootwrists'),
        BOOTRIX_JAGGEDELBOW     = GetFirstID('Bootrix_Jaggedelbow'),
        MOBPIX_MUCOUSMOUTH      = GetFirstID('Mobpix_Mucousmouth'),
        DISTILIX_STICKYTOES     = GetFirstID('Distilix_Stickytoes'),
        EREMIX_SNOTTYNOSTRIL    = GetFirstID('Eremix_Snottynostril'),
        JABBROX_GRANNYGUISE     = GetFirstID('Jabbrox_Grannyguise'),
        PROWLOX_BARRELBELLY     = GetFirstID('Prowlox_Barrelbelly'),
        SCRUFFIX_SHAGGYCHEST    = GetFirstID('Scruffix_Shaggychest'),
        TYMEXOX_NINEFINGERS     = GetFirstID('Tymexox_Ninefingers'),
        BLAZOX_BONEYBOD         = GetFirstID('Blazox_Boneybod'),
        SLYSTIX_MEGAPEEPERS     = GetFirstID('Slystix_Megapeepers'),
    },
    npc =
    {
        QM =
        {
            [17547510] =
            {
                param = { 3356, 3419, 3420, 3421, 3422, 3423 },
                trade =
                {
                    { item = 3356,                             mob = 17547265 }, -- Goblin Golem
                    { item = { 3419, 3420, 3421, 3422, 3423 }, mob = 17547499 }, -- Arch Goblin Golem
                }
            },
            [17547511] = { trade = { { item = 3392, mob = 17547493 } } }, -- Quicktrix Hexhands
            [17547512] = { trade = { { item = 3393, mob = 17547494 } } }, -- Feralox Honeylips
            [17547513] = { trade = { { item = 3394, mob = 17547496 } } }, -- Scourquix Scaleskin
            [17547514] = { trade = { { item = 3395, mob = 17547498 } } }, -- Wilywox Tenderpalm
        },
    },
}

return zones[xi.zone.DYNAMIS_JEUNO]
