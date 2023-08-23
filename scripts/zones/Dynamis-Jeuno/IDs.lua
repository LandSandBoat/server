-----------------------------------
-- Area: Dynamis-Jeuno
-----------------------------------
zones = zones or {}

zones[xi.zone.DYNAMIS_JEUNO] =
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
        CONQUEST_BASE                 = 7066, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN            = 7225, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND           = 7226, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1         = 7227, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2         = 7228, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED          = 7230, -- The sands of the hourglass have emptied...
        OMINOUS_PRESENCE              = 7242, -- You feel an ominous presence, as if something might happen if you possessed <item>.
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

        GABBLOX_MAGPIETONGUE_PH    = { [17547275] = 17547277 }, -- Vanguard_Armorer 2.179 8.5 -61.613
        TUFFLIX_LOGLIMBS_PH        = { [17547289] = 17547291 }, -- Vanguard_Armorer 15.499 8.384 -36.562
        CLOKTIX_LONGNAIL_PH        = { [17547292] = 17547294 }, -- Vanguard_Armorer -17.690 8.321 -51.944
        HERMITRIX_TOOTHROT_PH      = { [17547310] = 17547311 }, -- Vanguard_Enchanter 31.808 -0.566 -25.768
        WYRMWIX_SNAKESPECS_PH      = { [17547321] = 17547312 }, -- Vanguard_Enchanter 21.160 0.000 -7.386
        MORTILOX_WARTPAWS_PH       = { [17547443] = 17547438 }, -- Vanguard_Necromancer -9.120 1.400 67.003
        RUTRIX_HAMGAMS_PH          = { [17547452] = 17547454 }, -- Vanguard_Dragontamer 0.144 1.756 43.922
        ANVILIX_SOOTWRISTS_PH      = { [17547469] = 17547472 }, -- Vanguard_Smithy -2.563 2.706 112.752
        BOOTRIX_JAGGEDELBOW_PH     = { [17547470] = 17547473 }, -- Vanguard_Pitfighter -2.487 2.418 106.984
        MOBPIX_MUCOUSMOUTH_PH      = { [17547471] = 17547474 }, -- Vanguard_Welldigger -0.508 2.499 112.929
        DISTILIX_STICKYTOES_PH     = { [17547475] = 17547478 }, -- Vanguard_Alchemist -2.164 2.5 106.255
        EREMIX_SNOTTYNOSTRIL_PH    = { [17547476] = 17547479 }, -- Vanguard_Shaman 1.584 2.499 111.664
        JABBROX_GRANNYGUISE_PH     = { [17547477] = 17547480 }, -- Vanguard_Enchanter 0.371 2.663 115.674
        PROWLOX_BARRELBELLY_PH     = { [17547489] = 17547490 }, -- Vanguard_Ambusher 7.509 2.500 118.109
        SCRUFFIX_SHAGGYCHEST_PH    = { [17547481] = 17547485 }, -- Vanguard_Armorer -0.428 2.599 117.675
        TYMEXOX_NINEFINGERS_PH     = { [17547482] = 17547486 }, -- Vanguard_Tinkerer 2.257 2.489 117.621
        BLAZOX_BONEYBOD_PH         = { [17547483] = 17547487 }, -- Vanguard_Pathfinder -1.698 2.493 116.454
        SLYSTIX_MEGAPEEPERS_PH     = { [17547491] = 17547492 }, -- Vanguard_Hitman -8.440 2.500 118.349
    },
    npc =
    {
        QM =
        {
            [17547509] =
            {
                param = { 3356, 3419, 3420, 3421, 3422, 3423 },
                trade =
                {
                    { item = 3356,                             mob = 17547265 }, -- Goblin Golem
                    { item = { 3419, 3420, 3421, 3422, 3423 }, mob = 17547499 }, -- Arch Goblin Golem
                }
            },
            [17547510] = { trade = { { item = 3392, mob = 17547493 } } }, -- Quicktrix Hexhands
            [17547511] = { trade = { { item = 3393, mob = 17547494 } } }, -- Feralox Honeylips
            [17547512] = { trade = { { item = 3394, mob = 17547496 } } }, -- Scourquix Scaleskin
            [17547513] = { trade = { { item = 3395, mob = 17547498 } } }, -- Wilywox Tenderpalm
        },
    },
}

return zones[xi.zone.DYNAMIS_JEUNO]
