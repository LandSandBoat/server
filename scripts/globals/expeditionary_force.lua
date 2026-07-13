-----------------------------------
-- Expeditionary Force
-----------------------------------
xi = xi or {}
xi.expeditionaryForce = xi.expeditionaryForce or {}

-----------------------------------
-- Enums
-----------------------------------
local bannerState =
{
    IDLE    = 0,
    ACTIVE  = 1,
    CLEARED = 2,
    HIDDEN  = 3,
}

-----------------------------------
-- Tables
-----------------------------------

local zoneInfoTable =
{
    [xi.zone.BEAUCEDINE_GLACIER    ] = { levelCap = 40 },
    [xi.zone.BUBURIMU_PENINSULA    ] = { levelCap = 30 },
    [xi.zone.CAPE_TERIGGAN         ] = { levelCap = xi.settings.main.MAX_LEVEL },  -- Uncapped
    [xi.zone.EASTERN_ALTEPA_DESERT ] = { levelCap = 50 },
    [xi.zone.JUGNER_FOREST         ] = { levelCap = 30 },
    [xi.zone.MERIPHATAUD_MOUNTAINS ] = { levelCap = 30 },
    [xi.zone.PASHHOW_MARSHLANDS    ] = { levelCap = 30 },
    [xi.zone.QUFIM_ISLAND          ] = { levelCap = 30 },
    [xi.zone.THE_SANCTUARY_OF_ZITAH] = { levelCap = 40 },
    [xi.zone.VALKURM_DUNES         ] = { levelCap = 30 },
    [xi.zone.XARCABARD             ] = { levelCap = 50 },
    [xi.zone.YHOATOR_JUNGLE        ] = { levelCap = 50 },
    [xi.zone.YUHTUNGA_JUNGLE       ] = { levelCap = 40 },
}

local bannerTable =
{
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        -- position = { x, y, z, rot }
        [1] = { position = {  193.614,  -0.307, -35.663, 255 } }, -- I-8, Gigas
        [2] = { position = {   20.169, -80.061, 180.063, 224 } }, -- H-7, Gigas
        [3] = { position = { -326.264, -99.694, 140.523, 220 } }, -- F-7, Gigas
        [4] = { position = {  255.402,   0.072, 382.940, 110 } }, -- J-6, Hobgoblin
        [5] = { position = { -173.299, -81.847, 150.200, 246 } }, -- G-7, Hobgoblin
    },

    [xi.zone.BUBURIMU_PENINSULA] =
    {
        [1] = { position = {  101.491, -23.090,  199.798, 218 } }, -- Hobgoblin
        [2] = { position = {  527.885,   0.486,  -40.241, 157 } }, -- Hobgoblin
        [3] = { position = {  315.895,  -0.025,  361.453,  17 } }, -- Theoyagudo
        [4] = { position = { -132.589,  20.000, -314.261, 230 } }, -- Theoyagudo
        [5] = { position = { -446.510,  -8.799, -282.799, 240 } }, -- Theoyagudo
    },

    [xi.zone.CAPE_TERIGGAN] =
    {
        [1] = { position = {  126.583, -0.194, -117.367,  75 } }, -- I-9, Hobgoblin
        [2] = { position = { -213.169, -3.320,  254.085, 181 } }, -- G-6, Hobgoblin
        [3] = { position = {  251.977,  5.241,   50.698, 128 } }, -- J-8, Hobgoblin
        [4] = { position = {  -29.071, -9.694,  224.300,  46 } }, -- H-7, Hobgoblin
        [5] = { position = {  162.059, -0.740,  250.538, 139 } }, -- I-6, Hobgoblin
    },

    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {
        [1] = { position = {  -63.319, -10.629,  408.180,  77 } }, -- G-5,  Contantican
        [2] = { position = {  463.219, -10.608,  248.849, 212 } }, -- J-6,  Contantican
        [3] = { position = {  329.054,   6.684, -330.958, 201 } }, -- J-10, Contantican
        [4] = { position = { -332.218,  -1.203,  126.229,  60 } }, -- E-7,  Hobgoblin
        [5] = { position = {   27.934, -10.019,  398.640, 126 } }, -- H-6,  Hobgoblin
    },

    [xi.zone.JUGNER_FOREST] =
    {
        [1] = { position = {  279.408, -15.592, -547.181, 176 } }, -- J-11, Halforc
        [2] = { position = { -159.588,   0.647,  386.042,  17 } }, -- G-6,  Halforc
        [3] = { position = {    3.419, -16.000, -642.232,   7 } }, -- H-12, Halforc
        [4] = { position = {  448.240,   0.212, -157.228, 225 } }, -- K-9,  Hobgoblin
        [5] = { position = {  600.809,   0.873,  217.453, 130 } }, -- L-7,  Hobgoblin
    },

    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        [1] = { position = {  199.396,  -0.723, -527.072, 169 } }, -- H-11, Hobgoblin
        [2] = { position = {  342.918,  -1.109,  529.219, 226 } }, -- I-5,  Hobgoblin
        [3] = { position = {  592.850, -16.741, -518.802, 227 } }, -- K-11, Theoyagudo
        [4] = { position = { -536.930,   4.317,  338.845, 200 } }, -- D-6,  Theoyagudo
        [5] = { position = { -559.025, -16.761,   47.233,  72 } }, -- D-8,  Theoyagudo
    },

    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        [1] = { position = { -172.764, 25.125,   93.640, 154 } }, -- G-8,  Hobgoblin
        [2] = { position = {  261.910, 24.213,  211.070,  85 } }, -- J-7,  Hobgoblin
        [3] = { position = {  140.080, 23.971, -411.951, 112 } }, -- I-11, Metaquadav
        [4] = { position = { -447.851, 24.305, -219.899, 113 } }, -- E-10, Metaquadav
        [5] = { position = { -460.959, 24.203,  469.851, 223 } }, -- E-5,  Metaquadav
    },

    [xi.zone.QUFIM_ISLAND] =
    {
        [1] = { position = {    0.348, -20.126,  73.479, 202 } }, -- H-8, Giant
        [2] = { position = {  -72.247, -20.055, 353.529, 140 } }, -- H-6, Giant
        [3] = { position = {  -67.440, -18.291, -68.641, 186 } }, -- H-8, Giant
        [4] = { position = {   93.082, -21.458, -67.584,   1 } }, -- I-8, Hobgoblin
        [5] = { position = { -339.785, -19.984,  33.289, 171 } }, -- F-8, Hobgoblin
    },

    [xi.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        [1] = { position = {  643.619,  0.842, -176.843, 128 } }, -- L-10, Hobgoblin
        [2] = { position = {  174.336, -1.015, -413.606,  59 } }, -- I-11, Hobgoblin
        [3] = { position = { -512.058, -0.975,  253.275,  37 } }, -- E-7,  Hobgoblin
        [4] = { position = {  429.298,  0.084, -604.489, 231 } }, -- J-12, Hobgoblin
        [5] = { position = { -399.822,  0.162, -168.998, 174 } }, -- E-10, Hobgoblin
    },

    [xi.zone.VALKURM_DUNES] =
    {
        [1] = { position = { -522.404,  -8.175,  113.667, 141 } }, --      Halforc
        [2] = { position = {  643.175,  -0.592,    8.854,  10 } }, --      Halforc
        [3] = { position = {  478.713, -16.140,  365.873,  28 } }, -- J-6, Hobgoblin
        [4] = { position = { -352.679,  -8.856,  327.661,  18 } }, --      Metaquadav
        [5] = { position = { -116.204,   4.000, -113.608, 160 } }, --      Metaquadav
    },

    [xi.zone.XARCABARD] =
    {
        [1] = { position = {   32.788, -24.162, -205.200,   6 } }, -- G-9, Gigas
        [2] = { position = { -160.590, -24.169,  -87.061, 174 } }, -- F-8, Gigas
        [3] = { position = {  153.000, -36.438,   23.500,  16 } }, -- H-7, Gigas
        [4] = { position = {   47.461, -36.500,   66.281, 201 } }, -- G-7, Hobgoblin
        [5] = { position = {  320.399,  -8.190,  167.796,  52 } }, -- I-6, Hobgoblin
    },

    [xi.zone.YHOATOR_JUNGLE] =
    {
        [1] = { position = {  -54.134,  0.344, -405.397, 199 } }, -- H-10, Hobgoblin
        [2] = { position = { -196.704,  0.000, -149.953,  75 } }, -- G-9,  Hobgoblin
        [3] = { position = { -289.835,  0.000, -357.025,   5 } }, -- F-10, Noctonberry
        [4] = { position = {  366.014, -0.176, -394.801,  96 } }, -- J-10, Noctonberry
        [5] = { position = { -176.760,  0.162,   26.774,  40 } }, -- G-8,  Noctonberry
    },

    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        [1] = { position = {  -63.927, -0.042, -126.052, 153 } }, -- H-9,  Demisahagin
        [2] = { position = {  102.301,  0.600,  442.978,  17 } }, -- I-6,  Demisahagin
        [3] = { position = { -305.061, 16.186, -438.904, 132 } }, -- G-11, Demisahagin
        [4] = { position = {  381.229,  3.908,  148.721, 115 } }, -- K-8,  Hobgoblin
        [5] = { position = { -647.367,  0.000,   42.053,  28 } }, -- E-8,  Hobgoblin
    },
}

local bannerNMs =
{
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        [1] =
        {
            zones[xi.zone.BEAUCEDINE_GLACIER].mob.GIGAS_BEASTMASTER, zones[xi.zone.BEAUCEDINE_GLACIER].mob.GIGAS_MONK,
            zones[xi.zone.BEAUCEDINE_GLACIER].mob.GIGAS_RANGER,      zones[xi.zone.BEAUCEDINE_GLACIER].mob.GIGAS_WARRIOR,
        },

        [2] =
        {
            zones[xi.zone.BEAUCEDINE_GLACIER].mob.GIGAS_BEASTMASTER, zones[xi.zone.BEAUCEDINE_GLACIER].mob.GIGAS_MONK,
            zones[xi.zone.BEAUCEDINE_GLACIER].mob.GIGAS_RANGER,      zones[xi.zone.BEAUCEDINE_GLACIER].mob.GIGAS_WARRIOR,
        },

        [3] =
        {
            zones[xi.zone.BEAUCEDINE_GLACIER].mob.GIGAS_BEASTMASTER, zones[xi.zone.BEAUCEDINE_GLACIER].mob.GIGAS_MONK,
            zones[xi.zone.BEAUCEDINE_GLACIER].mob.GIGAS_RANGER,      zones[xi.zone.BEAUCEDINE_GLACIER].mob.GIGAS_WARRIOR,
        },

        [4] =
        {
            zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [5] =
        {
            zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.BEAUCEDINE_GLACIER].mob.HOBGOBLIN_WHITE_MAGE,
        },
    },

    [xi.zone.BUBURIMU_PENINSULA] =
    {
        [1] =
        {
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [2] =
        {
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [3] =
        {
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_BARD,       zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_BLACK_MAGE,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_MONK,       zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_NINJA,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_SAMURAI,    zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_SUMMONER,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_WHITE_MAGE,
        },

        [4] =
        {
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_BARD,       zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_BLACK_MAGE,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_MONK,       zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_NINJA,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_SAMURAI,    zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_SUMMONER,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_WHITE_MAGE,
        },

        [5] =
        {
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_BARD,       zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_BLACK_MAGE,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_MONK,       zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_NINJA,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_SAMURAI,    zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_SUMMONER,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_WHITE_MAGE,
        },
    },

    [xi.zone.CAPE_TERIGGAN] =
    {
        [1] =
        {
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [2] =
        {
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [3] =
        {
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [4] =
        {
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [5] =
        {
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.CAPE_TERIGGAN].mob.HOBGOBLIN_WHITE_MAGE,
        },
    },

    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {
        [1] =
        {
            zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.CONTANTICAN_BLACK_MAGE, zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.CONTANTICAN_PALADIN,
            zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.CONTANTICAN_RANGER,     zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.CONTANTICAN_WARRIOR,
        },

        [2] =
        {
            zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.CONTANTICAN_BLACK_MAGE, zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.CONTANTICAN_PALADIN,
            zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.CONTANTICAN_RANGER,     zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.CONTANTICAN_WARRIOR,
        },

        [3] =
        {
            zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.CONTANTICAN_BLACK_MAGE, zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.CONTANTICAN_PALADIN,
            zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.CONTANTICAN_RANGER,     zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.CONTANTICAN_WARRIOR,
        },

        [4] =
        {
            zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [5] =
        {
            zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.HOBGOBLIN_WHITE_MAGE,
        },
    },

    [xi.zone.JUGNER_FOREST] =
    {
        [1] =
        {
            zones[xi.zone.JUGNER_FOREST].mob.HALFORC_BLACK_MAGE, zones[xi.zone.JUGNER_FOREST].mob.HALFORC_DARK_KNIGHT,
            zones[xi.zone.JUGNER_FOREST].mob.HALFORC_DRAGOON,    zones[xi.zone.JUGNER_FOREST].mob.HALFORC_MONK,
            zones[xi.zone.JUGNER_FOREST].mob.HALFORC_PALADIN,    zones[xi.zone.JUGNER_FOREST].mob.HALFORC_RANGER,
            zones[xi.zone.JUGNER_FOREST].mob.HALFORC_WARRIOR,
        },

        [2] =
        {
            zones[xi.zone.JUGNER_FOREST].mob.HALFORC_BLACK_MAGE, zones[xi.zone.JUGNER_FOREST].mob.HALFORC_DARK_KNIGHT,
            zones[xi.zone.JUGNER_FOREST].mob.HALFORC_DRAGOON,    zones[xi.zone.JUGNER_FOREST].mob.HALFORC_MONK,
            zones[xi.zone.JUGNER_FOREST].mob.HALFORC_PALADIN,    zones[xi.zone.JUGNER_FOREST].mob.HALFORC_RANGER,
            zones[xi.zone.JUGNER_FOREST].mob.HALFORC_WARRIOR,
        },

        [3] =
        {
            zones[xi.zone.JUGNER_FOREST].mob.HALFORC_BLACK_MAGE, zones[xi.zone.JUGNER_FOREST].mob.HALFORC_DARK_KNIGHT,
            zones[xi.zone.JUGNER_FOREST].mob.HALFORC_DRAGOON,    zones[xi.zone.JUGNER_FOREST].mob.HALFORC_MONK,
            zones[xi.zone.JUGNER_FOREST].mob.HALFORC_PALADIN,    zones[xi.zone.JUGNER_FOREST].mob.HALFORC_RANGER,
            zones[xi.zone.JUGNER_FOREST].mob.HALFORC_WARRIOR,
        },

        [4] =
        {
            zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [5] =
        {
            zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.JUGNER_FOREST].mob.HOBGOBLIN_WHITE_MAGE,
        },
    },

    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        [1] =
        {
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [2] =
        {
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [3] =
        {
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_BARD,       zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_BLACK_MAGE,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_MONK,       zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_NINJA,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_SAMURAI,    zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_SUMMONER,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_WHITE_MAGE,
        },

        [4] =
        {
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_BARD,       zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_BLACK_MAGE,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_MONK,       zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_NINJA,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_SAMURAI,    zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_SUMMONER,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_WHITE_MAGE,
        },

        [5] =
        {
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_BARD,       zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_BLACK_MAGE,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_MONK,       zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_NINJA,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_SAMURAI,    zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_SUMMONER,
            zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.THEOYAGUDO_WHITE_MAGE,
        },
    },

    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        [1] =
        {
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [2] =
        {
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.PASHHOW_MARSHLANDS].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [3] =
        {
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_BLACK_MAGE, zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_DARK_KNIGHT,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_PALADIN,    zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_RED_MAGE,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_THIEF,      zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_WARRIOR,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_WHITE_MAGE,
        },

        [4] =
        {
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_BLACK_MAGE, zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_DARK_KNIGHT,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_PALADIN,    zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_RED_MAGE,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_THIEF,      zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_WARRIOR,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_WHITE_MAGE,
        },

        [5] =
        {
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_BLACK_MAGE, zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_DARK_KNIGHT,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_PALADIN,    zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_RED_MAGE,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_THIEF,      zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_WARRIOR,
            zones[xi.zone.PASHHOW_MARSHLANDS].mob.METAQUADAV_WHITE_MAGE,
        },
    },

    [xi.zone.QUFIM_ISLAND] =
    {
        [1] =
        {
            zones[xi.zone.QUFIM_ISLAND].mob.GIANT_BEASTMASTER, zones[xi.zone.QUFIM_ISLAND].mob.GIANT_HIGH_RANGER,
            zones[xi.zone.QUFIM_ISLAND].mob.GIANT_MONK,        zones[xi.zone.QUFIM_ISLAND].mob.GIANT_WARRIOR,
        },

        [2] =
        {
            zones[xi.zone.QUFIM_ISLAND].mob.GIANT_BEASTMASTER, zones[xi.zone.QUFIM_ISLAND].mob.GIANT_HIGH_RANGER,
            zones[xi.zone.QUFIM_ISLAND].mob.GIANT_MONK,        zones[xi.zone.QUFIM_ISLAND].mob.GIANT_WARRIOR,
        },

        [3] =
        {
            zones[xi.zone.QUFIM_ISLAND].mob.GIANT_BEASTMASTER, zones[xi.zone.QUFIM_ISLAND].mob.GIANT_HIGH_RANGER,
            zones[xi.zone.QUFIM_ISLAND].mob.GIANT_MONK,        zones[xi.zone.QUFIM_ISLAND].mob.GIANT_WARRIOR,
        },

        [4] =
        {
            zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [5] =
        {
            zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.QUFIM_ISLAND].mob.HOBGOBLIN_WHITE_MAGE,
        },
    },

    [xi.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        [1] =
        {
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [2] =
        {
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [3] =
        {
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [4] =
        {
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [5] =
        {
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.HOBGOBLIN_WHITE_MAGE,
        },
    },

    [xi.zone.VALKURM_DUNES] =
    {
        [1] =
        {
            zones[xi.zone.VALKURM_DUNES].mob.HALFORC_BLACK_MAGE, zones[xi.zone.VALKURM_DUNES].mob.HALFORC_DARK_KNIGHT,
            zones[xi.zone.VALKURM_DUNES].mob.HALFORC_DRAGOON,    zones[xi.zone.VALKURM_DUNES].mob.HALFORC_MONK,
            zones[xi.zone.VALKURM_DUNES].mob.HALFORC_PALADIN,    zones[xi.zone.VALKURM_DUNES].mob.HALFORC_RANGER,
            zones[xi.zone.VALKURM_DUNES].mob.HALFORC_WARRIOR,
        },

        [2] =
        {
            zones[xi.zone.VALKURM_DUNES].mob.HALFORC_BLACK_MAGE, zones[xi.zone.VALKURM_DUNES].mob.HALFORC_DARK_KNIGHT,
            zones[xi.zone.VALKURM_DUNES].mob.HALFORC_DRAGOON,    zones[xi.zone.VALKURM_DUNES].mob.HALFORC_MONK,
            zones[xi.zone.VALKURM_DUNES].mob.HALFORC_PALADIN,    zones[xi.zone.VALKURM_DUNES].mob.HALFORC_RANGER,
            zones[xi.zone.VALKURM_DUNES].mob.HALFORC_WARRIOR,
        },

        [3] =
        {
            zones[xi.zone.VALKURM_DUNES].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.VALKURM_DUNES].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.VALKURM_DUNES].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.VALKURM_DUNES].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.VALKURM_DUNES].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.VALKURM_DUNES].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.VALKURM_DUNES].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.VALKURM_DUNES].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [4] =
        {
            zones[xi.zone.VALKURM_DUNES].mob.METAQUADAV_BLACK_MAGE, zones[xi.zone.VALKURM_DUNES].mob.METAQUADAV_DARK_KNIGHT,
            zones[xi.zone.VALKURM_DUNES].mob.METAQUADAV_PALADIN,    zones[xi.zone.VALKURM_DUNES].mob.METAQUADAV_RED_MAGE,
            zones[xi.zone.VALKURM_DUNES].mob.METAQUADAV_THIEF,      zones[xi.zone.VALKURM_DUNES].mob.METAQUADAV_WARRIOR,
            zones[xi.zone.VALKURM_DUNES].mob.METAQUADAV_WHITE_MAGE,
        },

        [5] =
        {
            zones[xi.zone.VALKURM_DUNES].mob.METAQUADAV_BLACK_MAGE, zones[xi.zone.VALKURM_DUNES].mob.METAQUADAV_DARK_KNIGHT,
            zones[xi.zone.VALKURM_DUNES].mob.METAQUADAV_PALADIN,    zones[xi.zone.VALKURM_DUNES].mob.METAQUADAV_RED_MAGE,
            zones[xi.zone.VALKURM_DUNES].mob.METAQUADAV_THIEF,      zones[xi.zone.VALKURM_DUNES].mob.METAQUADAV_WARRIOR,
            zones[xi.zone.VALKURM_DUNES].mob.METAQUADAV_WHITE_MAGE,
        },
    },

    [xi.zone.XARCABARD] =
    {
        [1] =
        {
            zones[xi.zone.XARCABARD].mob.GIGAS_BEASTMASTER, zones[xi.zone.XARCABARD].mob.GIGAS_MONK,
            zones[xi.zone.XARCABARD].mob.GIGAS_RANGER,      zones[xi.zone.XARCABARD].mob.GIGAS_WARRIOR,
        },

        [2] =
        {
            zones[xi.zone.XARCABARD].mob.GIGAS_BEASTMASTER, zones[xi.zone.XARCABARD].mob.GIGAS_MONK,
            zones[xi.zone.XARCABARD].mob.GIGAS_RANGER,      zones[xi.zone.XARCABARD].mob.GIGAS_WARRIOR,
        },

        [3] =
        {
            zones[xi.zone.XARCABARD].mob.GIGAS_BEASTMASTER, zones[xi.zone.XARCABARD].mob.GIGAS_MONK,
            zones[xi.zone.XARCABARD].mob.GIGAS_RANGER,      zones[xi.zone.XARCABARD].mob.GIGAS_WARRIOR,
        },

        [4] =
        {
            zones[xi.zone.XARCABARD].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.XARCABARD].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.XARCABARD].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.XARCABARD].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.XARCABARD].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.XARCABARD].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.XARCABARD].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.XARCABARD].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [5] =
        {
            zones[xi.zone.XARCABARD].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.XARCABARD].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.XARCABARD].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.XARCABARD].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.XARCABARD].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.XARCABARD].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.XARCABARD].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.XARCABARD].mob.HOBGOBLIN_WHITE_MAGE,
        },
    },

    [xi.zone.YHOATOR_JUNGLE] =
    {
        [1] =
        {
            zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [2] =
        {
            zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.YHOATOR_JUNGLE].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [3] =
        {
            zones[xi.zone.YHOATOR_JUNGLE].mob.NOCTONBERRY_BLACK_MAGE, zones[xi.zone.YHOATOR_JUNGLE].mob.NOCTONBERRY_NINJA,
            zones[xi.zone.YHOATOR_JUNGLE].mob.NOCTONBERRY_SUMMONER,   zones[xi.zone.YHOATOR_JUNGLE].mob.NOCTONBERRY_THIEF,
        },

        [4] =
        {
            zones[xi.zone.YHOATOR_JUNGLE].mob.NOCTONBERRY_BLACK_MAGE, zones[xi.zone.YHOATOR_JUNGLE].mob.NOCTONBERRY_NINJA,
            zones[xi.zone.YHOATOR_JUNGLE].mob.NOCTONBERRY_SUMMONER,   zones[xi.zone.YHOATOR_JUNGLE].mob.NOCTONBERRY_THIEF,
        },

        [5] =
        {
            zones[xi.zone.YHOATOR_JUNGLE].mob.NOCTONBERRY_BLACK_MAGE, zones[xi.zone.YHOATOR_JUNGLE].mob.NOCTONBERRY_NINJA,
            zones[xi.zone.YHOATOR_JUNGLE].mob.NOCTONBERRY_SUMMONER,   zones[xi.zone.YHOATOR_JUNGLE].mob.NOCTONBERRY_THIEF,
        },
    },

    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        [1] =
        {
            zones[xi.zone.YUHTUNGA_JUNGLE].mob.DEMISAHAGIN_BARD, zones[xi.zone.YUHTUNGA_JUNGLE].mob.DEMISAHAGIN_DRAGOON,
            zones[xi.zone.YUHTUNGA_JUNGLE].mob.DEMISAHAGIN_MONK, zones[xi.zone.YUHTUNGA_JUNGLE].mob.DEMISAHAGIN_WHITE_MAGE,
        },

        [2] =
        {
            zones[xi.zone.YUHTUNGA_JUNGLE].mob.DEMISAHAGIN_BARD, zones[xi.zone.YUHTUNGA_JUNGLE].mob.DEMISAHAGIN_DRAGOON,
            zones[xi.zone.YUHTUNGA_JUNGLE].mob.DEMISAHAGIN_MONK, zones[xi.zone.YUHTUNGA_JUNGLE].mob.DEMISAHAGIN_WHITE_MAGE,
        },

        [3] =
        {
            zones[xi.zone.YUHTUNGA_JUNGLE].mob.DEMISAHAGIN_BARD, zones[xi.zone.YUHTUNGA_JUNGLE].mob.DEMISAHAGIN_DRAGOON,
            zones[xi.zone.YUHTUNGA_JUNGLE].mob.DEMISAHAGIN_MONK, zones[xi.zone.YUHTUNGA_JUNGLE].mob.DEMISAHAGIN_WHITE_MAGE,
        },

        [4] =
        {
            zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [5] =
        {
            zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_BEASTMASTER, zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_DARK_KNIGHT, zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_RED_MAGE,    zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_WARRIOR,     zones[xi.zone.YUHTUNGA_JUNGLE].mob.HOBGOBLIN_WHITE_MAGE,
        },
    },
}

local regionKITable =
{
    [xi.region.ARAGONEU        ] = xi.ki.ARAGONEU_EF_INSIGNIA,
    [xi.region.DERFLAND        ] = xi.ki.DERFLAND_EF_INSIGNIA,
    [xi.region.ELSHIMO_LOWLANDS] = xi.ki.ELSHIMO_LOWLANDS_EF_INSIGNIA,
    [xi.region.ELSHIMO_UPLANDS ] = xi.ki.ELSHIMO_UPLANDS_EF_INSIGNIA,
    [xi.region.FAUREGANDI      ] = xi.ki.FAUREGANDI_EF_INSIGNIA,
    [xi.region.KOLSHUSHU       ] = xi.ki.KOLSHUSHU_EF_INSIGNIA,
    [xi.region.KUZOTZ          ] = xi.ki.KUZOTZ_EF_INSIGNIA,
    [xi.region.LITELOR         ] = xi.ki.LITELOR_EF_INSIGNIA,
    [xi.region.NORVALLEN       ] = xi.ki.NORVALLEN_EF_INSIGNIA,
    [xi.region.QUFIMISLAND     ] = xi.ki.QUFIM_EF_INSIGNIA,
    [xi.region.VALDEAUNIA      ] = xi.ki.VALDEAUNIA_EF_INSIGNIA,
    [xi.region.VOLLBOW         ] = xi.ki.VOLLBOW_EF_INSIGNIA,
    [xi.region.ZULKHEIM        ] = xi.ki.ZULKHEIM_EF_INSIGNIA,
}

-----------------------------------
-- Local functions
-----------------------------------

-- Spawn 4 NMs at the banner
local function spawnBattleNMs(player, banner)
    local zoneId      = banner:getZoneID()
    local levelCap    = zoneInfoTable[zoneId].levelCap
    local bannerIndex = banner:getLocalVar('BannerIndex')

    local candidates = utils.shuffle(bannerNMs[zoneId][bannerIndex])
    local bx, by, bz = unpack(bannerTable[zoneId][bannerIndex].position)

    for i = 1, 4 do
        local mob = GetMobByID(candidates[i])
        if not mob then
            break
        end

        -- Spawn is a normal distribution with a mean of 3.5 and standard deviation of 1.5.
        -- The spawn distance is also restricted to [2.0, 7.5]. This is based on 234 samples.
        local distance = math.randomNormal(3.5, 1.5, 2.0, 7.5)

        -- Scatter around the banner in random direction.
        local angle = math.randomFloat(0, 1) * 2 * math.pi              -- 0 to 360 degrees
        local pos   = GetFurthestValidPosition(banner, distance, angle) -- Drops mob on valid ground and snaps closer if terrain blocks the distance.

        if pos then
            mob:setSpawn(pos.x, pos.y, pos.z, 0)

        -- Account for weird situation where the GetFurthestValidPosition can't find any position due to navmesh
        else
            mob:setSpawn(bx, by, bz, 0)
        end

        mob:spawn()
        mob:lookAt(player:getPos()) -- face whoever triggered the banner

        -- Add the CONFRONTATION to the NMs. The level restriction already won't apply to mobs. I just need the CONFRONTATION flag and matching power.
        -- TODO: Confrontation is not how retail works. Mobs can attack non level restricted players on retail.
        mob:addStatusEffect(xi.effect.LEVEL_RESTRICTION, { power = levelCap, origin = mob, flag = xi.effectFlag.CONFRONTATION })

        mob:updateClaim(player)
    end
end

-- CLEARED -> HIDDEN. This is called from a 60-second timer callback.
local function hideBanner(banner)
    -- Make the banner disappear and set to HIDDEN state
    banner:setStatus(xi.status.DISAPPEAR)
    banner:setLocalVar('State', bannerState.HIDDEN)

    -- Respawn the banner in 5 minutes
    banner:timer(5 * 60 * 1000, function(npcArg)
        xi.expeditionaryForce.initZone(npcArg:getZone())
    end)
end

-----------------------------------
-- Public functions
-----------------------------------

-- This code runs whenever the zone is initialized as well as every time the Expeditionary Force has been reset.
xi.expeditionaryForce.initZone = function(zone)
    local zoneId = zone:getID()
    local ID     = zones[zoneId]

    -- Set the banner to a random position and set the status to normal
    local banner        = GetNPCByID(ID.npc.BEASTMENS_BANNER)
    local bannerOptions = bannerTable[zoneId]

    if not banner then
        return
    end

    -- Set IDLE state
    banner:setLocalVar('State', bannerState.IDLE)

    -- Select a new banner position. Do not repeat the old position.
    local lastBannerIndex  = banner:getLocalVar('BannerIndex') -- 0 if never set
    local availableOptions = {}
    for i = 1, #bannerOptions do
        if i ~= lastBannerIndex then
            table.insert(availableOptions, i)
        end
    end

    local newBannerIndex = availableOptions[math.randomInt(1, #availableOptions)]

    local pos = bannerOptions[newBannerIndex].position
    banner:setPos(pos[1], pos[2], pos[3], pos[4])
    banner:setStatus(xi.status.NORMAL) -- forces visible

    -- Store the position index for later to make sure the banner does not spawn in the same place twice in a row
    banner:setLocalVar('BannerIndex', newBannerIndex)
end

-- Handle all states of the Beastmen's Banner
-- The flow of Expeditionary Force goes from IDLE to ACTIVE to CLEARED to HIDDEN then back to IDLE
xi.expeditionaryForce.onBannerTrigger = function(player, banner)
    local zoneId = banner:getZoneID()
    local ID     = zones[zoneId]
    local state  = banner:getLocalVar('State')

    switch(state): caseof
    {
        -- Banner is spawned. Expeditionary force isn't initiated.
        [bannerState.IDLE] = function()
            -- Early return: Player doesn't have region KI. Cannot initiate expeditionary force.
            local currentRegion = player:getCurrentRegion()
            if not player:hasKeyItem(regionKITable[currentRegion]) then
                player:messageSpecial(ID.text.BEASTMEN_BANNER)
                return
            end

            -- Early return: Player nation owns current region. Cannot initiate expeditionary force.
            local playerNation = player:getNation()
            local ownerNation  = GetRegionOwner(currentRegion)
            if playerNation == ownerNation then
                player:messageSpecial(ID.text.BEASTMEN_BANNER)
                return
            end

            -- Early return: Player nation is allied with current region owner. Cannot initiate expeditionary force.
            if xi.conquest.areAllies(playerNation, ownerNation) then
                player:messageSpecial(ID.text.BEASTMEN_BANNER)
                return
            end

            -- Early return: Alliance member has Level restriction. Cannot initiate expeditionary force.
            local playerAlliance = player:getAlliance()
            for _, member in pairs(playerAlliance) do
                if
                    member:getZoneID() == zoneId and
                    member:hasStatusEffect(xi.effect.LEVEL_RESTRICTION)
                then
                    player:messageSpecial(ID.text.BEASTMEN_BANNER)
                    return
                end
            end

            -- Level cap every alliance member in zone.
            local cap = zoneInfoTable[zoneId].levelCap

            for _, member in pairs(playerAlliance) do
                if member:getZoneID() == zoneId then
                    -- Add level restriction if in zone
                    member:addStatusEffect(xi.effect.LEVEL_RESTRICTION, {
                        power    = cap,
                        subPower = 1,   -- exp uses actual level and not the restricted level.
                        duration = 900, -- 15 min if not removed at the banner or zone
                        origin   = member,
                        flag     = xi.effectFlag.ON_ZONE + xi.effectFlag.CONFRONTATION,
                    })

                    -- Display banner message to all members who have been level restricted
                    member:messageSpecial(ID.text.BEASTMEN_BANNER_CURSE) -- There was a curse on the beastmen's banner!
                end
            end

            -- Spawn 4 NMs at the banner
            spawnBattleNMs(player, banner)
            banner:setLocalVar('State', bannerState.ACTIVE)
        end,

        -- Banner is spawned. Expeditionary force is ongoing.
        [bannerState.ACTIVE] = function()
            -- Remove level restriction if it exists.
            if player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
                player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
            end

            -- Anyone not level restricted can click to get level restriction. No checks.
            local cap = zoneInfoTable[zoneId].levelCap

            player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, {
                power    = cap,
                subPower = 1,   -- exp uses actual level and not the restricted level.
                duration = 900, -- 15 min if not removed at the banner or zone
                origin   = player,
                flag     = xi.effectFlag.ON_ZONE + xi.effectFlag.CONFRONTATION,
            })

            -- Display banner message
            player:messageSpecial(ID.text.BEASTMEN_BANNER_CURSE) -- There was a curse on the beastmen's banner!
        end,

        -- Banner is spawned. Expeditionary force is completed.
        [bannerState.CLEARED] = function()
            -- Remove clicker's level cap
            if player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
                player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
            end

            player:messageSpecial(ID.text.BEASTMEN_BANNER_LIFTED) -- The curse of the beastmen's banner has been lifted!
        end,

        -- Banner is not spawned.
        [bannerState.HIDDEN] = function()
            -- Someone is cheating if they can trigger this.
        end,
    }
end

-- Called from mob lua files. Fires once per alliance member in zone.
xi.expeditionaryForce.onMobDeath = function(mob, player)
    -- Despawn pets.
    local pet = mob:getPet()
    if pet then
        DespawnMob(pet:getID())
    end

    -- Remove NM from the zone list. When all NMs are accounted for, transition banner to CLEARED.
    local zoneId = mob:getZoneID()
    local mobId  = mob:getID()
    local ID     = zones[zoneId]

    -- Early return: No banner.
    local banner = GetNPCByID(ID.npc.BEASTMENS_BANNER)
    if not banner then
        return
    end

    -- Check if all NMs are dead.
    local bannerIndex = banner:getLocalVar('BannerIndex')
    local allDefeated = true
    for _, nmId in ipairs(bannerNMs[zoneId][bannerIndex]) do
        if nmId ~= mobId and GetMobByID(nmId):isAlive() then
            allDefeated = false
            break
        end
    end

    -- Mark expeditionary force as cleared.
    if allDefeated and banner:getLocalVar('State') == bannerState.ACTIVE then
        banner:setLocalVar('State', bannerState.CLEARED)

        banner:timer(60 * 1000, function(bannerArg)
            hideBanner(bannerArg)
        end)
    end

    -- This catches if a DoT kills while not engaged.
    if not player then
        return
    end

    -- Early return: Player doesn't have KI.
    local currentRegion = player:getCurrentRegion()
    if not player:hasKeyItem(regionKITable[currentRegion]) then
        return
    end

    -- Early return: Player nation owns current region.
    local creditNation = player:getNation()
    local ownerNation  = GetRegionOwner(currentRegion)
    if creditNation == ownerNation then
        return
    end

    -- Early return: Player nation is allied with region owner nation.
    if xi.conquest.areAllies(creditNation, ownerNation) then
        return
    end

    -- Award Influence
    -- TODO: Implement this
    -- player:gainConquestInfluence(xi.settings.main.EXP_FORCE_MOBKILL_INFLUENCE)

    -- SEND ZONE MESSAGE
    for _, person in pairs(mob:getZone():getPlayers()) do
        person:messageText(person, ID.text.EXP_FORCE_KILL_SANDORIA + creditNation, 5) -- 5 = Grey: messageText event
    end

    -- For every alliance member: Send message, add title, Flag participation
    for _, member in pairs(player:getAlliance()) do
        if player:getZoneID() == member:getZoneID() then
            -- Message: "x's region points have increased"
            member:messageSpecial(ID.text.REGION_POINTS_SANDORIA + creditNation) -- showText event

            -- Award all alliance members title
            member:addTitle(xi.title.EXPEDITIONARY_TROOPER)

            -- Check and mark for participation
            -- TODO: The specific ways participation is earned was never captured. It was assumed you have to be the same nation as the killer and meet all other Exp. Force participation conditions.
            if
                member:getNation() == creditNation and              -- Party member must be part of the credit nation group to get participation
                member:hasKeyItem(regionKITable[currentRegion]) and -- Party member has KI
                member:hasStatusEffect(xi.effect.LEVEL_RESTRICTION)
            then
                -- Record participation.
                local participation = member:getCharVar('[ExpForce]Participation')
                member:setCharVar('[ExpForce]Participation', bit.bor(participation, bit.lshift(1, currentRegion)))
            end
        end
    end
end

-- Fires on despawn. This is for if mobs despawn naturally without death. 3 minute despawn timer.
xi.expeditionaryForce.onMobDespawn = function(mob)
    -- Despawn pets.
    local pet = mob:getPet()
    if pet then
        DespawnMob(pet:getID())
    end

    -- Handle expeditionary force completion.
    local zoneId = mob:getZoneID()

    local banner = GetNPCByID(zones[zoneId].npc.BEASTMENS_BANNER)
    if not banner then
        return
    end

    local bannerIndex = banner:getLocalVar('BannerIndex')
    for _, nmId in ipairs(bannerNMs[zoneId][bannerIndex]) do
        if nmId ~= mob:getID() and GetMobByID(nmId):isAlive() then
            return
        end
    end

    if banner:getLocalVar('State') == bannerState.ACTIVE then
        banner:setLocalVar('State', bannerState.CLEARED)

        banner:timer(60 * 1000, function(bannerArg)
            hideBanner(bannerArg)
        end)
    end
end

-- Pets called mid-fight (call beast, astral flow) miss the gate at spawn. Need to apply manually.
xi.expeditionaryForce.gatePet = function(mob)
    -- Non NMs share pet names with NMs. Only gate pets whose owner is gated.
    -- Exclude astral flow mobs which are masterless pets.
    local master = mob:getMaster()
    if master and not master:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
        return
    end

    mob:addStatusEffect(xi.effect.LEVEL_RESTRICTION, { power = zoneInfoTable[mob:getZoneID()].levelCap, origin = mob, flag = xi.effectFlag.CONFRONTATION })
end

-- Award influence for opening a chest/coffer with the region's insignia.
-- TODO: The text order is slightly different than retail, but that would require modifying treasure.lua.
xi.expeditionaryForce.onChestOpen = function(player)
    -- Early return: Player doesn't have KI.
    local currentRegion = player:getCurrentRegion()
    if not player:hasKeyItem(regionKITable[currentRegion]) then
        return
    end

    -- Early return: Player nation owns current region.
    local playerNation = player:getNation()
    local ownerNation  = GetRegionOwner(currentRegion)
    if playerNation == ownerNation then
        return
    end

    -- Early return: Player nation is allied with region owner nation.
    if xi.conquest.areAllies(playerNation, ownerNation) then
        return
    end

    -- Handle nation message.
    player:messageSpecial(zones[player:getZoneID()].text.REGION_POINTS_SANDORIA + playerNation)

    -- Record participation.
    local participation = player:getCharVar('[ExpForce]Participation')
    player:setCharVar('[ExpForce]Participation', bit.bor(participation, bit.lshift(1, currentRegion)))

    -- TODO: Award influence.
    -- player:gainConquestInfluence(xi.settings.main.EXP_FORCE_TREASURE_INFLUENCE)

    -- TODO: Never tested if opening a chest granted the EF title.
end

-- Dispose of every Expeditionary Force insignia the player is holding.
-- Called on a nation change, since insignias are tied to the player's old allegiance.
xi.expeditionaryForce.disposeInsigniaNationSwap = function(player)
    -- Remove all insignias
    local removed = false
    for _, ki in pairs(regionKITable) do
        if player:hasKeyItem(ki) then
            player:delKeyItem(ki)
            removed = true
        end
    end

    -- If any insignia is removed, send message and reset character variables
    if removed then
        player:messageSpecial(zones[player:getZoneID()].text.INVALID_ENSIGNIAS)
        player:setCharVar('[ExpForce]Participation', 0)
        player:setCharVar('[ExpForce]NextConquestTally', 0)
        player:setCharVar('[ExpForce]AwardCP', 0)
    end
end
