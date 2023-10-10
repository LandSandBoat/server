-----------------------------------
-- Garrison Data
-----------------------------------
xi = xi or {}
xi.garrison = xi.garrison or {}

-- Garrison Progression
xi.garrison.state =
{
    SPAWN_NPCS          = 0,
    BATTLE              = 1,
    SPAWN_MOBS          = 2,
    SPAWN_BOSS          = 3,
    ADVANCE_WAVE        = 4,
    GRANT_LOOT          = 5,
    ENDED               = 6,
}

-- Name is Determined by Nation and LevelCap (sandoria, bastok, windurst)
xi.garrison.allyNames =
{
    [20] = { [xi.nation.SANDORIA] = 'Patrician',       [xi.nation.BASTOK] = 'Recruit',         [xi.nation.WINDURST] = 'Candidate'       },
    [30] = { [xi.nation.SANDORIA] = 'Trader',          [xi.nation.BASTOK] = 'Mariner',         [xi.nation.WINDURST] = 'Scholar'         },
    [40] = { [xi.nation.SANDORIA] = 'TempleKnight',    [xi.nation.BASTOK] = 'GoldMusketeer',   [xi.nation.WINDURST] = 'WiseWizard'      },
    [50] = { [xi.nation.SANDORIA] = 'RoyalGuard',      [xi.nation.BASTOK] = 'Commander',       [xi.nation.WINDURST] = 'Patriarch'       },
    [99] = { [xi.nation.SANDORIA] = 'MilitaryAttache', [xi.nation.BASTOK] = 'MilitaryAttache', [xi.nation.WINDURST] = 'MilitaryAttache' },
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
            '0x01000C030010262000303A403A5008611B700000',
            '0x01000A040010262019303A40195008611C700000',
        },

        [xi.nation.BASTOK] =
        {
            -- These commented out entries appear to be missing body and leg pieces
            -- '0x010001017D000000150015001500B70000000000',
            -- '0x010006020F0000000F000F000F00820082000000',
            '0x01000E02000066000100010001009F0000000000',
            '0x01000701361005206630664066500C6129700000',
            '0x0100020103000300000000000000DC0000000000',
            '0x01000402740014000000000003002C0100000000',
        },

        [xi.nation.WINDURST] =
        {
            '0x010007070110322032300E401550AC6000700000',
            '0x01000E0718101820183015401850B76024700000',
            '0x01000F0514106920693069406950656028700000',
        },
    },
    [30] =
    {
        [xi.nation.SANDORIA] =
        {
            '0x010006030010762076303A400650736000700000',
            '0x01000F0300101520153015401550006000700000',
            '0x010009040010762076303A400650736000700000',
            '0x01000E0400101520003015401550006000700000',
        },

        [xi.nation.BASTOK] =
        {
            '0x0100040873100020003000400050006000700000',
            '0x01000B0841100F200F300F400F50D86000700000',
            '0x01000F0120100F2000300F407A50AC6000700000',
        },

        [xi.nation.WINDURST] =
        {
            '0x01000B051C1073201430144014506C6000700000',
            '0x0100010777106920693066406950B46000700000',
            '0x010000067D107820033066406850E96000700000',
            '0x01000605731069201F3008407350E86000700000',
        },
    },
    [40] =
    {
        [xi.nation.SANDORIA] =
        {
            '0x01000E04191019201930194019506B601C700000',
            '0x01000903191019201930194019506B601C700000',
        },

        [xi.nation.BASTOK] =
        {
            '0x0100020260102420603060406050B56000700000',
            '0x010008083D1024203D3010401050756075700000',
            '0x01000008371024203730374037506F6018700000',
            '0x0100040105102420053005400550BB6000700000',
        },

        [xi.nation.WINDURST] =
        {
            '0x0100050700104A20003000400650396127700000',
            '0x01000D0634106D206D306D406D501A6123700000',
        },
    },
    [50] =
    {
        [xi.nation.SANDORIA] =
        {
            '0x010008037210722072301C401C50616000700000',
            '0x01000E03421025204230394042508F608F700000',
            '0x010004047910672042300E404250896089700000',
            '0x01000304401022204030404040504A6000700000',
        },

        [xi.nation.BASTOK] =
        {
            '0x01000C0133106420433064404350866086700000',
            '0x0100010216104120413041404150CA6000700000',
        },

        [xi.nation.WINDURST] =
        {
            '0x0100020600106320633063406350056122700000',
            '0x010004067C102D20193019401950506100700000',
            '0x0100080669106B206B306B406B50FE6000700000',
        },
    },
    [99] =
    {
        [xi.nation.SANDORIA] =
        {
            '0x010005011D1071201D301D401D50206130700000',
            '0x0100020841107120413041404150036130700000',
        },

        [xi.nation.BASTOK] =
        {
            '0x010002071C1070201C301C401C50C46000700000',
        },

        [xi.nation.WINDURST] =
        {
            '0x010009043E106F203E303E403E501C611B700000',
            '0x0100020349106F204930494049501F611B700000',
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
            [1] = { 2 },         -- Wave 1: 2 Mobs.
            [2] = { 2, 2 },      -- Wave 2: 2 Mobs + 2 Mobs after 'delayBetweenGroups'. 4 total.
            [3] = { 2, 2, 2 },   -- Wave 3: 2 Mobs + 2 Mobs after every 'delayBetweenGroups'. 6 total.
            [4] = { 2, 2, 2, 2 } -- Wave 4: 2 Mobs + 2 Mobs after every 'delayBetweenGroups'. 8 total. Boss after all 8.
        },

        -- 2 Parties
        [2] =
        {
            [1] = { 4 },       -- Wave 1: 4 Mobs.
            [2] = { 4, 2 },    -- Wave 2: 4 Mobs + 2 Mobs after every 'delayBetweenGroups'. 6 total.
            [3] = { 4, 2, 2 }, -- Wave 3: 4 Mobs + 2 Mobs after every 'delayBetweenGroups'. 8 total.
            [4] = { 4, 2, 2 }, -- Wave 4: 4 Mobs + 2 Mobs after every 'delayBetweenGroups'. 8 total. Boss after all 8.
        },

        -- 3 Parties
        [3] =
        {
            [1] = { 4, 2 },    -- Wave 1: 4 Mobs + 2 Mobs after 'delayBetweenGroups'. 6 total.
            [2] = { 6, 2 },    -- Wave 2: 6 Mobs + 2 Mobs after 'delayBetweenGroups'. 8 total.
            [3] = { 4, 2, 2 }, -- Wave 3: 4 Mobs + 2 Mobs after every 'delayBetweenGroups'. 8 total. Boss after all 8.
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
        mobBoss     = 'Orcish_Fighterchief',
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
        mobBoss     = 'Lead_Quadav',
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
        mobBoss     = 'Yagudo_Condottiere',
        pos         = { -19.000, -13.312, 323.000, 128 },
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
        mobBoss     = 'Goblin_Swindler',
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
        mobBoss     = 'Orcish_Colonel',
        pos         = { 60.000, 0.499, -1.000, 192 },
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
        mobBoss     = 'Cobalt_Quadav',
        pos         = { 462.000, 23.528, 420.000, 160 },
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
        mobBoss     = 'Goblin_Guide',
        pos         = { -484, -30, 60, 64 },
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
        mobBoss     = 'Yagudo_Missionary',
        pos         = { -293.000, 16.924, 412.000, 96 },
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
        mobBoss     = 'Hunting_Chief',
        pos         = { -251.000, -20.399, 304.000, 64 },
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
        mobBoss     = 'Gigas_Overseer',
        pos         = { -22.000, -59.900, -112.000, 128 },
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
        mobBoss     = 'Goblin_Doyen',
        pos         = { -40.000, 0.299, -136.000, 192 },
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
        mobBoss     = 'Sahagin_Patriarch',
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
        mobBoss     = 'Demon_Aristocrat',
        pos         = { 219, -21, -208, 64 },
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
        mobBoss     = 'Centurio_XIII-V',
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
        mobBoss     = 'Tonberry_Decimator',
        pos         = { 210.000, -0.049, -85.000, 32 },
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
        mobBoss     = 'Goblin_Boss',
        pos         = { -174, 8, -61, 0 },
        xChange     = 0,
        zChange     = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine  = 4,
        zThirdLine  = 0,
    },
}
