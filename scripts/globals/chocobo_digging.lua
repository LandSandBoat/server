-----------------------------------
-- Chocobo Digging
-- http://ffxiclopedia.wikia.com/wiki/Chocobo_Digging
-- https://www.bg-wiki.com/bg/Category:Chocobo_Digging
-----------------------------------
require("scripts/globals/roe")
require("scripts/globals/utils")
require("scripts/globals/zone")
require("scripts/missions/amk/helpers")
-----------------------------------

xi = xi or {}
xi.chocoboDig = xi.chocoboDig or {}

local digRate = xi.settings.main.DIG_RATE
local digFatigue = xi.settings.main.DIG_FATIGUE
local digZoneLimit = xi.settings.main.DIG_ZONE_LIMIT
local digGrantBurrow = xi.settings.main.DIG_GRANT_BURROW
local digGrantBore = xi.settings.main.DIG_GRANT_BORE
local digDistanceReq = xi.settings.main.DIG_DISTANCE_REQ

local findNothing = "You dig and you dig, but you find nothing."

local digReq =
{
    NONE     = 0,
    BURROW   = 1,
    BORE     = 2,
    MODIFIER = 4,
    NIGHT    = 8,
    WEATHER  = 16,
    ORE      = 32,
}

local crystalMap =
{
    [xi.weather.HOT_SPELL    ] = 4096, -- fire crystal
    [xi.weather.HEAT_WAVE    ] = 4104, -- fire cluster
    [xi.weather.RAIN         ] = 4101, -- water crystal
    [xi.weather.SQUALL       ] = 4109, -- water cluster
    [xi.weather.DUST_STORM   ] = 4099, -- earth crystal
    [xi.weather.SAND_STORM   ] = 4107, -- earth cluster
    [xi.weather.WIND         ] = 4098, -- wind crystal
    [xi.weather.GALES        ] = 4106, -- wind cluster
    [xi.weather.SNOW         ] = 4097, -- ice crystal
    [xi.weather.BLIZZARDS    ] = 4105, -- ice cluster
    [xi.weather.THUNDER      ] = 4100, -- lightning crystal
    [xi.weather.THUNDERSTORMS] = 4108, -- lightning cluster
    [xi.weather.AURORAS      ] = 4102, -- light crystal
    [xi.weather.STELLAR_GLARE] = 4110, -- light cluster
    [xi.weather.GLOOM        ] = 4103, -- dark crystal
    [xi.weather.DARKNESS     ] = 4111, -- dark cluster
}

local oreMap =
{
    [xi.day.FIRESDAY    ] = 1255, -- fire ore
    [xi.day.EARTHSDAY   ] = 1258, -- earth ore
    [xi.day.WATERSDAY   ] = 1260, -- water ore
    [xi.day.WINDSDAY    ] = 1257, -- wind ore
    [xi.day.ICEDAY      ] = 1256, -- ice ore
    [xi.day.LIGHTNINGDAY] = 1259, -- lightning ore
    [xi.day.LIGHTSDAY   ] = 1261, -- light ore
    [xi.day.DARKSDAY    ] = 1262, -- dark ore
}

-----------------------------------
-- { itemId, weight, dig requirements }
-----------------------------------
local digInfo =
{
    [xi.zone.CARPENTERS_LANDING] = -- 2
    {
        {  4504, 152, digReq.NONE     },
        {   688, 182, digReq.NONE     },
        {   697,  83, digReq.NONE     },
        {  4386,   3, digReq.NONE     },
        { 17396, 129, digReq.NONE     },
        {   691, 144, digReq.NONE     },
        {   918,   8, digReq.NONE     },
        {   699,  76, digReq.NONE     },
        {  4447,  38, digReq.NONE     },
        {   695,  45, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {  4100,  59, digReq.BURROW   },
        {  4101,  59, digReq.BURROW   },
        {   690,  15, digReq.BORE     },
        {  1446,   8, digReq.BORE     },
        {   700,  23, digReq.BORE     },
        {   701,   8, digReq.BORE     },
        {   696,  30, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.BIBIKI_BAY] = -- 4
    {
        {   847,  70, digReq.NONE     },
        {   887,  10, digReq.NONE     },
        {   893,  55, digReq.NONE     },
        { 17395, 110, digReq.NONE     },
        {   738,   5, digReq.NONE     },
        {   888, 160, digReq.NONE     },
        {  4484,  60, digReq.NONE     },
        { 17397, 110, digReq.NONE     },
        {   641, 130, digReq.NONE     },
        {   885,  30, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {   845, 150, digReq.BURROW   },
        {   843,  10, digReq.BURROW   },
        {   844,  90, digReq.BURROW   },
        {  1845,  10, digReq.BURROW   },
        {   838,  10, digReq.BURROW   },
        {   880,  70, digReq.BORE     },
        {   902,  20, digReq.BORE     },
        {   886,  30, digReq.BORE     },
        {   867,  10, digReq.BORE     },
        {   864,  40, digReq.BORE     },
        {  1587,  50, digReq.BORE     },
        {  1586,  30, digReq.BORE     },
        {   866,   3, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.WAJAOM_WOODLANDS] = -- 51
    {
        {   646,   3, digReq.NONE     },
        {   845,  75, digReq.NONE     },
        {   770,  31, digReq.NONE     },
        {   702,  52, digReq.NONE     },
        {   833, 190, digReq.NONE     },
        { 17296, 147, digReq.NONE     },
        {  2164,  17, digReq.NONE     },
        {  2213, 152, digReq.NONE     },
        {   838,   4, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {   688, 137, digReq.BURROW   },
        {   690,  10, digReq.BURROW   },
        {  1446,   1, digReq.BURROW   },
        {   700,   4, digReq.BURROW   },
        {   699,  31, digReq.BURROW   },
        {   701,   4, digReq.BURROW   },
        {   696,  35, digReq.BURROW   },
        {   678,   1, digReq.BORE     },
        {   645,   1, digReq.BORE     },
        {   768,  98, digReq.BORE     },
        {   737,  22, digReq.BORE     },
        {  2475,   3, digReq.BORE     },
        {   739,   1, digReq.BORE     },
        {   738,   3, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.BHAFLAU_THICKETS] = -- 52
    {
        {   770,  50, digReq.NONE     },
        {  2150,  60, digReq.NONE     },
        {   622, 197, digReq.NONE     },
        {  2155,  23, digReq.NONE     },
        {   739,   5, digReq.NONE     },
        { 17296, 133, digReq.NONE     },
        {   703,  69, digReq.NONE     },
        {  2213, 135, digReq.NONE     },
        {   838,  21, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {   688, 144, digReq.BURROW   },
        {   702,  14, digReq.BURROW   },
        {   690,  23, digReq.BURROW   },
        {  1446,   3, digReq.BURROW   },
        {   700,  14, digReq.BURROW   },
        {   699,  37, digReq.BURROW   },
        {   701,  28, digReq.BURROW   },
        {   696,  23, digReq.BURROW   },
        {   678,   9, digReq.BORE     },
        {   645,   3, digReq.BORE     },
        {   768, 193, digReq.BORE     },
        {   737,  22, digReq.BORE     },
        {  2475,   3, digReq.BORE     },
        {   738,   3, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.WEST_RONFAURE] = -- 100
    {
        {  4504, 120, digReq.NONE     },
        {   688, 111, digReq.NONE     },
        { 17396, 148, digReq.NONE     },
        {   698,  28, digReq.NONE     },
        {   840,  74, digReq.NONE     },
        {   691,  46, digReq.NONE     },
        {   833,  56, digReq.NONE     },
        {   639,  10, digReq.NONE     },
        {   694,  63, digReq.NONE     },
        {   918,  12, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {  4545,   5, digReq.BURROW   },
        {   636,  63, digReq.BURROW   },
        {   617,  63, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
        {   573,  23, digReq.NIGHT    },
    },

    [xi.zone.EAST_RONFAURE] = -- 101
    {
        {  4504, 224, digReq.NONE     },
        {   688, 184, digReq.NONE     },
        { 17396, 276, digReq.NONE     },
        {   698,  69, digReq.NONE     },
        {   840,  63, digReq.NONE     },
        {   691, 144, digReq.NONE     },
        {   639,  29, digReq.NONE     },
        {   694,  10, digReq.NONE     },
        {  4386,  11, digReq.NONE     },
        {   918,  10, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {  4545,  12, digReq.BURROW   },
        {   636,  29, digReq.BURROW   },
        {   617,  12, digReq.BORE     },
        {  4570,  11, digReq.MODIFIER },
        {  4487,  12, digReq.MODIFIER },
        {  4409,  10, digReq.MODIFIER },
        {  1188,  12, digReq.MODIFIER },
        {  4532,  11, digReq.MODIFIER },
        {   574,  37, digReq.NIGHT    },
    },

    [xi.zone.LA_THEINE_PLATEAU] = -- 102
    {
        {   688, 153, digReq.NONE     },
        { 17396, 155, digReq.NONE     },
        { 17296, 134, digReq.NONE     },
        {   641, 103, digReq.NONE     },
        {   840,  56, digReq.NONE     },
        {   642,  49, digReq.NONE     },
        {   696,  57, digReq.NONE     },
        {   694,  40, digReq.NONE     },
        {   622,  28, digReq.NONE     },
        {   700,   3, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {  4545,  34, digReq.BURROW   },
        {   636,  20, digReq.BURROW   },
        {   616,   8, digReq.BURROW   },
        {  5235,   2, digReq.BURROW   },
        {  2364, 139, digReq.BORE     },
        {  2235,  44, digReq.BORE     },
        {   617,   6, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  1237,  12, digReq.MODIFIER },
    },

    [xi.zone.VALKURM_DUNES] = -- 103
    {
        {   770,   1, digReq.NONE     },
        {   880, 166, digReq.NONE     },
        {   864,  96, digReq.NONE     },
        {   893,  26, digReq.NONE     },
        {   869, 110, digReq.NONE     },
        { 17395, 111, digReq.NONE     },
        {   888, 215, digReq.NONE     },
        {  4484,  32, digReq.NONE     },
        { 17397,  21, digReq.NONE     },
        {   885,  10, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {   845, 125, digReq.BURROW   },
        {   843,  10, digReq.BURROW   },
        {   844,  40, digReq.BURROW   },
        {  1845,  24, digReq.BURROW   },
        {   838,   4, digReq.BURROW   },
        {   902,   6, digReq.BORE     },
        {   886,   3, digReq.BORE     },
        {   867,   1, digReq.BORE     },
        {  1587,  11, digReq.BORE     },
        {  1586,   4, digReq.BORE     },
        {   866,   1, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.JUGNER_FOREST] = -- 104
    {
        {  4504, 145, digReq.NONE     },
        {   688, 110, digReq.NONE     },
        {   697,  93, digReq.NONE     },
        {  4386,   3, digReq.NONE     },
        { 17396, 152, digReq.NONE     },
        {   691, 138, digReq.NONE     },
        {   918,  17, digReq.NONE     },
        {   699,  59, digReq.NONE     },
        {  4447,  28, digReq.NONE     },
        {   695,   9, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {   690,  15, digReq.BORE     },
        {  1446,   8, digReq.BORE     },
        {   702,  23, digReq.BORE     },
        {   701,   8, digReq.BORE     },
        {   696,  30, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.BATALLIA_DOWNS] = -- 105
    {
        {   847,  69, digReq.NONE     },
        {   880, 137, digReq.NONE     },
        {   845,   4, digReq.NONE     },
        {   640,  82, digReq.NONE     },
        {   768, 133, digReq.NONE     },
        {   643,  82, digReq.NONE     },
        { 17296, 137, digReq.NONE     },
        {   774,  26, digReq.NONE     },
        {   106,  69, digReq.NONE     },
        {  4449,   3, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {   656, 106, digReq.BURROW   },
        {   748,   8, digReq.BURROW   },
        {   749,  30, digReq.BURROW   },
        {   750, 136, digReq.BURROW   },
        {  1237,  30, digReq.BORE     },
        {  2235,  60, digReq.BORE     },
        {  2364, 150, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.NORTH_GUSTABERG] = -- 106
    {
        {   880, 176, digReq.NONE     },
        { 17396, 297, digReq.NONE     },
        { 17296, 202, digReq.NONE     },
        {   847,  75, digReq.NONE     },
        {   864,  45, digReq.NONE     },
        {   846, 108, digReq.NONE     },
        {   869, 149, digReq.NONE     },
        {   868,  83, digReq.NONE     },
        {   749,  63, digReq.NONE     },
        {   644,  60, digReq.NONE     },
        {   645,   3, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {  4545, 150, digReq.BURROW   },
        {   636,  50, digReq.BURROW   },
        {   617, 100, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
        {  1236,   3, digReq.NIGHT    },
    },

    [xi.zone.SOUTH_GUSTABERG] = -- 107
    {
        { 17296, 252, digReq.NONE     },
        { 17396, 227, digReq.NONE     },
        {   846, 156, digReq.NONE     },
        {   880, 133, digReq.NONE     },
        {   936,  83, digReq.NONE     },
        {   869,  80, digReq.NONE     },
        {   749,  32, digReq.NONE     },
        {   847,  23, digReq.NONE     },
        {   644,   5, digReq.NONE     },
        {   776,   3, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {  4545,   5, digReq.BURROW   },
        {   636,  63, digReq.BURROW   },
        {   617,  63, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
        {   575,  14, digReq.NIGHT    },
    },

    [xi.zone.KONSCHTAT_HIGHLANDS] = -- 108
    {
        {   847,  13, digReq.NONE     },
        {   880, 165, digReq.NONE     },
        {   690,  68, digReq.NONE     },
        {   864,  80, digReq.NONE     },
        {   768,  90, digReq.NONE     },
        {   869,  63, digReq.NONE     },
        {   749,  14, digReq.NONE     },
        { 17296, 214, digReq.NONE     },
        {   844,  14, digReq.NONE     },
        {   868,  45, digReq.NONE     },
        {   642,  71, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {   845,  28, digReq.BORE     },
        {   842,  27, digReq.BORE     },
        {   843,  23, digReq.BORE     },
        {  1845,  22, digReq.BORE     },
        {   838,  19, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.PASHHOW_MARSHLANDS] = -- 109
    {
        {   846, 216, digReq.NONE     },
        { 17296, 210, digReq.NONE     },
        {   869, 188, digReq.NONE     },
        {   736,  72, digReq.NONE     },
        {   695, 102, digReq.NONE     },
        {  4448,  48, digReq.NONE     },
        {   775,  36, digReq.NONE     },
        {   749,  18, digReq.NONE     },
        {   703,   6, digReq.NONE     },
        {   885,   9, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {  2364, 120, digReq.BURROW   },
        {  2235,  42, digReq.BURROW   },
        {  1237,  24, digReq.BURROW   },
        {  1236,  12, digReq.BURROW   },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.ROLANBERRY_FIELDS] = -- 110
    {
        {  4450,  30, digReq.NONE     },
        {  4566,   7, digReq.NONE     },
        {   768, 164, digReq.NONE     },
        {   748,  15, digReq.NONE     },
        {   846,  97, digReq.NONE     },
        { 17396,  75, digReq.NONE     },
        {   749,  45, digReq.NONE     },
        {   739,   3, digReq.NONE     },
        { 17296, 216, digReq.NONE     },
        {  4448,  15, digReq.NONE     },
        {   638,  82, digReq.NONE     },
        {   106,  37, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {   656, 200, digReq.BURROW   },
        {   750, 100, digReq.BURROW   },
        {  4375,  60, digReq.BORE     },
        {  4449,  15, digReq.BORE     },
        {  4374,  52, digReq.BORE     },
        {  4373,  10, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.EASTERN_ALTEPA_DESERT] = -- 114
    {
        {   880, 176, digReq.NONE     },
        {   893,  88, digReq.NONE     },
        { 17296, 135, digReq.NONE     },
        {   736,  52, digReq.NONE     },
        {   644,  22, digReq.NONE     },
        {   942,   4, digReq.NONE     },
        {   738,  12, digReq.NONE     },
        {   866,  36, digReq.NONE     },
        {   642,  58, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {   574,  33, digReq.BURROW   },
        {   575,  74, digReq.BURROW   },
        {   572,  59, digReq.BURROW   },
        {  1237,  19, digReq.BURROW   },
        {   573,  44, digReq.BURROW   },
        {  2235,  41, digReq.BURROW   },
        {   646,   3, digReq.BORE     },
        {   678,  18, digReq.BORE     },
        {   645,   9, digReq.BORE     },
        {   768, 129, digReq.BORE     },
        {   737,   3, digReq.BORE     },
        {   739,   3, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.WEST_SARUTABARUTA] = -- 115
    {
        {   689, 205, digReq.NONE     },
        { 17396, 295, digReq.NONE     },
        { 17296, 341, digReq.NONE     },
        {  4545,  50, digReq.NONE     },
        {   847,  50, digReq.NONE     },
        {   846,  68, digReq.NONE     },
        {   833,  68, digReq.NONE     },
        {   841,  23, digReq.NONE     },
        {   834,  50, digReq.NONE     },
        {   701,  50, digReq.NONE     },
        {   702,   3, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {   617,  50, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
        {  1237,  10, digReq.NIGHT    },
    },

    [xi.zone.EAST_SARUTABARUTA] = -- 116
    {
        {   689, 236, digReq.NONE     },
        {   938, 125, digReq.NONE     },
        { 17296, 181, digReq.NONE     },
        {   847,  14, digReq.NONE     },
        {   846,  69, digReq.NONE     },
        {   833,   8, digReq.NONE     },
        {   841,  69, digReq.NONE     },
        {   834,  14, digReq.NONE     },
        {   772,  14, digReq.NONE     },
        {   701,   8, digReq.NONE     },
        {   702,   3, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {  4545, 200, digReq.BURROW   },
        {   636,  50, digReq.BURROW   },
        {  5235,  10, digReq.BURROW   },
        {   617,  50, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
        {   572, 100, digReq.NIGHT    },
    },

    [xi.zone.TAHRONGI_CANYON] = -- 117
    {
        {   880, 118, digReq.NONE     },
        {   893, 121, digReq.NONE     },
        {   748,   5, digReq.NONE     },
        {   737,   2, digReq.NONE     },
        {   846,  45, digReq.NONE     },
        { 17296, 134, digReq.NONE     },
        {   769,  10, digReq.NONE     },
        {   888, 175, digReq.NONE     },
        {   641, 100, digReq.NONE     },
        {   841,  45, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {   656, 148, digReq.BURROW   },
        {   749,  25, digReq.BURROW   },
        {   751,   1, digReq.BURROW   },
        {   750,  86, digReq.BURROW   },
        {   902,   2, digReq.BORE     },
        {   886,   1, digReq.BORE     },
        {   867,   3, digReq.BORE     },
        {  1587,   8, digReq.BORE     },
        {  1586,   2, digReq.BORE     },
        {   885,   8, digReq.BORE     },
        {   866,   3, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.BUBURIMU_PENINSULA] = -- 118
    {
        {   847,  45, digReq.NONE     },
        {   887,   1, digReq.NONE     },
        {   893,  53, digReq.NONE     },
        { 17395,  98, digReq.NONE     },
        {   738,   3, digReq.NONE     },
        {   888, 195, digReq.NONE     },
        {  4484,  47, digReq.NONE     },
        { 17397,  66, digReq.NONE     },
        {   641, 134, digReq.NONE     },
        {   885,  12, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {   845, 125, digReq.BURROW   },
        {   843,   1, digReq.BURROW   },
        {   844,  64, digReq.BURROW   },
        {  1845,  34, digReq.BURROW   },
        {   838,   7, digReq.BURROW   },
        {   880,  34, digReq.BORE     },
        {   902,   5, digReq.BORE     },
        {   886,   3, digReq.BORE     },
        {   867,   3, digReq.BORE     },
        {   864,  21, digReq.BORE     },
        {  1587,  19, digReq.BORE     },
        {  1586,   9, digReq.BORE     },
        {   866,   2, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.MERIPHATAUD_MOUNTAINS] = -- 119
    {
        {   646,   4, digReq.NONE     },
        {   845,  12, digReq.NONE     },
        {   640, 112, digReq.NONE     },
        {   768, 237, digReq.NONE     },
        {   893,  41, digReq.NONE     },
        {   748,  33, digReq.NONE     },
        {   846, 145, digReq.NONE     },
        {   869, 100, digReq.NONE     },
        { 17296, 162, digReq.NONE     },
        {   771,  21, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {   678,   5, digReq.BURROW   },
        {   645,   9, digReq.BURROW   },
        {   737,   5, digReq.BURROW   },
        {   643,  69, digReq.BURROW   },
        {  1650,  62, digReq.BURROW   },
        {   644,  31, digReq.BURROW   },
        {   736,  62, digReq.BURROW   },
        {   739,   5, digReq.BURROW   },
        {   678,   5, digReq.BORE     },
        {   645,   9, digReq.BORE     },
        {   737,   5, digReq.BORE     },
        {   738,   8, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.SAUROMUGUE_CHAMPAIGN] = -- 120
    {
        {   845,   8, digReq.NONE     },
        {   880, 126, digReq.NONE     },
        {   768, 130, digReq.NONE     },
        {   748,  55, digReq.NONE     },
        {   846,  91, digReq.NONE     },
        {   643,  75, digReq.NONE     },
        {   869,  87, digReq.NONE     },
        { 17296, 168, digReq.NONE     },
        {   106,  32, digReq.NONE     },
        {   773,  50, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {   656,  95, digReq.BURROW   },
        {   749,  26, digReq.BURROW   },
        {   751,  33, digReq.BURROW   },
        {   750,  89, digReq.BURROW   },
        {   902,  27, digReq.BORE     },
        {   886,   3, digReq.BORE     },
        {   864,  41, digReq.BORE     },
        {  1587,  54, digReq.BORE     },
        {   888,  68, digReq.BORE     },
        {  1586,  14, digReq.BORE     },
        {   885,  14, digReq.BORE     },
        {   866,  14, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.THE_SANCTUARY_OF_ZITAH] = -- 121
    {
        {   688, 117, digReq.NONE     },
        { 17296, 150, digReq.NONE     },
        {   880, 100, digReq.NONE     },
        {   833,  83, digReq.NONE     },
        {   696, 100, digReq.NONE     },
        {   690,  33, digReq.NONE     },
        {   772,  17, digReq.NONE     },
        {   773,  33, digReq.NONE     },
        {  4386,   9, digReq.NONE     },
        {   703,   7, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {  1255,  10, digReq.ORE      }, -- all ores
        {   656, 117, digReq.BURROW   },
        {   750, 133, digReq.BURROW   },
        {   749, 117, digReq.BURROW   },
        {   748,   8, digReq.BURROW   },
        {   751,  14, digReq.BURROW   },
        {   720,   1, digReq.BURROW   },
        {   699,   9, digReq.BORE     },
        {   720,   1, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },

    [xi.zone.YUHTUNGA_JUNGLE] = -- 123
    {
        {  880, 185, digReq.NONE     },
        {  628,  72, digReq.NONE     },
        {  721,  91, digReq.NONE     },
        { 4375,  40, digReq.NONE     },
        {  702,   4, digReq.NONE     },
        { 1983,  10, digReq.NONE     },
        {  701,  29, digReq.NONE     },
        { 4386,   4, digReq.NONE     },
        {  703,   9, digReq.NONE     },
        { 4448,   7, digReq.NONE     },
        {  720,   3, digReq.NONE     },
        { 4096, 100, digReq.WEATHER  }, -- all crystals
        { 4374,  17, digReq.BURROW   },
        { 4373,  41, digReq.BURROW   },
        { 4375,  15, digReq.BURROW   },
        { 4566,   3, digReq.BURROW   },
        {  688,  23, digReq.BORE     },
        {  696,  17, digReq.BORE     },
        {  690,   3, digReq.BORE     },
        {  699,  12, digReq.BORE     },
        {  701,   9, digReq.BORE     },
        { 1446,   3, digReq.BORE     },
        { 4570,  10, digReq.MODIFIER },
        { 4487,  11, digReq.MODIFIER },
        { 4409,  12, digReq.MODIFIER },
        { 1188,  10, digReq.MODIFIER },
        { 4532,  12, digReq.MODIFIER },
    },

    [xi.zone.YHOATOR_JUNGLE] = -- 124
    {
        {  880, 282, digReq.NONE     },
        {  689, 177, digReq.NONE     },
        { 4432, 140, digReq.NONE     },
        {  923,  90, digReq.NONE     },
        {  702,  41, digReq.NONE     },
        {  700,  44, digReq.NONE     },
        { 4450,  47, digReq.NONE     },
        {  703,  26, digReq.NONE     },
        { 4449,  12, digReq.NONE     },
        { 4096, 100, digReq.WEATHER  }, -- all crystals
        { 4374,  17, digReq.BURROW   },
        { 4373,  41, digReq.BURROW   },
        { 4375,  15, digReq.BURROW   },
        { 4566,   3, digReq.BURROW   },
        {  688,  23, digReq.BORE     },
        {  696,  17, digReq.BORE     },
        {  690,   3, digReq.BORE     },
        {  699,  12, digReq.BORE     },
        {  701,   9, digReq.BORE     },
        { 1446,   3, digReq.BORE     },
        { 4570,  10, digReq.MODIFIER },
        { 4487,  11, digReq.MODIFIER },
        { 4409,  12, digReq.MODIFIER },
        { 1188,  10, digReq.MODIFIER },
        { 4532,  12, digReq.MODIFIER },
    },

    [xi.zone.WESTERN_ALTEPA_DESERT] = -- 125
    {
        {   880, 224, digReq.NONE     },
        {   887,  39, digReq.NONE     },
        {   645,  14, digReq.NONE     },
        {   893, 105, digReq.NONE     },
        {   737,  17, digReq.NONE     },
        {   643,  64, digReq.NONE     },
        { 17296, 122, digReq.NONE     },
        {   942,   6, digReq.NONE     },
        {   642,  58, digReq.NONE     },
        {   864,  22, digReq.NONE     },
        {   843,   4, digReq.NONE     },
        {  4096, 100, digReq.WEATHER  }, -- all crystals
        {   845, 122, digReq.BURROW   },
        {   844,  71, digReq.BURROW   },
        {  1845,  33, digReq.BURROW   },
        {   838,  11, digReq.BURROW   },
        {   902,   6, digReq.BORE     },
        {   886,   3, digReq.BORE     },
        {   867,   3, digReq.BORE     },
        {  1587,  19, digReq.BORE     },
        {   888,  25, digReq.BORE     },
        {  1586,   8, digReq.BORE     },
        {   885,  10, digReq.BORE     },
        {   866,   3, digReq.BORE     },
        {  4570,  10, digReq.MODIFIER },
        {  4487,  11, digReq.MODIFIER },
        {  4409,  12, digReq.MODIFIER },
        {  1188,  10, digReq.MODIFIER },
        {  4532,  12, digReq.MODIFIER },
    },
}

local function updatePlayerDigCount(player, increment)
    if increment == 0 then
        player:setCharVar('[DIG]DigCount', 0)
    else
        player:setCharVar('[DIG]DigCount', player:getCharVar('[DIG]DigCount') + increment)
    end

    player:setCharVar('[DIG]LastDigTime', os.time())
end

local function canDig(player)
    local digCount        = player:getCharVar('[DIG]DigCount')
    local lastDigTime     = player:getCharVar('[DIG]LastDigTime')
    local lastDigX        = player:getCharVar('[DIG]LastDigX')
    local lastDigY        = player:getCharVar('[DIG]LastDigY')
    local lastDigZ        = player:getCharVar('[DIG]LastDigZ')
    local posTable        = player:getPos()
    local currX           = math.floor(posTable.x)
    local currY           = math.floor(posTable.y)
    local currZ           = math.floor(posTable.z)
    local distanceSquared = (lastDigX - currX) * (lastDigX - currX) + (lastDigY - currY) * (lastDigY - currY) + (lastDigZ - currZ) * (lastDigZ - currZ)
    local zoneInTime      = player:getLocalVar('ZoneInTime')
    local currentTime     = os.time()
    local skillRank       = player:getSkillRank(xi.skill.DIG)
    -- personal dig caps
    local digCap          = digFatigue + (skillRank * 10)
    -- base delay -5 for each rank
    local digDelay        = 16 - (skillRank * 5)
    local areaDigDelay    = 60 - (skillRank * 5)
    digDelay = utils.clamp(digDelay, 4, 16)

    if player:hasItem(4545, 0) then
        -- Minimum delay to cover the animation time

        local prevMidnight = getMidnight() - 86400

        -- Last dig was before today, so reset player fatigue
        if lastDigTime < prevMidnight then
            updatePlayerDigCount(player, 0)
            digCount = 0
        end

        -- neither player nor zone have reached their dig limit
        if digCount < digCap then
            -- pesky delays
            if
                (zoneInTime + areaDigDelay) <= currentTime and
                (lastDigTime + digDelay) <= currentTime and
                distanceSquared > digDistanceReq
            then
                player:setCharVar('[DIG]LastDigX', currX)
                player:setCharVar('[DIG]LastDigY', currY)
                player:setCharVar('[DIG]LastDigZ', currZ)

                return true
            end
        end
    end

    return false
end

--[[
per wiki, avg. digs needed per rank
taken from wiki, took the average of top/bottom
and then x12 to convert from "stacks" to singles
Amateur    1650 (chopped the 50 so we dont have to math.floor later)
Recruit    3600
Initiate    6000
Novice         9000
Apprentice    12600
Journeyman  16200
Craftsman    21000
Artisan    27000
Adept         33000
Veteran    39000
Expert         ----
]]

local function calculateSkillUp(player)
    local skillRank  = player:getSkillRank(xi.skill.DIG)
    local realSkill  = player:getCharSkillLevel(xi.skill.DIG)

    local digsTable = -- Era Dig Table
    {
        [0] = {  1600 },
        [1] = {  3600 },
        [2] = {  6000 },
        [3] = {  9000 },
        [4] = { 12600 },
        [5] = { 16200 },
        [6] = { 21000 },
        [7] = { 27000 },
        [8] = { 33000 },
        [9] = { 39000 },
    }

    -- local digsTable = -- Limit Break Dig Table
    -- {
        -- [0] = {  2000 },
        -- [1] = {  2500 },
        -- [2] = {  3300 },
        -- [3] = {  5000 },
        -- [4] = { 10000 },
        -- [5] = { 11100 },
        -- [6] = { 12500 },
        -- [7] = { 14300 },
        -- [8] = { 16700 },
        -- [9] = { 20000 },
    -- }

    if math.random(1, math.floor(digsTable[skillRank][1] / 100)) == 1 then
        if realSkill < 1000 then -- Safety check.
            player:setSkillLevel(xi.skill.DIG, realSkill + 1)

            -- Digging does not have test items, so increment rank once player hits 10.0, 20.0, .. 100.0
            if (realSkill + 1) >= (skillRank * 100) + 100 then
                player:setSkillRank(xi.skill.DIG, skillRank + 1)
            end
        end
    end
end

-- TODO: Reduce complexity
-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
local function getChocoboDiggingItem(player)
    local allItems        = digInfo[player:getZoneID()]
    local burrowAbility = (digGrantBurrow == 1) and 1 or 0
    local boreAbility   = (digGrantBore == 1) and 1 or 0
    local modifier               = player:getMod(xi.mod.EGGHELM)
    local totd                   = VanadielTOTD()
    -- Zone Weather
    local zone                   = player:getZone()
    local weather                = zone:getWeather()
    -- Waxing 7% - 24%
    local moon                   = VanadielMoonPhase()
    local moonDirection          = VanadielMoonDirection()
    local DigRank                = player:getSkillRank(xi.skill.DIG)
    -- Filter allItems to possibleItems and sum weights
    local possibleItems          = {}
    local itemWeight             = 0
    local sum                    = 0

    -- Generate a table with items the player can actually dig up based on weather, time, moon, skills, etc...
    for i = 1, #allItems do
        local item    = allItems[i]
        local itemReq = item[3]

        if
            (itemReq == digReq.NONE) or
            (itemReq == digReq.BURROW and burrowAbility == 1) or
            (itemReq == digReq.BORE and boreAbility == 1) or
            (itemReq == digReq.MODIFIER and modifier == 1) or
            (itemReq == digReq.NIGHT and totd == xi.time.NIGHT) or
            (itemReq == digReq.WEATHER and weather > xi.weather.FOG) or
            (itemReq == digReq.ORE and weather >= xi.weather.FOG and moonDirection == 2 and moon >= 7 and moon <= 24 and DigRank >= 6)
        then
            -- skill up weight variation and ore moon variation
            itemWeight = item[2]

            local weights =
            {
                { 150, 0.95 },
                { 125, 0.97 },
                { 100, 0.99 },
                {  50, 1.03 },
                {   1, 1.05 },
            }

            for _, v in pairs(weights) do
                if DigRank > 0 then
                    if itemWeight >= v[1] then
                        itemWeight = itemWeight * (v[2]^DigRank)
                        break
                    end
                end
            end

            local moonPhases =
            {
                {  7,  9, 0.7 },
                { 15, 20, 0.9 },
                { 21, 24, 0.5 },
            }

            for _, v in pairs(moonPhases) do
                if item[1] == 1255 then
                    if moon >= v[1] and moon <= v[2] then
                        itemWeight = itemWeight * v[3]
                    end
                end
            end

            sum = sum + itemWeight
            table.insert(possibleItems, item)
        end
    end

    -- Pick weighted result.
    local itemId = 0
    local pick   = math.random(math.floor(sum))
    sum          = 0

    for i = 1, #possibleItems do
        itemWeight = possibleItems[i][2]

        local weights =
        {
            { 150, 0.95 },
            { 125, 0.97 },
            { 100, 0.99 },
            {  50, 1.03 },
            {   1, 1.05 },
        }

        -- skill up weight variation and ore moon variation
        for _, v in pairs(weights) do
            if DigRank > 0 then
                if itemWeight >= v[1] then
                    itemWeight = itemWeight * (v[2]^DigRank)
                    break
                end
            end
        end

        local moonPhases =
        {
            {  7,  9, 0.7 },
            { 15, 20, 0.9 },
            { 21, 24, 0.5 },
        }

        for _, v in pairs(moonPhases) do
            if possibleItems[i][1] == 1255 then
                if moon >= v[1] and moon <= v[2] then
                    itemWeight = itemWeight * v[3]
                end
            end
        end

        sum = sum + itemWeight

        if sum >= pick then
            itemId = possibleItems[i][1]
            break
        end
    end

    -- Item is a crystal or ore
    if itemId == 4096 then
        itemId = crystalMap[weather]
    elseif itemId == 1255 then
        itemId = oreMap[VanadielDayOfTheWeek()]
    end

    return itemId
end

-- Main function.
xi.chocoboDig.start = function(player, precheck)
    local zoneId      = player:getZoneID()
    local text        = zones[zoneId].text
    local skillRank   = player:getSkillRank(xi.skill.DIG)
    local lastDigTime = player:getCharVar('[DIG]LastDigTime')

    -- make sure the player can dig before going any further
    -- (and also cause i need a return before core can go any further with this)
    if canDig(player) then
        local roll           = math.random(0, 100)
        local moon           = VanadielMoonPhase()
        local moonmodifier   = 1
        local skillmodifier  = 0.5 + (skillRank / 20) -- 50% at amateur, 55% at recruit, 60% at initiate, and so on, to 100% at exper
        local zonedug        = '[DIG]ZONE'..player:getZoneID()..'_ITEMS'
        local zoneDugCurrent = GetServerVariable(zonedug)

        if moon < 50 then
            moon = 100 - moon -- This converts moon phase percent to a number that represents how FAR the moon phase is from 50
        end

        moonmodifier = 1 - (100 - moon) / 100 -- the more the moon phase is from 50, the closer we get to 100% on this modifier.

        if lastDigTime < (getMidnight() - 86400) then
            player:setCharVar('[DIG]DigCount', 0) -- Reset player dig count/fatigue.
        end

        if zoneDugCurrent + 1 > digZoneLimit then
            if skillRank < 10 and xi.settings.main.DIG_FATIGUE_SKILL_UP then -- Safety check. Let's not try to skill-up if at max skill.
                calculateSkillUp(player)
            end

            player:PrintToPlayer(findNothing, 13)
            player:setCharVar('[DIG]LastDigTime', os.time())

            return true
        end

        -- dig chance failure
        if roll > (digRate * moonmodifier * skillmodifier) then -- base digging rate is 85% and it is multiplied by the moon and skill modifiers
            player:PrintToPlayer(findNothing, 13)
            player:setCharVar('[DIG]LastDigTime', os.time())
        -- dig chance success
        else
            local itemId = getChocoboDiggingItem(player)
            -- success!
            if itemId ~= 0 then
                -- make sure we have enough room for the item
                if player:addItem(itemId) then
                    player:messageSpecial(text.ITEM_OBTAINED, itemId)
                    SetServerVariable(zonedug, zoneDugCurrent + 1)
                    updatePlayerDigCount(player, 1)
                else
                    player:messageSpecial(text.DIG_THROW_AWAY, itemId)
                    updatePlayerDigCount(player, 1)
                end

                player:triggerRoeEvent(xi.roe.triggers.chocoboDigSuccess)

            -- got a crystal ore, but lacked weather or skill to dig it up
            else
                player:PrintToPlayer(findNothing, 13)
                player:setCharVar('[DIG]LastDigTime', os.time())
            end
        end

        if skillRank < 10 then -- Safety check. Let's not try to skill-up if at max skill.
            calculateSkillUp(player)
        end

        return true
    end
end
