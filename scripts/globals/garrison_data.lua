-----------------------------------
-- Garrison Data
-----------------------------------
xi = xi or {}
xi.garrison = xi.garrison or {}

-- Name is Determined by Nation and LevelCap
-- Names in order of xi.nation values (sandoria, bastok, windurst)
xi.garrison.allyNames =
{
    [20] = { "Patrician",       "Recruit",         "Candidate"       },
    [30] = { "Trader",          "Mariner",         "Scholar"         },
    [40] = { "TempleKnight",    "GoldMusketeer",   "WizeWizard"      },
    [50] = { "RoyalGuard",      "GoldMusketeer",   "Patriarch"       },
    [99] = { "MilitaryAttache", "MilitaryAttache", "MilitaryAttache" },
}

-- Group Ids are different per cap due to min / max level requirements
-- They all use the same pool at the moment, but we could also change families
-- based on cap, which would change base stats
xi.garrison.allyGroupIds =
{
    [20] = 1,
    [30] = 2,
    [40] = 3,
    [50] = 4,
    [99] = 5,
}

-- Look is Determined by Nation and LevelCap (Appears to be 4 for each outpost - More data needed)
xi.garrison.allyLooks =
{
    [20] =
    {
        [xi.nation.SANDORIA] =
        {
            "0x01000C030010262000303A403A5008611B700000",
            "0x01000A040010262019303A40195008611C700000",
        },

        [xi.nation.BASTOK] =
        {
            "0x01000E02000066000100010001009F0000000000",
            "0x010001017D000000150015001500B70000000000",
            "0x01000701361005206630664066500C6129700000",
            "0x0100020103000300000000000000DC0000000000",
            "0x010006020F0000000F000F000F00820082000000",
            "0x01000402740014000000000003002C0100000000",
        },

        [xi.nation.WINDURST] =
        {
            "0x010007070110322032300E401550AC6000700000",
            "0x01000E0718101820183015401850B76024700000",
        },
    },
    [30] =
    {
        [xi.nation.SANDORIA] =
        {
            "0x010006030010762076303A400650736000700000",
            "0x01000F0300101520153015401550006000700000",
            "0x010009040010762076303A400650736000700000",
            "0x01000E0400101520003015401550006000700000",
        },

        [xi.nation.BASTOK] =
        {
            -- (Missing capture)
        },

        [xi.nation.WINDURST] =
        {
            "0x01000B051C1073201430144014506C6000700000",
            "0x0100010777106920693066406950B46000700000",
            "0x010000067D107820033066406850E96000700000",
        },
    },
    [40] =
    {
        [xi.nation.SANDORIA] =
        {
            "0x01000E04191019201930194019506B601C700000",
            "0x01000903191019201930194019506B601C700000",
        },

        [xi.nation.BASTOK] =
        {
            "0x0100020260102420603060406050B56000700000",
            "0x010008083D1024203D3010401050756075700000",
            "0x01000008371024203730374037506F6018700000",
            "0x0100040105102420053005400550BB6000700000",
        },

        [xi.nation.WINDURST] =
        {
            -- (Missing capture)
        },
    },
    [50] =
    {
        [xi.nation.SANDORIA] =
        {
            -- (Missing capture)
        },

        [xi.nation.BASTOK] =
        {
            -- (Missing capture)
        },

        [xi.nation.WINDURST] =
        {
            "0x0100020600106320633063406350056122700000",
            "0x010004067C102D20193019401950506100700000",
            "0x0100080669106B206B306B406B50FE6000700000",
        },
    },
    [99] =
    {
        [xi.nation.SANDORIA] =
        {
            -- (Missing capture)
        },

        [xi.nation.BASTOK] =
        {
            "0x010002071C1070201C301C401C50C46000700000",
        },

        [xi.nation.WINDURST] =
        {
            -- (Missing capture)
        },
    },
}

-- Loot is determined by LevelCap
xi.garrison.loot =
{
    [20] =
    {
        { itemid = xi.item.DRAGON_CHRONICLES, droprate = 1000 },
        { itemid = xi.item.GARRISON_TUNICA,   droprate =  350 },
        { itemid = xi.item.GARRISON_BOOTS,    droprate =  350 },
        { itemid = xi.item.GARRISON_HOSE,     droprate =  350 },
        { itemid = xi.item.GARRISON_GLOVES,   droprate =  350 },
        { itemid = xi.item.GARRISON_SALLET,   droprate =  350 },
    },
    [30] =
    {
        { itemid = xi.item.DRAGON_CHRONICLES, droprate = 1000 },
        { itemid = xi.item.MILITARY_GUN,      droprate =  350 },
        { itemid = xi.item.MILITARY_POLE,     droprate =  350 },
        { itemid = xi.item.MILITARY_HARP,     droprate =  350 },
        { itemid = xi.item.MILITARY_PICK,     droprate =  350 },
        { itemid = xi.item.MILITARY_SPEAR,    droprate =  350 },
        { itemid = xi.item.MILITARY_AXE,      droprate =  350 },
    },
    [40] =
    {
        { itemid = xi.item.DRAGON_CHRONICLES, droprate = 1000 },
        { itemid = xi.item.VARIABLE_MANTLE,   droprate =  350 },
        { itemid = xi.item.VARIABLE_CAPE,     droprate =  350 },
        { itemid = xi.item.PROTEAN_RING,      droprate =  350 },
        { itemid = xi.item.VARIABLE_RING,     droprate =  350 },
        { itemid = xi.item.MECURIAL_EARRING,  droprate =  350 },
    },
    [50] =
    {
        { itemid = xi.item.DRAGON_CHRONICLES, droprate = 1000 },
        { itemid = xi.item.UNDEAD_EARRING,    droprate =  350 },
        { itemid = xi.item.ARCANA_EARRING,    droprate =  350 },
        { itemid = xi.item.VERMIN_EARRING,    droprate =  350 },
        { itemid = xi.item.BIRD_EARRING,      droprate =  350 },
        { itemid = xi.item.AMORPH_EARRING,    droprate =  350 },
        { itemid = xi.item.LIZARD_EARRING,    droprate =  350 },
        { itemid = xi.item.AQUAN_EARRING,     droprate =  350 },
        { itemid = xi.item.PLANTOID_EARRING,  droprate =  350 },
        { itemid = xi.item.BEAST_EARRING,     droprate =  350 },
        { itemid = xi.item.DEMON_EARRING,     droprate =  350 },
        { itemid = xi.item.DRAGON_EARRING,    droprate =  350 },
        { itemid = xi.item.REFRESH_EARRING,   droprate =  350 },
        { itemid = xi.item.ACCURATE_EARRING,  droprate =  350 },
    },
    [99] =
    {
        { itemid = xi.item.MIRATETES_MEMOIRS, droprate = 1000 },
        { itemid = xi.item.MIGHTY_BOW,        droprate =  350 },
        { itemid = xi.item.MIGHTY_CUDGEL,     droprate =  350 },
        { itemid = xi.item.MIGHTY_POLE,       droprate =  350 },
        { itemid = xi.item.MIGHTY_TALWAR,     droprate =  350 },
        { itemid = xi.item.RAI_KUNIMITSU,     droprate =  350 },
        { itemid = xi.item.NUKEMARU,          droprate =  350 },
        { itemid = xi.item.MIGHTY_PICK,       droprate =  350 },
        { itemid = xi.item.MIGHTY_KNIFE,      droprate =  350 },
        { itemid = xi.item.MIGHTY_ZAGHNAL,    droprate =  350 },
        { itemid = xi.item.MIGHTY_LANCE,      droprate =  350 },
        { itemid = xi.item.MIGHTY_AXE,        droprate =  350 },
        { itemid = xi.item.MIGHTY_PATAS,      droprate =  350 },
        { itemid = xi.item.MIGHTY_SWORD,      droprate =  350 },
    },
}

xi.garrison.waves =
{
    -- Each wave consists of different 'mini waves' or spawn groups,
    -- which are separated from each other by a certain interval of time.
    --
    -- Flow:
    -- * After all groups in a wave are killed, the wave ends.
    -- * After delayBetweenGroups, the next wave begins.
    -- * When all groups in the last wave have been killed, boss spawns after delayBetweenGroups.
    --
    -- Constraints: A wave can only spawn 8 mobs at a time at most. This is due to the assumption
    -- That the boss is always 8 IDs after the mobs spawning in each wave.
    spawnSchedule =
    {
        -- 1 Party
        [1] =
        {
            -- Wave 1
            -- 2 Mobs at once
            [1] =
            {
                2
            },
            -- Wave 2
            -- 2 Mobs every `delayBetweenGroups`
            -- 4 total
            [2] =
            {
                2,
                2
            },
            -- Wave 3
            -- 2 Mobs every `delayBetweenGroups`
            -- 6 total
            [3] =
            {
                2,
                2,
                2
            },
            -- Wave 4
            -- 2 Mobs every `delayBetweenGroups`
            -- 8 total
            -- Boss spawns after all 8 are killed
            [4] =
            {
                2,
                2,
                2,
                2
            }
        },
        -- 2 Parties
        [2] =
        {
            -- Wave 1
            -- 4 Mobs at once
            [1] =
            {
                4
            },
            -- Wave 2
            -- 4 Mobs
            -- 2 Mobs after `delayBetweenGroups`
            [2] =
            {
                4,
                2
            },
            -- Wave 3
            -- 4 Mobs
            -- 2 Mobs after `delayBetweenGroups`
            -- 2 Mobs after 2 * `delayBetweenGroups`
            [3] =
            {
                4,
                2,
                2
            },
            -- Wave 4
            -- 4 Mobs
            -- 2 Mobs after `delayBetweenGroups`
            -- 2 Mobs after 2 * `delayBetweenGroups`
            -- Boss after all 8 mobs are killed
            [4] =
            {
                4,
                2,
                2,
            }
        },
        -- 3 Parties
        -- Only 3 waves with 3 parties.
        -- I don't understand the thinking behind this, but this matches the two videos
        -- I found showing garrison gameplay with 3 parties.
        [3] =
        {
            -- Wave 1
            -- 4 Mobs at once
            [1] =
            {
                4,
                2
            },
            -- Wave 2
            -- 6 Mobs
            -- 2 Mobs after `delayBetweenGroups`
            [2] =
            {
                6,
                2
            },
            -- Wave 3
            -- 4 Mobs
            -- 2 Mobs after `delayBetweenGroups`
            -- 2 Mobs after 2 * `delayBetweenGroups`
            -- Boss after all 8 mobs are killed
            [3] =
            {
                4,
                2,
                2
            },
        },
    },
    -- How many seconds before each group spawns
    delayBetweenGroups = 15,
}

--Zone Data
xi.garrison.zoneData =
{
    [xi.zone.WEST_RONFAURE] =
    {
        itemReq     = xi.item.RED_CRYPTEX,
        textRegion  = 0,
        levelCap    = 20,
        mobBoss     = "Orcish_Fighterchief",
        pos         = { -438, -20, -223, 0 },
        xChange     = 0,
        zChange     = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine  = 4,
        zThirdLine  = 0,
    },
    [xi.zone.NORTH_GUSTABERG] =
    {
        itemReq     = xi.item.DARKSTEEL_ENGRAVING,
        textRegion  = 1,
        levelCap    = 20,
        mobBoss     = "Lead_Quadav",
        pos         = { -575, 40, 63, 0 },
        xChange     = 1,
        zChange     = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine  = 4,
        zThirdLine  = 0,
    },
    [xi.zone.WEST_SARUTABARUTA] =
    {
        itemReq     = xi.item.SEVEN_KNOT_QUIPU,
        textRegion  = 2,
        levelCap    = 20,
        mobBoss     = "Yagudo_Condottiere",
        pos         = { -21, -12, 327, 128 },
        xChange     = 0,
        zChange     = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine  = 4,
        zThirdLine  = 0,
    },
    [xi.zone.VALKURM_DUNES] =
    {
        itemReq     = xi.item.GALKA_FANG_SACK,
        textRegion  = 3,
        levelCap    = 30,
        mobBoss     = "Goblin_Swindler",
        pos         = { 149, -8, 94, 32 },
        xChange     = -2,
        zChange     = -2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine  = 4,
        zThirdLine  = 0,
    },
    [xi.zone.JUGNER_FOREST] =
    {
        itemReq     = xi.item.JADE_CRYPTEX,
        textRegion  = 4,
        levelCap    = 30,
        mobBoss     = "Orcish_Colonel",
        pos         = nil, -- Needs capture
        xChange     = -2,
        zChange     = 0,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine  = 0,
        zThirdLine  = 4,
    },
    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        itemReq     = xi.item.SILVER_ENGRAVING,
        textRegion  = 5,
        levelCap    = 30,
        mobBoss     = "Cobalt_Quadav",
        pos         = nil, -- Needs capture
        xChange     = -2,
        zChange     = -2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine  = 4,
        zThirdLine  = 0,
    },
    [xi.zone.BUBURIMU_PENINSULA] =
    {
        itemReq     = xi.item.MITHRA_FANG_SACK,
        textRegion  = 6,
        levelCap    = 30,
        mobBoss     = "Goblin_Guide",
        pos         = nil, -- Needs capture
        xChange     = -2,
        zChange     = 0,
        xSecondLine = 0,
        zSecondLine = -2,
        xThirdLine  = 0,
        zThirdLine  = -4,
    },
    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        itemReq     = xi.item.THIRTEEN_KNOT_QUIPU,
        textRegion  = 7,
        levelCap    = 30,
        mobBoss     = "Yagudo_Missionary",
        pos         = nil, -- Needs capture
        xChange     = 2,
        zChange     = -2,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine  = 0,
        zThirdLine  = 4,
    },
    [xi.zone.QUFIM_ISLAND] =
    {
        itemReq     = xi.item.RAM_LEATHER_MISSIVE,
        textRegion  = 10,
        levelCap    = 30,
        mobBoss     = "Hunting_Chief",
        pos         = nil, -- Needs capture
        xChange     = -2,
        zChange     = 0,
        xSecondLine = 0,
        zSecondLine = -2,
        xThirdLine  = 0,
        zThirdLine  = -4,
    },
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        itemReq     = xi.item.TIGER_LEATHER_MISSIVE,
        textRegion  = 8,
        levelCap    = 40,
        mobBoss     = "Gigas_Overseer",
        pos         = nil, -- Needs capture
        xChange     = -2,
        zChange     = -1,
        xSecondLine = 0,
        zSecondLine = -1,
        xThirdLine  = 0,
        zThirdLine  = -2,
    },
    [xi.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        itemReq     = xi.item.HOUND_FANG_SACK,
        textRegion  = 11,
        levelCap    = 40,
        mobBoss     = "Goblin_Doyen",
        pos         = { -43, 1, -140, 180 },
        xChange     = -2,
        zChange     = 0,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine  = 0,
        zThirdLine  = 4,
    },
    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        itemReq     = xi.item.SHEEP_LEATHER_MISSIVE,
        textRegion  = 14,
        levelCap    = 40,
        mobBoss     = "Sahagin_Patriarch",
        pos         = { -248, 1, -392, 180 },
        xChange     = -2,
        zChange     = 0,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine  = 0,
        zThirdLine  = 4,
    },
    [xi.zone.XARCABARD] =
    {
        itemReq     = xi.item.BEHEMOTH_LEATHER_MISSIVE,
        textRegion  = 9,
        levelCap    = 50,
        mobBoss     = "Demon_Aristocrat",
        pos         = nil, -- Needs capture
        xChange     = 2,
        zChange     = 0,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine  = 0,
        zThirdLine  = 4,
    },
    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {
        itemReq = xi.item.DHALMEL_LEATHER_MISSIVE,
        textRegion  = 12,
        levelCap    = 50,
        mobBoss     = "Centurio_XIII-V",
        pos         = { -245, -9, -249, 0 },
        xChange     = 0,
        zChange     = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine  = 4,
        zThirdLine  = 0,
    },
    [xi.zone.YHOATOR_JUNGLE] =
    {
        itemReq     = xi.item.COEURL_LEATHER_MISSIVE,
        textRegion  = 15,
        levelCap    = 50,
        mobBoss     = "Tonberry_Decimator",
        pos         = { 214, 1, -80, 0 },
        xChange     = 1,
        zChange     = 2,
        xSecondLine = 2,
        zSecondLine = -1,
        xThirdLine  = 4,
        zThirdLine  = -2,
    },
    [xi.zone.CAPE_TERIGGAN] =
    {
        itemReq     = xi.item.BUNNY_FANG_SACK,
        textRegion  = 13,
        levelCap    = 99,
        mobBoss     = "Goblin_Boss",
        pos         = { -174, 8, -61, 0 },
        xChange     = 0,
        zChange     = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine  = 4,
        zThirdLine  = 0,
    },
}
