------------------------------------
-- Treasure Chests and Coffers
-- http://ffxiclopedia.wikia.com/wiki/Picking_your_Coffers_and_Chests
-- http://ffxiclopedia.wikia.com/wiki/Treasure_Chest_and_Coffer_Guide
------------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/zone")
------------------------------------

tpz = tpz or {}
tpz.treasure = tpz.treasure or {}

tpz.treasure.type =
{
    CHEST   = 1,
    COFFER  = 2,
}

local keyType =
{
    ZONE_KEY      = 1,
    THIEF_TOOLS   = 2,
    SKELETON_KEY  = 3,
    LIVING_KEY    = 4,
}

local treasureInfo =
{
    [tpz.treasure.type.CHEST] =
    {
        zone =
        {
            [tpz.zone.PSOXJA] = -- 9
            {
                treasureLvl = 53,
                key = 1064,
                map = tpz.ki.MAP_OF_PSOXJA,
                points =
                {
                    {-393.000,   16.000, -208.000,   0},
                    {-392.950,   16.000, -236.012,   0},
                    {-349.409,   16.000, -232.783,  20},
                    {-379.409,   16.000, -207.245,  64},
                    {-329.944,    0.247, -271.769, 192},
                    {-322.799,   32.000, -276.970, 161},
                    {-349.915,   32.247, -169.891,  64},
                    {-362.928,   32.000, -236.722, 161},
                    {-389.971,   32.247, -229.970,   0},
                },
                gil = {0.762, 5200, 12500},
                gem = {0.238, 811, 798, 815, 790, 799, 788, 808},
            },
            [tpz.zone.OLDTON_MOVALPOLOS] = -- 11
            {
                treasureLvl = 43,
                key = 1062,
                map = tpz.ki.MAP_OF_OLDTON_MOVALPOLOS,
                points =
                {
                    {-140.636,    7.999,  200.498, 192},
                    {-138.897,    8.000,  157.084,  66},
                    {-236.521,   12.001,   32.003,   0},
                    { -32.310,   12.001,  105.692, 192},
                    { -19.717,    7.973,   66.538, 235},
                    {  67.304,   15.973,  -95.506,  66},
                    { 156.833,   14.000,  -86.775, 192},
                    { 197.942,    7.995,  -76.187, 132},
                    { 186.486,    8.000,  -42.940, 128},
                    { -87.437,   22.927,  -37.080,  66},
                    {-141.654,    8.000, -251.000,  90},
                    {-142.762,    8.000, -310.777, 192},
                },
                gil = {0.731, 3200, 6400},
                gem = {0.269, 811, 808, 796, 799, 788, 815, 798},
            },
            [tpz.zone.SACRARIUM] = -- 28
            {
                treasureLvl = 53,
                key = 1061,
                points =
                {
                    { 179.709,   -7.693,  -97.007, 192},
                    { 111.451,   -2.000, -100.159,  65},
                    {   8.974,   -2.179, -133.075, 190},
                    { 260.391,    0.000,   21.487,  60},
                    { 177.600,    8.310,  100.000, 130},
                    {  89.034,   -2.000,   99.248, 190},
                    {  88.223,   -2.000,  -36.017,   0},
                    {  31.021,   -2.000,   99.013, 190},
                },
                gil = {0.929, 5100, 9900},
                gem = {0.071, 790, 799, 815, 788, 796},
            },
            [tpz.zone.FORT_GHELSBA] = -- 141
            {
                treasureLvl = 53,
                key = 1024,
                points =
                {
                    {  62.583,  -61.584,   21.578,  21},
                    { 177.589,  -84.118,   47.830,  77},
                    { 114.363,  -45.114,  104.614,   0},
                    { 165.383,  -32.000,  139.055, 135},
                    { 143.690,  -45.584, -102.603,  71},
                },
                gil = {0.500, 800, 2100},
                gem = {0.036, 814, 800, 795, 807, 806},
                item = {0.464, 16702},
            },
            [tpz.zone.YUGHOTT_GROTTO] = -- 142
            {
                treasureLvl = 53,
                key = 1024,
                points =
                {
                    { 143.385,  -12.362,  132.887,  15},
                    { 363.764,  -24.250,  167.509, 170},
                    { 216.953,  -12.468,   49.284, 110},
                    {  63.413,   -0.081,   11.611, 133},
                    {  12.770,   -0.383,   36.825,  65},
                    { -12.144,   -0.206,  -63.396, 230},
                    {-151.230,   -0.359,  -21.489, 253},
                },
                gil = {0.450, 800, 2350},
                gem = {0.100, 814, 800, 795, 807, 806},
                item = {0.450, 16702},
            },
            [tpz.zone.PALBOROUGH_MINES] = -- 143
            {
                treasureLvl = 43,
                key = 1025,
                misc =
                {
                    {
                        test = function(player) return player:getQuestStatus(BASTOK, tpz.quest.id.bastok.FADED_PROMISES) == QUEST_ACCEPTED and player:getCharVar("FadedPromises") == 2 and not player:hasKeyItem(tpz.ki.DIARY_OF_MUKUNDA) end,
                        code = function(player) npcUtil.giveKeyItem(player, tpz.ki.DIARY_OF_MUKUNDA) end,
                    },
                },
                points =
                {
                    { 250.037,  -32.069,  174.156, 227},
                    { 241.950,  -31.769,   59.927, 255},
                    { 259.068,  -31.625,  -71.901, 190},
                    { 219.331,  -31.595,    4.665,  60},
                    { 216.795,  -31.527,  -71.373, 197},
                    { 262.397,  -32.202,   87.518, 160},
                    { 179.993,  -31.956,   93.280, 190},
                    { 139.909,  -31.957,  146.845,  60},
                    {  99.115,  -32.000,   83.067, 209},
                    {  21.141,  -31.944,   81.473, 111},
                    {  59.776,  -31.592,    5.373,  60},
                    {  99.917,  -32.000,  -41.557,  60},
                },
                gil = {0.455, 840, 1600},
                gem = {0.136, 795, 800, 814, 807, 806, 809},
                item = {0.409, 17291},
            },
            [tpz.zone.GIDDEUS] = -- 145
            {
                treasureLvl = 43,
                key = 1026,
                points =
                {
                    {-158.563,    0.999, -226.058,  52},
                    {-103.777,   -0.900, -254.271, 150},
                    {-242.625,    0.935, -185.404,  70},
                    {-267.030,   -2.156, -263.207, 234},
                    { -23.626,    0.982, -105.747, 135},
                    {  63.712,   -0.900, -254.442, 235},
                    { 125.386,   -3.168, -259.326, 132},
                    { 100.137,    1.387, -230.499,   5},
                    { 113.058,    1.000, -224.402,  28},
                    { 182.259,    0.915, -230.619,   1},
                    { 213.192,   -2.309, -299.255, 236},
                },
                gil = {0.448, 800, 1600},
                gem = {0.069, 814, 800, 809, 795, 807, 806},
                item = {0.483, 13365},
            },
            [tpz.zone.BEADEAUX] = -- 147
            {
                treasureLvl = 53,
                key = 1034,
                points =
                {
                    {  81.814,   -3.250,    1.523, 238},
                    { 122.451,   -2.468,  132.482, 206},
                    { 159.081,   -3.275,   78.207,  18},
                    { 150.931,   -2.969,   30.893,  94},
                    { 252.520,   -3.000,  -56.725, 159},
                    { 161.465,   -3.000,  -58.075, 139},
                    { 274.491,   -3.249,   45.577, 210},
                    { 272.330,   -3.338,  125.156, 171},
                    { 170.554,   -3.000,  174.293,  40},
                    { 107.592,   -3.000,  215.188,  47},
                    {  82.216,   -3.196,  117.415, 167},
                    {  22.898,   -2.981,   84.606, 214},
                },
                gil = {0.152, 3440, 9000},
                gem = {0.090, 811, 790, 796, 798, 808, 815},
                item = {0.758, 13230},
            },
            [tpz.zone.DAVOI] = -- 149
            {
                treasureLvl = 43,
                key = 1033,
                points =
                {
                    { 235.907,    3.629, -251.378,  79},
                    { 290.556,    2.731, -291.040, 169},
                    { 297.370,    3.250, -219.350,  86},
                    { 327.747,    3.500, -190.758, 147},
                    { 165.449,   -0.632, -267.748, 190},
                    { 115.242,   -0.546, -252.004,  60},
                    {  65.686,    0.628, -347.556, 176},
                    {  63.105,   -2.659, -191.565, 133},
                    {-109.608,    2.693,   50.392,  99},
                    { -59.329,   -0.672,   10.691, 191},
                    { -59.163,   -0.459,   69.200,  64},
                    { -14.535,    0.583,  -67.930, 173},
                },
                gil = {0.429, 3060, 6320},
                gem = {0.107, 811, 790, 808, 796, 799, 788, 815, 798},
                item = {0.464, 13515},
            },
            [tpz.zone.CASTLE_OZTROJA] = -- 151
            {
                treasureLvl = 43,
                key = 1035,
                misc =
                {
                    {
                        test = function(player) return player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.SCATTERED_INTO_SHADOW) == QUEST_ACCEPTED and player:getCharVar("scatIntoShadowCS") == 1 and not player:hasItem(13121) end,
                        code = function(player) npcUtil.giveItem(player, 13121) end,
                    },
                },
                points =
                {
                    {   7.378,  -16.293, -193.590, 158},
                    { -52.531,   24.218,  -12.087,  96},
                    { -79.345,   23.731,  -39.930,  66},
                    {-107.048,   24.218,  -67.696, 223},
                    { 113.076,  -16.326,  -85.606,  43},
                    {  50.230,  -16.000, -186.078, 132},
                    {  66.460,   -4.285, -140.403,   0},
                    {-167.569,  -16.293,  193.410,  40},
                    {-274.293,  -16.285,  193.509, 230},
                    {-206.721,  -16.000,   85.103, 192},
                    {-213.101,   -4.285,  139.820, 253},
                    {-102.026,  -52.000,  180.448,   5},
                    { -19.589,  -15.750,  -15.309,  65},
                },
                gil = {0.440, 3200, 6320},
                gem = {0.080, 811, 790, 808, 796, 788, 807, 815, 798},
                item = {0.480, 13840},
            },
            [tpz.zone.MIDDLE_DELKFUTTS_TOWER] = -- 157
            {
                treasureLvl = 43,
                key = 1036,
                misc =
                {
                    {
                        test = function(player) return player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.WINGS_OF_GOLD) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.GUIDING_BELL) end,
                        code = function(player) npcUtil.giveKeyItem(player, tpz.ki.GUIDING_BELL) end,
                    },
                },
                points =
                {
                    {-339.909, -127.601,   20.816, 254},
                    {-420.058, -127.601,   99.913,  65},
                    {-398.356, -127.424,   20.397, 255},
                    {-499.848, -127.601,   20.397,  65},
                    {-359.633, -111.424,  -39.286, 105},
                    {-416.369, -112.000,   62.454,  82},
                    {-425.616, -111.424,   -0.879,  60},
                    {-504.196, -112.000,   55.353, 247},
                },
                gil = {0.355, 2450, 7000},
                gem = {0.161, 814, 800, 809, 795, 796, 799, 806},
                item = {0.484, 16674},
            },
            [tpz.zone.UPPER_DELKFUTTS_TOWER] = -- 158
            {
                treasureLvl = 43,
                key = 1036,
                misc =
                {
                    {
                        test = function(player) return player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.WINGS_OF_GOLD) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.GUIDING_BELL) end,
                        code = function(player) npcUtil.giveKeyItem(player, tpz.ki.GUIDING_BELL) end,
                    },
                },
                points =
                {
                    {-380.060, -143.601,   20.603, 191},
                    {-333.356, -144.016,   -0.481, 255},
                    {-250.738, -144.019,   72.633, 231},
                    {-220.087, -143.601,   19.370, 191},
                },
                gil = {0.355, 2450, 7000},
                gem = {0.161, 814, 800, 809, 795, 796, 799, 806},
                item = {0.484, 16674},
            },
            [tpz.zone.CASTLE_ZVAHL_BAILEYS] = -- 161
            {
                treasureLvl = 53,
                key = 1038,
                misc =
                {
                    {
                        test = function(player) return player:getQuestStatus(BASTOK, tpz.quest.id.bastok.A_TEST_OF_TRUE_LOVE) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.UN_MOMENT) end,
                        code = function(player)
                            npcUtil.giveKeyItem(player, tpz.ki.UN_MOMENT)
                            player:addCharVar("ATestOfTrueLoveProgress", 1)
                        end,
                    },
                },
                points =
                {
                    { 110.041,  -20.002,  106.811, 190},
                    { -69.716,  -19.468,   35.659,   0},
                    {-120.003,  -24.000,  136.748, 190},
                    {-120.064,  -24.000,  103.328,  65},
                    {-119.996,  -24.000,  -63.515, 190},
                    {-119.933,  -24.000,  -95.999,  65},
                    { -19.920,  -20.010,  -29.472,  65},
                    {   9.900,  -20.000,   12.662,  65},
                    {   9.900,  -20.000,   27.921, 190},
                    { -20.354,  -20.200,   68.930, 190},
                    { 110.250,  -20.011,  -67.377,  65},
                    {  99.899,  -24.065,   64.915,  65},
                    {  99.899,  -24.077,  -25.562, 190},
                    {  57.319,  -24.000,   20.112,   0},
                    {  52.638,  -24.000,   20.112, 127},
                },
                gil = {0.382, 5000, 13950},
                gem = {0.008, 811, 790, 808, 788, 799, 815},
                item = {0.610, 13516},
            },
            [tpz.zone.CASTLE_ZVAHL_KEEP] = -- 162
            {
                treasureLvl = 53,
                key = 1038,
                misc =
                {
                    {
                        test = function(player) return player:getQuestStatus(BASTOK, tpz.quest.id.bastok.A_TEST_OF_TRUE_LOVE) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.UN_MOMENT) end,
                        code = function(player)
                            npcUtil.giveKeyItem(player, tpz.ki.UN_MOMENT)
                            player:addCharVar("ATestOfTrueLoveProgress", 1)
                        end,
                    },
                },
                points =
                {
                    {-299.787,  -48.000,   24.873,  62},
                },
                gil = {0.306, 5000, 10000},
                gem = {0.204, 798, 790, 808, 788, 815, 796},
                item = {0.490, 13516},
            },
            [tpz.zone.SEA_SERPENT_GROTTO] = -- 176
            {
                treasureLvl = 53,
                key = 1055,
                map = tpz.ki.MAP_OF_THE_SEA_SERPENT_GROTTO,
                misc =
                {
                    {
                        test = function(player) return player:getQuestStatus(BASTOK, tpz.quest.id.bastok.A_TEST_OF_TRUE_LOVE) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.LEPHEMERE) end,
                        code = function(player)
                            npcUtil.giveKeyItem(player, tpz.ki.LEPHEMERE)
                            player:addCharVar("ATestOfTrueLoveProgress", 1)
                        end,
                    },
                },
                points =
                {
                    { 189.673,   18.999,   30.161, 129},
                    { 173.566,   20.431,   42.832,  16},
                    { 413.783,    8.448,  -60.001, 124},
                    { 290.249,    8.469,    1.592,  12},
                    { 333.903,   18.404,   19.769, 128},
                    { 294.336,   18.301,  103.706,  73},
                    { 295.728,   25.854,  187.175, 244},
                    { 292.495,   28.200,  209.096, 254},
                    { 259.991,   28.488,  173.653,  64},
                    { 253.479,    8.156,   48.403, 217},
                    { 186.575,    8.570,   99.976,   3},
                },
                gil = {0.929, 3355, 8900},
                gem = {0.071, 811, 808, 790, 796, 815, 788, 799, 798},
            },
            [tpz.zone.KING_RANPERRES_TOMB] = -- 190
            {
                treasureLvl = 43,
                key = 1027,
                points =
                {
                    { 150.304,    0.000,  245.834, 250},
                    { 150.304,    0.000,  193.493, 250},
                    { 236.549,   -0.210,  149.944, 126},
                    { 203.316,    0.000,  140.128, 250},
                    { 203.316,    0.000,  129.619, 250},
                    { 203.316,    0.000,  119.546, 250},
                    { 213.959,    0.000,  129.619, 126},
                    { 236.549,   -0.169,  109.991, 126},
                    { 150.702,    0.000,   85.374, 250},
                    { 150.702,    0.000,   33.969, 250},
                    { -19.585,    6.630,   14.74, 171},
                    {-118.680,    9.000,   60.010,   0},
                    { -56.994,    7.359,  155.155, 194},
                    { -40.195,   -0.008, -130.093, 193},
                },
                gil = {0.474, 390, 1300},
                gem = {0.093, 814, 800, 809, 795, 807, 806},
                item = {0.433, 12799},
            },
            [tpz.zone.DANGRUF_WADI] = -- 191
            {
                treasureLvl = 43,
                key = 1028,
                points =
                {
                    {-499.709,    3.262,  215.970, 254},
                    {-117.128,    3.970,  134.104,  73},
                    { -60.745,    3.063,  295.362, 105},
                    { -62.183,    3.215,  416.434, 105},
                    {-287.324,    3.538,  328.969,  27},
                    {-273.053,    4.406,  332.914,  50},
                    {-100.291,    3.277,  495.744,   0},
                    { -62.243,    0.228,  564.120,   0},
                    {-206.223,    3.874,  571.662,  60},
                    {-247.736,    3.743,  576.783,  60},
                    {-239.459,    4.000,  505.813, 190},
                    {-198.482,    4.000,  506.684, 190},
                    {-264.091,    3.255,  460.409,  60},
                    {-337.859,    3.228,  384.203, 223},
                    {-419.957,    3.876,  335.875, 195},
                },
                gil = {0.308, 450, 900},
                gem = {0.230, 814, 800, 809, 795, 807, 806},
                item = {0.462, 12341},
            },
            [tpz.zone.INNER_HORUTOTO_RUINS] = -- 192
            {
                treasureLvl = 43,
                key = 1029,
                points =
                {
                    {-177.956,   -0.002, -220.058, 125},
                },
                gil = {0.459, 450, 1034},
                gem = {0.109, 814, 800, 809, 795, 806},
                item = {0.432, 16719},
            },
            [tpz.zone.ORDELLES_CAVES] = -- 193
            {
                treasureLvl = 43,
                key = 1030,
                misc =
                {
                    {
                        test = function(player)
                            return player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.SIGNED_IN_BLOOD) == QUEST_ACCEPTED and player:getCharVar("SIGNED_IN_BLOOD_Prog") >= 1 and not player:hasKeyItem(tpz.ki.TORN_OUT_PAGES)
                        end,
                        code = function(player) npcUtil.giveKeyItem(player, tpz.ki.TORN_OUT_PAGES) end,
                    },
                    {
                        test = function(player)
                            return player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_GOBLIN_TAILOR) >= QUEST_ACCEPTED and VanadielRSELocation() == 0 and VanadielRSERace() == player:getRace() and not player:hasKeyItem(tpz.ki.MAGICAL_PATTERN)
                        end,
                        code = function(player) npcUtil.giveKeyItem(player, tpz.ki.MAGICAL_PATTERN) end,
                    },
                },
                points =
                {
                    {-111.515,   27.986,  -90.305, 165},
                    {-109.446,   -0.021,  -90.724, 150},
                    {-108.188,   28.338,  -29.797, 103},
                    {-168.397,   28.112,  -28.818,  40},
                    { -32.101,   -0.040,  -90.118, 192},
                    { -50.539,   27.989,  -88.427, 236},
                    { -51.511,   28.085,  -28.593,   8},
                    { -15.960,   28.372,  -31.662, 198},
                    {  10.390,   28.396,  -30.526,  94},
                    {   8.064,   27.984,  -90.003, 185},
                    { -98.103,  -27.613, -285.174, 188},
                    {-140.193,    0.546,  176.329, 190},
                    {-112.788,   -0.035,  230.281, 194},
                    {-169.325,    0.008,  231.696, 236},
                    {-167.160,    0.068,  289.223,  62},
                },
                gil = {0.310, 1800, 3600},
                gem = {0.214, 800, 809, 806, 807, 796, 795, 814, 799},
                item = {0.476, 13222},
            },
            [tpz.zone.OUTER_HORUTOTO_RUINS] = -- 194
            {
                treasureLvl = 43,
                key = 1029,
                points =
                {
                    {-423.066,    0.000,  672.483, 250},
                },
                gil = {0.459, 450, 1034},
                gem = {0.109, 814, 800, 809, 795, 806},
                item = {0.432, 16719},
            },
            [tpz.zone.THE_ELDIEME_NECROPOLIS] = -- 195
            {
                treasureLvl = 53,
                key = 1039,
                points =
                {
                    { 171.927,   -7.999,   20.008, 254},
                    { 261.094,  -33.250,  100.014,   1},
                    {  98.908,  -33.250,  100.046, 127},
                    {  98.894,  -33.250,  -60.000, 127},
                    { 260.965,  -33.250,  -59.905,   1},
                    { 179.926,  -32.000,  -51.239, 193},
                    { 251.208,  -32.000,   20.054, 128},
                    {-518.830,   -8.000,  500.082,   1},
                    {-411.948,    8.000,  499.879, 127},
                    {-438.279,    0.350,  304.854, 190},
                },
                gil = {0.421, 5100, 12450},
                gem = {0.105, 811, 808, 796, 799, 815, 790},
                item = {0.474, 16771},
            },
            [tpz.zone.GUSGEN_MINES] = -- 196
            {
                treasureLvl = 43,
                key = 1031,
                misc =
                {
                    {
                        test = function(player)
                            return player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_GOBLIN_TAILOR) >= QUEST_ACCEPTED and VanadielRSELocation() == 1 and VanadielRSERace() == player:getRace() and not player:hasKeyItem(tpz.ki.MAGICAL_PATTERN)
                        end,
                        code = function(player) npcUtil.giveKeyItem(player, tpz.ki.MAGICAL_PATTERN) end,
                    },
                },
                points =
                {
                    { -14.130,  -39.999,  -85.554, 216},
                    {  58.307,  -39.959,  -52.149, 128},
                    { 141.517,  -41.565,   29.685, 204},
                    { 154.561,  -41.685,  220.130,  62},
                    {  25.952,  -40.100,  191.905,  62},
                    { -66.074,  -39.829,  250.589,  95},
                    {-137.702,  -41.291,   -6.666, 245},
                    {  -6.105,  -34.100,  113.459,  30},
                    {  -4.463,  -20.000,  125.082, 154},
                    {  47.060,  -20.199,  164.572, 128},
                    {  56.098,  -19.823,  147.475, 128},
                    {  50.596,  -19.842,  126.625, 153},
                },
                gil = {0.302, 1980, 3600},
                gem = {0.233, 806, 809, 814, 800, 796, 795, 799},
                item = {0.465, 12338, 17426},
            },
            [tpz.zone.CRAWLERS_NEST] = -- 197
            {
                treasureLvl = 43,
                key = 1040,
                misc =
                {
                    {
                        test = function(player) return player:getCharVar("needs_crawler_blood") == 1 end,
                        code = function(player)
                            npcUtil.giveKeyItem(player, tpz.ki.CRAWLER_BLOOD)
                            player:setCharVar("needs_crawler_blood", 0)
                        end,
                    },
                },
                points =
                {
                    {  39.767,   -0.178, -313.865,  13},
                    {  98.913,   -1.981, -344.437, 255},
                    {  -7.115,   -0.562, -382.455,  65},
                    {   9.410,   -0.930, -418.559, 199},
                    { -93.078,   -0.276, -393.625, 170},
                    { -57.575,   -0.238, -279.965, 255},
                    {  24.264,   -0.439,  165.450, 218},
                    {  11.445,   -0.168,  211.587,  20},
                    {  54.721,   -0.346,  233.897,  85},
                    {  35.373,   -0.586,  264.295, 148},
                    { -15.799,   -0.464,  245.820, 216},
                    { -32.961,   -0.351,  294.132,  24},
                    { -89.586,   -9.624,   95.296,  46},
                },
                gil = {0.394, 4702, 10000},
                gem = {0.162, 811, 790, 808, 796, 799, 788, 815, 798},
                item = {0.444, 16710},
            },
            [tpz.zone.MAZE_OF_SHAKHRAMI] = -- 198
            {
                treasureLvl = 43,
                key = 1032,
                misc =
                {
                    {
                        test = function(player)
                            return player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_GOBLIN_TAILOR) >= QUEST_ACCEPTED and VanadielRSELocation() == 2 and VanadielRSERace() == player:getRace() and not player:hasKeyItem(tpz.ki.MAGICAL_PATTERN)
                        end,
                        code = function(player) npcUtil.giveKeyItem(player, tpz.ki.MAGICAL_PATTERN) end,
                    },
                },
                points =
                {
                    { 290.287,   20.238, -138.060,   9},
                    { -36.474,    0.063,  -70.480,  94},
                    { 260.698,   -1.274,   54.472, 135},
                    { 125.956,   19.805,   10.593,  91},
                    { -54.923,   18.781,  -19.130,  33},
                    { -90.151,   15.670, -103.097, 143},
                    {-130.046,   19.263,  -43.970, 241},
                    { -58.153,   20.000,  -62.085, 211},
                    { -25.615,   19.763,  -52.841, 130},
                    {   0.785,   20.000, -165.362, 112},
                    { 397.238,   -0.351,  -29.854,  63},
                    { 219.757,   18.799,  -63.968,  19},
                    { 239.982,   20.322,  -69.393,  69},
                    { 216.466,   20.200, -144.039, 222},
                    { 231.585,   20.000, -193.004,  11},
                    { 270.951,   20.000, -247.144, 212},
                },
                gil = {0.525, 1800, 5200},
                gem = {0.060, 814, 800, 809, 795, 796, 799, 807, 806},
                item = {0.415, 17071},
            },
            [tpz.zone.GARLAIGE_CITADEL] = -- 200
            {
                treasureLvl = 53,
                key = 1041,
                points =
                {
                    {-163.053,    0.000,  351.988, 128},
                    {-352.798,   15.602,  266.998, 124},
                    { -84.561,    5.269,  139.762,   7},
                    { -62.448,    0.000,   88.577, 128},
                    {-122.826,    0.000,  112.010, 128},
                    {-220.049,    0.000,  167.949,  65},
                    {  14.274,    6.000,  214.198, 101},
                    {  -7.949,   -0.143,  296.822, 192},
                    { -88.405,    4.784,  299.916,   2},
                    {-142.400,    0.000,  328.437, 128},
                },
                gil = {0.576, 4425, 10000},
                gem = {0.059, 811, 790, 808, 796, 799, 788, 815, 798},
                item = {0.365, 13723},
            },
            [tpz.zone.FEIYIN] = -- 204
            {
                treasureLvl = 53,
                key = 1037,
                misc =
                {
                    {
                        test = function(player) return player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.SORCERY_OF_THE_NORTH) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.FEIYIN_MAGIC_TOME) end,
                        code = function(player) npcUtil.giveKeyItem(player, tpz.ki.FEIYIN_MAGIC_TOME) end,
                    },
                },
                points =
                {
                    { 170.680,  -24.000,  210.826,  91},
                    { 172.161,  -24.006,  -88.152, 156},
                    { 210.956,  -24.000,  -31.915, 131},
                    { 112.361,  -24.008,  -52.220, 226},
                    { 136.771,  -24.000,   43.430, 142},
                    { 102.932,  -24.000,   76.664,  23},
                    { 170.954,  -24.000,  131.078,  92},
                    {  28.788,  -16.000,  108.641, 228},
                    {  -8.153,  -16.000,   61.675, 232},
                    { -45.479,  -16.009,   93.216,  43},
                    {-116.587,  -16.000,   29.954,   2},
                    {-164.008,  -16.003,   95.594,  53},
                    {-190.058,  -16.000,    3.435, 193},
                    { -95.248,  -16.005,  164.285,  13},
                },
                gil = {0.469, 4050, 7920},
                gem = {0.091, 811, 790, 808, 796, 799, 788, 815, 798},
                item = {0.440, 13231},
            },
            [tpz.zone.LABYRINTH_OF_ONZOZO] = -- 213
            {
                treasureLvl = 43,
                key = 1056,
                map = tpz.ki.MAP_OF_THE_LABYRINTH_OF_ONZOZO,
                misc =
                {
                    {
                        test = function(player) return player:getQuestStatus(BASTOK, tpz.quest.id.bastok.A_TEST_OF_TRUE_LOVE) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.LANCIENNE) end,
                        code = function(player)
                            npcUtil.giveKeyItem(player, tpz.ki.LANCIENNE)
                            player:addCharVar("ATestOfTrueLoveProgress", 1)
                        end,
                    },
                },
                points =
                {
                    {  50.829,    3.684,  -27.560,   3},
                    { 168.573,    0.470, -139.665, 130},
                    { 110.267,    0.473,  -81.732,   8},
                    {  29.116,    0.000,  -76.713,  20},
                    {  49.899,    9.577,   53.460,  67},
                    {  26.995,    9.516,   23.172,   5},
                    {  -0.125,    9.741,  -52.931, 190},
                    { -52.487,   13.674,  -68.977, 206},
                    {-136.452,   -0.733,  167.586, 117},
                    { -79.866,    4.695,  -26.886,  71},
                    {-103.552,    4.516,  -93.353, 194},
                    {-132.942,    4.746,  -78.719, 254},
                    {-187.134,    8.952,  -62.005,  31},
                    {-165.973,    8.771,  -93.768, 138},
                },
                gil = {0.806, 3200, 11679},
                gem = {0.194, 811, 790, 808, 796, 799, 788, 815, 798},
            },
        },
    },

    -------------------------------------------------

    [tpz.treasure.type.COFFER] =
    {
        zone =
        {

            [tpz.zone.NEWTON_MOVALPOLOS] = -- 12
            {
                treasureLvl = 53,
                key = 1063,
                map = tpz.ki.MAP_OF_NEWTON_MOVALPOLOS,
                points =
                {
                    { -46.014,   17.980,  -26.274,  64},
                    { 348.964,   26.066,    8.791,  60},
                    { 212.428,   19.825,  -21.050,   0},
                    {   2.971,   16.000,  -22.634, 190},
                    { -68.858,   15.992,   30.021,   0},
                    { -24.070,   16.841,   18.666, 190},
                    { 140.090,   20.000,  -44.821,  60},
                    {  94.145,   15.995,   71.251,  90},
                    { 140.432,   19.989,   84.637, 190},
                },
                gil = {0.927, 9800, 19180},
                gem = {0.073, 791, 797, 784, 803, 805, 801, 802},
            },
            [tpz.zone.RUAUN_GARDENS] = -- 130
            {
                treasureLvl = 53,
                key = 1058,
                map = tpz.ki.MAP_OF_THE_RUAUN_GARDENS,
                points =
                {
                    {-306.824,  -23.999,  230.783, 155},
                    { -98.092,  -24.000,  369.754, 173},
                    {-149.167,  -40.200,  446.421,  52},
                    {  75.417,  -24.000,  412.146,  73},
                    { 285.520,   -2.600,  375.324, 105},
                    { 454.220,  -40.200,   29.944,  66},
                    { 378.977,   -8.000, -133.852,  80},
                    { 295.992,  -24.000, -241.582,  21},
                    { 128.749,  -34.000, -173.096, 110},
                    {-128.639,  -34.000, -173.254,  22},
                    {-377.675,  -40.200, -268.597, 230},
                    {-425.500,  -36.000,   69.185, 103},
                },
                gil = {0.821, 9576, 19460},
                gem = {0.179, 791, 801, 810, 784, 802, 797, 805, 803},
            },
            [tpz.zone.BEADEAUX] = -- 147
            {
                treasureLvl = 53,
                key = 1043,
                hands = {
                    [tpz.job.WHM] = true,
                },
                af =
                {
                    [tpz.job.BST] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_WILD_HANDS,     reward = 12646}, -- Beast Jackcoat
                    [tpz.job.PLD] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_STALWART_HANDS, reward = 14220}, -- Gallant Breeches
                    [tpz.job.MNK] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_STRIKING_HANDS, reward = 12639}, -- Temple Cyclas
                },
                points =
                {
                    { 216.974,   39.702,   68.790, 135},
                    { 369.956,   24.075,   59.954, 255},
                    { 414.430,   23.859,   91.361, 210},
                    { 380.187,   24.019,  150.749,  60},
                    { 330.943,   24.244,   99.591, 255},
                    { 256.112,   39.805,  149.514,  45},
                    { 187.398,   39.999,   95.752,  45},
                    { 170.601,   39.831,   25.066,  25},
                },
                gil = {0.375, 4700, 25000},
                gem = {0.240, 791, 801, 802, 797, 788, 803, 805, 810, 784},
                item = {0.385, 4820},
            },
            [tpz.zone.MONASTIC_CAVERN] = -- 150
            {
                treasureLvl = 53,
                key = 1042,
                hands = {
                    [tpz.job.THF] = true,
                },
                af =
                {
                    [tpz.job.DRK] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_SHADOWY_HANDS,   reward = 14221}, -- Chaos Flanchard
                    [tpz.job.RNG] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_CHASING_HANDS,   reward = 12648}, -- Hunter's Jerkin
                    [tpz.job.BLM] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_SORCEROUS_HANDS, reward = 12641}, -- Wizard's Coat
                },
                points =
                {
                    {   9.376,   -1.345, -223.188, 187},
                    { 106.335,   -0.829, -106.411, 148},
                    {  60.765,   -0.333,  -93.267,  45},
                    {  12.823,   -0.390, -144.714, 201},
                    {  37.379,   -0.687, -146.255, 168},
                    {  22.771,   -1.363, -130.966, 114},
                    {  17.613,   -1.386,  -91.632,  60},
                    { -65.136,   -0.739, -142.362,  32},
                    { -68.553,   -1.002, -186.570,  30},
                    { -21.343,   -0.797, -177.934, 107},
                },
                gil = {0.818, 7320, 14400},
                gem = {0.055, 801, 810, 784, 802, 797, 803},
                item = {0.127, 13398},
            },
            [tpz.zone.CASTLE_OZTROJA] = -- 151
            {
                treasureLvl = 53,
                key = 1044,
                af =
                {
                    [tpz.job.DRK] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_SHADOWY_HANDS,    reward = 12645}, -- Chaos Cuirass
                    [tpz.job.BRD] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_HARMONIOUS_HANDS, reward = 14223}, -- Choral Cannions
                    [tpz.job.THF] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_SNEAKY_HANDS,     reward = 14219}, -- Rogue's Culottes
                    [tpz.job.RDM] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_VERMILLION_HANDS, reward = 12642}, -- Warlock's Tabard
                },
                points =
                {
                    {-102.723,  -60.000, -222.555, 223},
                    {-266.089,  -15.750,  -20.133,   0},
                    {-262.641,  -20.000,  -60.291,   0},
                    {-144.194,  -39.729,  -15.149,  34},
                    { -80.274,  -40.203,  -80.277, 130},
                    { -15.114,  -39.745, -134.880, 100},
                    { -13.623,  -39.834, -184.540, 160},
                    { -60.369,  -71.750, -146.231, 193},
                    {-139.729,  -71.750,  -53.252,  63},
                    {-100.197,  -72.511,  -13.141,  65},
                },
                gil = {0.652, 7320, 18000},
                gem = {0.044, 791, 801, 810, 784, 802, 797, 803, 805},
                item = {0.304, 14670},
            },
            [tpz.zone.THE_BOYAHDA_TREE] = -- 153
            {
                treasureLvl = 53,
                key = 1052,
                map = tpz.ki.MAP_OF_THE_BOYAHDA_TREE,
                hands = {
                    [tpz.job.DRG] = true,
                },
                af =
                {
                    [tpz.job.NIN] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_LURKING_HANDS, reward = 13869}, -- Ninja Hatsuburi
                },
                points =
                {
                    {  28.477,    6.335,  145.925,  95},
                    { -62.707,    8.787,   80.017, 120},
                    {-100.194,    7.716,   71.802,   5},
                    {  26.121,    6.102,   95.937,  27},
                    {  68.144,    6.428,   54.531, 180},
                    { 108.235,    7.085,   26.143, 234},
                    { 136.094,   10.600,   26.152, 139},
                    { 176.461,    8.172,   65.105,  81},
                    { 184.816,    5.867,  -52.454, 200},
                    { 201.244,    8.791, -163.229,   0},
                    { 260.650,    8.445,  -73.685,  66},
                    { 215.152,    8.210,   16.315,  18},
                    { 251.260,    5.078,   24.927,  42},
                    { 251.809,    6.141,  -18.487,  12},
                },
                gil = {0.793, 7110, 20520},
                gem = {0.092, 791, 801, 810, 784, 802, 803, 805, 797},
                item = {0.115, 4447},
            },
            [tpz.zone.TEMPLE_OF_UGGALEPIH] = -- 159
            {
                treasureLvl = 53,
                key = 1049,
                map = tpz.ki.MAP_OF_THE_TEMPLE_OF_UGGALEPIH,
                af =
                {
                    [tpz.job.SMN] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_CALLING_HANDS, reward = 12650}, -- Evoker's Doublet
                    [tpz.job.SAM] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_LOYAL_HANDS,   reward = 13781}, -- Myochin Domaru
                },
                points =
                {
                    {-219.944,   -0.800,   30.638, 192},
                    {-130.001,    0.000,   32.935,  65},
                    {-220.044,    0.000,  -19.961, 255},
                    { -99.999,    0.000,  -15.989, 255},
                    {-122.910,   -0.079,  -30.315, 125},
                    {-149.978,    0.000,  -46.935,  65},
                    {-126.637,   -0.951,  -86.835,  65},
                    { -49.102,    0.453, -100.020, 255},
                    {  20.002,   -2.011, -143.061, 190},
                    { -65.184,    0.022,   27.081,  65},
                },
                gil = {0.846, 7320, 14400},
                gem = {0.154, 797, 801, 810, 802, 805, 803},
            },
            [tpz.zone.DEN_OF_RANCOR] = -- 160
            {
                treasureLvl = 53,
                key = 1050,
                map = tpz.ki.MAP_OF_THE_DEN_OF_RANCOR,
                points =
                {
                    { 371.199,   -5.059,  260.752,  95},
                    { -17.924,   36.239, -130.382,  65},
                    {  10.426,   36.024,  -83.844, 255},
                    { -27.783,   44.986,   19.830, 130},
                    {  20.967,   16.957,  -37.771, 188},
                    { -17.675,   15.350,  -69.098,  23},
                    {  59.457,   15.435,  -68.965,  95},
                    { 139.838,   15.080, -131.904, 190},
                    { 122.006,   15.312,  -56.013,  62},
                    { 142.462,   15.834,  -21.777, 105},
                    { 372.407,   -5.088,  340.338, 125},
                    { 460.201,    5.092,  331.775,  65},
                },
                gil = {0.700, 8000, 16770},
                gem = {0.300, 797, 805},
            },
            [tpz.zone.CASTLE_ZVAHL_BAILEYS] = -- 161
            {
                treasureLvl = 53,
                key = 1048,
                hands = {
                    [tpz.job.BRD] = true,
                },
                af =
                {
                    [tpz.job.WAR] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS, reward = 14214}, -- Fighter's Cuisses
                    [tpz.job.THF] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_SNEAKY_HANDS,  reward = 12643}, -- Rogue's Vest
                },
                misc =
                {
                    {
                        test = function(player) return player:getCharVar("UnderOathCS") == 3 end,
                        code = function(player) npcUtil.giveKeyItem(player, tpz.ki.MIQUES_PAINTBRUSH) end,
                    },
                },
                points =
                {
                    { -72.899,    0.137,   19.549, 125},
                    { -49.542,    0.137,   19.549,   0},
                    { -59.511,    0.137,   30.749, 190},
                    { -59.511,    0.137,   10.051,  65},
                    {-223.298,   -8.000, -143.759, 190},
                    {-223.298,   -8.000,  183.912,  65},
                    { 103.469,   -8.000, -143.759, 190},
                    { 103.469,   -8.000,  183.912,  65},
                },
                gil = {0.731, 6300, 26880},
                gem = {0.080, 791, 801, 810, 784, 802, 797, 803, 805},
                item = {0.189, 4995},
            },
            [tpz.zone.TORAIMARAI_CANAL] = -- 169
            {
                treasureLvl = 53,
                key = 1057,
                af =
                {
                    [tpz.job.SMN] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_CALLING_HANDS, reward = 14103}, -- Evoker's Pigaches
                },
                misc =
                {
                    {
                        test = function(player) return player:getCharVar("WildCard") == 2 end,
                        code = function(player)
                            npcUtil.giveKeyItem(player, tpz.ki.JOKER_CARD)
                            player:setCharVar("WildCard", 3)
                        end,
                    },
                },
                points =
                {
                    { 219.993,   16.003,  -49.049,  62},
                    { -88.634,   16.000,  -31.234, 192},
                    {-191.180,   21.502, -100.104,   0},
                    {-191.211,   21.502, -140.088,   0},
                    { -59.985,   21.502, -191.163, 192},
                    { 111.091,   21.502, -180.065, 128},
                    { 114.148,   16.000, -226.101, 192},
                    {  72.746,   16.000, -180.041, 128},
                    {  26.746,   16.500, -212.454, 226},
                    {   6.567,   16.000, -180.089,   0},
                    { 179.943,   21.502, -271.297, 192},
                    { 310.808,   21.502, -179.957, 128},
                    { 285.821,   18.000,  -59.620,  66},
                    { 143.977,    9.500, -103.950,  31},
                    {  95.977,   21.500,  -56.045, 159},
                },
                gil = {0.900, 7440, 14280},
                gem = {0.100, 791, 801, 784, 802, 797, 803, 805},
            },
            [tpz.zone.KUFTAL_TUNNEL] = -- 174
            {
                treasureLvl = 53,
                key = 1051,
                map = tpz.ki.MAP_OF_THE_KUFTAL_TUNNEL,
                hands = {
                    [tpz.job.SAM] = true,
                },
                misc =
                {
                    {
                        test = function(player) return player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.TRUE_WILL) == QUEST_ACCEPTED and player:getCharVar("trueWillCS") == 2 and not player:hasKeyItem(tpz.ki.LARGE_TRICK_BOX) end,
                        code = function(player) npcUtil.giveKeyItem(player, tpz.ki.LARGE_TRICK_BOX) end,
                    },
                    {
                        test = function(player) return player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.KNIGHT_STALKER) == QUEST_ACCEPTED and player:getCharVar("KnightStalker_Progress") == 1 end,
                        code = function(player) npcUtil.giveKeyItem(player, tpz.ki.CHALLENGE_TO_THE_ROYAL_KNIGHTS) end,
                    },
                },
                points =
                {
                    { 103.708,  -11.326,  208.367, 191},
                    { 127.993,  -11.318,   96.500,  13},
                    { 126.990,   -1.319,   49.802, 181},
                    { 154.813,  -10.473,  -68.138, 148},
                    {  41.657,  -11.623,   29.949, 106},
                    {  15.489,  -11.354,    8.337,   4},
                    { -10.184,   -1.373,  127.082,  45},
                    {  26.277,   -1.554,  134.207, 163},
                    { -15.217,   -1.907,   51.530, 196},
                    { -92.888,   -0.282,    2.676,  10},
                    { -14.067,  -11.940, -132.941, 192},
                    { -25.934,  -11.000, -142.247,  61},
                    { -27.946,  -21.825, -183.709,  30},
                },
                gil = {0.943, 5200, 16100},
                gem = {0.057, 802, 801, 797, 784, 803, 791, 805, 810},
            },
            [tpz.zone.SEA_SERPENT_GROTTO] = -- 176
            {
                treasureLvl = 53,
                key = 1059,
                map = tpz.ki.MAP_OF_THE_SEA_SERPENT_GROTTO,
                hands = {
                    [tpz.job.SMN] = true,
                },
                af =
                {
                    [tpz.job.NIN] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_LURKING_HANDS, reward = 14101}, -- Ninja Kyahan
                },
                points =
                {
                    {-184.862,   17.989, -108.860, 207},
                    {-130.961,   29.207,   19.947,   4},
                    {-106.972,   19.055,  -65.469, 114},
                    {-168.173,   18.653,  -92.826,  35},
                    {-130.746,   20.058,  -24.084, 141},
                    {-188.832,   19.446,   56.939, 254},
                    {-220.245,   18.466,   53.843,  65},
                    {-288.582,   17.787,  -73.885, 149},
                    {-227.255,   10.000,  -65.473, 174},
                    {-259.927,    8.705, -133.028, 191},
                    {-356.233,   15.475, -104.030, 254},
                },
                gil = {0.550, 6145, 19580},
                gem = {0.450, 791, 810, 784, 802, 803, 797, 801},
            },
            [tpz.zone.VELUGANNON_PALACE] = -- 177
            {
                treasureLvl = 53,
                key = 1060,
                map = tpz.ki.MAP_OF_THE_VELUGANNON_PALACE,
                points =
                {
                    { 101.588,   15.837,  380.587,   1},
                    {-380.368,   15.700, -220.126, 128},
                    {-459.988,   16.000,  -73.829, 193},
                    {-434.639,   15.783,  300.084,   0},
                    {-180.435,   15.571,  420.049,   0},
                    { 379.990,   16.000,  394.593,  65},
                    { 434.650,   16.000,  300.083, 128},
                    { 459.977,   16.000,   74.027,  65},
                    { 379.929,   15.574, -219.582,  65},
                },
                gil = {0.500, 9940, 18900},
                gem = {0.500, 791, 805},
            },
            [tpz.zone.THE_ELDIEME_NECROPOLIS] = -- 195
            {
                treasureLvl = 53,
                key = 1046,
                hands = {
                    [tpz.job.WAR] = true,
                    [tpz.job.RDM] = true,
                    [tpz.job.PLD] = true,
                    [tpz.job.DRK] = true,
                },
                af =
                {
                    [tpz.job.BLM] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_SORCEROUS_HANDS, reward = 14217}, -- Wizard's Tonban
                },
                points =
                {
                    { 159.011,  -27.999,  161.005,  31},
                    { 179.864,  -32.000,   91.100,  64},
                    { 108.749,  -32.000,   19.951,   1},
                    {  39.264,  -28.000,   -0.712, 223},
                    { 174.753,   -0.418, -100.369,   6},
                    { 299.967,    0.000,   69.413,  63},
                    { 300.082,    0.000,  -29.448, 194},
                    { 188.319,   -0.590,  128.702, 174},
                    {-386.548,   -3.000,  335.046,   2},
                },
                gil = {0.500, 7590, 18039},
                gem = {0.250, 801, 810, 802, 797, 803},
                item = {0.250, 4175},
            },
            [tpz.zone.CRAWLERS_NEST] = -- 197
            {
                treasureLvl = 53,
                key = 1045,
                hands = {
                    [tpz.job.MNK] = true,
                    [tpz.job.BST] = true,
                },
                af =
                {
                    [tpz.job.BRD] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_HARMONIOUS_HANDS, reward = 13857}, -- Choral Roundlet
                    [tpz.job.WAR] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS,    reward = 12511}, -- Fighter's Mask
                    [tpz.job.WHM] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_HEALING_HANDS,    reward = 14216}, -- Healer's Pantaloons
                    [tpz.job.RNG] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_CHASING_HANDS,    reward = 14224}, -- Hunter's Braccae
                },
                points =
                {
                    { -95.676,   -0.436,  205.557, 211},
                    {-103.267,   -1.766, -392.964, 229},
                    {-185.774,   -0.282, -379.022, 235},
                    { -45.265,   -0.477,  224.265, 150},
                    {-113.889,   -0.449,  255.583,  22},
                    {-129.480,   -0.945,  378.933,  74},
                    {-150.126,   -0.904,  341.438, 206},
                },
                gil = {0.387, 6040, 12100},
                gem = {0.387, 791, 801, 784, 797, 805, 803},
                item = {0.226, 4173},
            },
            [tpz.zone.GARLAIGE_CITADEL] = -- 200
            {
                treasureLvl = 53,
                key = 1047,
                hands = {
                    [tpz.job.BLM] = true,
                    [tpz.job.RNG] = true,
                },
                af =
                {
                    [tpz.job.BST] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_WILD_HANDS,       reward = 12517}, -- Beast Helm
                    [tpz.job.PLD] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_STALWART_HANDS,   reward = 12515}, -- Gallant Coronet
                    [tpz.job.WHM] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_HEALING_HANDS,    reward = 13855}, -- Healer's Cap
                    [tpz.job.MNK] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_STRIKING_HANDS,   reward = 12512}, -- Temple Crown
                    [tpz.job.RDM] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_VERMILLION_HANDS, reward = 14218}, -- Warlock's Tights
                },
                points =
                {
                    {   9.831,    5.781,   10.208, 247},
                    { -20.193,    5.144,   85.064,  65},
                    { 100.057,   -3.250,  103.200,  65},
                    {-183.168,   -3.250,   59.951,   0},
                    {-127.756,    0.000,  379.906,   0},
                    { -20.570,   -3.250,  296.848, 193},
                    {  20.042,   -9.250,  376.955, 193},
                },
                gil = {0.750, 6668, 18700},
                gem = {0.125, 801, 784, 802},
                item = {0.125, 13977},
            },
            [tpz.zone.IFRITS_CAULDRON] = -- 205
            {
                treasureLvl = 53,
                key = 1053,
                map = tpz.ki.MAP_OF_IFRITS_CAULDRON,
                hands = {
                    [tpz.job.NIN] = true,
                },
                af =
                {
                    [tpz.job.DRG] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_DRAGON_HANDS, reward = 12649}, -- Drachen Mail
                },
                points =
                {
                    { 190.735,   -0.191,  -30.485, 159},
                    { -71.694,   19.585,  -21.956, 208},
                    { -64.669,   20.035,  -38.858,  58},
                    {  24.680,   20.033,  -38.530,  74},
                    {  51.015,   17.523, -131.594,  57},
                    {  -8.835,   18.592, -128.882,  80},
                    { -97.569,    3.927, -183.248,  38},
                    { -21.635,   -1.884,  -71.206, 231},
                    {  31.185,   -1.912,  -18.542,  86},
                    { 102.903,    3.939,  -97.614, 227},
                    { -67.400,    0.000,  -39.111,   2},
                    { -67.099,    0.000,   -0.796, 255},
                    { 160.900,   -0.068,  -22.165, 182},
                },
                gil = {0.897, 7200, 21060},
                gem = {0.103, 802, 797, 803, 801, 810, 791},
            },
            [tpz.zone.QUICKSAND_CAVES] = -- 208
            {
                treasureLvl = 53,
                key = 1054,
                map = tpz.ki.MAP_OF_THE_QUICKSAND_CAVES,
                af =
                {
                    [tpz.job.DRG] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_DRAGON_HANDS, reward = 14102}, -- Drachen Greaves
                    [tpz.job.SAM] = {quest = tpz.quest.id.jeuno.BORGHERTZ_S_LOYAL_HANDS,  reward = 14225}, -- Myochin Haidate
                },
                points =
                {
                    { 613.598,   -6.057, -680.984, 255},
                    { 540.553,  -16.920, -770.118, 192},
                    { 429.401,  -16.890, -739.502, 255},
                    { 495.848,  -10.863, -827.019, 194},
                    { 629.929,  -16.899, -820.711, 255},
                    { 740.357,  -16.877, -789.623,  66},
                    { 826.074,  -11.118, -733.808,  94},
                    { 867.442,    1.146, -708.477, 156},
                    { 865.615,    1.942, -622.742,  27},
                    { 677.287,    3.220, -581.735, 192},
                },
                gil = {0.773, 6160, 16100},
                gem = {0.227, 791, 801, 810, 784, 797, 803}
            },
        },
    },
}

-------------------------------------------------
-- local functions
-------------------------------------------------

local function doMove(npc, x, y, z)
    return function(entity)
        entity:setPos(x, y, z, 0)
    end
end

local function moveChest(npc, zoneId, chestType, mimicSpawned)
    local points = treasureInfo[chestType].zone[zoneId].points
    local point = points[math.random(#points)]
    if not mimicSpawned then
        npc:hideNPC(5)
    end
    npc:queue(3000, doMove(npc, unpack(point)))
end

local function spawnMimic(player, npc)
    local zoneId = player:getZoneID()
    local ID = zones[zoneId]
    local mimicId = ID.mob.MIMIC

    if mimicId then
        GetMobByID(mimicId):setSpawn(npc:getXPos(), npc:getYPos(), npc:getZPos(), npc:getRotPos())
        npcUtil.popFromQM(player, npc, mimicId, {claim=true, hide=5})
        moveChest(npc, zoneId, tpz.treasure.type.COFFER, true)
    else
        printf("treasure.lua MIMIC id missing in zoneId %i", zoneId)
    end
end

-------------------------------------------------
-- public functions
-------------------------------------------------

tpz.treasure.initZone = function(zone)
    local zoneId = zone:getID()
    local ID = zones[zoneId]

    if ID.npc.TREASURE_CHEST then
        local npc = GetNPCByID(ID.npc.TREASURE_CHEST)
        if npc then
            npc:setStatus(tpz.status.NORMAL)
            moveChest(npc, zoneId, tpz.treasure.type.CHEST)
        end
    end

    if ID.npc.TREASURE_COFFER then
        local npc = GetNPCByID(ID.npc.TREASURE_COFFER)
        if npc then
            npc:setStatus(tpz.status.NORMAL)
            moveChest(npc, zoneId, tpz.treasure.type.COFFER)
        end
    end
end

--[[
    -- msgBase offsets
    0 You unlock the chest!
    1 <name> fails to open the chest.
    2 The chest was trapped!
    3 You cannot open the chest when you are in a weakened state.
    4 The chest was a mimic!
    5 You cannot open the chest while participating in the moogle event.
    6 The chest was but an illusion...
    7 The chest appears to be locked. If only you had <item>, perhaps you could open it...
--]]

tpz.treasure.onTrade = function(player, npc, trade, chestType)
    local zoneId = player:getZoneID()
    local ID = zones[zoneId]
    local msgBase = ID.text.CHEST_UNLOCKED
    local info = treasureInfo[chestType].zone[zoneId]
    local mJob = player:getMainJob()
    local mLvl = player:getMainLvl()
    local activeHands = player:getCharVar("BorghertzAlreadyActiveWithJob")
    local illusionCooldown  = npc:getLocalVar("illusionCooldown")

    -- determine type of key traded
    local keyTraded = nil
    if npcUtil.tradeHasExactly(trade, info.key) then
        keyTraded = keyType.ZONE_KEY
    elseif npcUtil.tradeHasExactly(trade, 1022) then
        keyTraded = keyType.THIEF_TOOLS
    elseif npcUtil.tradeHasExactly(trade, 1115) then
        keyTraded = keyType.SKELETON_KEY
    elseif npcUtil.tradeHasExactly(trade, 1023) then
        keyTraded = keyType.LIVING_KEY
    end

    -- invalid trade: show default locked message
    if not keyTraded then
        player:messageSpecial(msgBase + 7, info.key)
        return
    end

    -- lockpick
    if keyTraded ~= keyType.ZONE_KEY then

        -- can't lockpick while weakened
        if player:hasStatusEffect(tpz.effect.WEAKNESS) then
            player:messageSpecial(msgBase + 3)
            return
        end

        -- determine chance of success
        if mJob ~= tpz.job.THF or mLvl < (info.treasureLvl - 10) then
            success = 0
        elseif keyTraded == keyType.SKELETON_KEY then
            success = (mLvl / info.treasureLvl) - 0.50 + 0.2
        elseif keyTraded == keyType.LIVING_KEY then
            success = (mLvl / info.treasureLvl) - 0.50 + 0.15
        elseif keyTraded == keyType.THIEF_TOOLS then
            success = (mLvl / info.treasureLvl) - 0.50 + 0.1
        end

        -- failed lockpick
        if math.random() > success then
            -- take key
            player:confirmTrade()

            -- determine type of failure
            local failureType = 1
            if chestType == tpz.treasure.type.COFFER then
                failureType = math.random(3)
            else
                failureType = math.random(2)
            end

            if failureType == 1 then
                player:messageSpecial(msgBase + 1, player:getID()) -- "<name> fails to open the chest."
            elseif failureType == 2 then
                player:messageSpecial(msgBase + 2) -- "The chest was trapped!"
                player:addStatusEffect(tpz.effect.WEAKNESS, 1, 0, math.random(300, 10800)) -- 5 minutes to 3 hours
            else
                player:messageSpecial(msgBase + 4) -- "The chest was a mimic!"
                spawnMimic(player, npc)
            end

            return
        end
    end

    -- old gauntlets
    if
        chestType == tpz.treasure.type.COFFER and
        activeHands > 0 and
        info.hands and
        info.hands[activeHands] and
        not player:hasKeyItem(tpz.ki.OLD_GAUNTLETS)
    then
        player:messageSpecial(msgBase)
        npcUtil.giveKeyItem(player, tpz.ki.OLD_GAUNTLETS)
        player:confirmTrade()
        moveChest(npc, zoneId, chestType)
        return
    end

    -- artifact armor
    if
        chestType == tpz.treasure.type.COFFER and
        info.af and
        info.af[mJob] and
        player:getQuestStatus(JEUNO, info.af[mJob].quest) >= QUEST_ACCEPTED and
        not player:hasItem(info.af[mJob].reward)
    then
        player:messageSpecial(msgBase)
        if npcUtil.giveItem(player, info.af[mJob].reward) then
            player:confirmTrade()
            moveChest(npc, zoneId, chestType)
        end
        return
    end

    -- miscellaneous quests
    if info.misc then
        for _, v in pairs(info.misc) do
            if v.test(player) then
                player:messageSpecial(msgBase)
                v.code(player)
                player:confirmTrade()
                moveChest(npc, zoneId, chestType)
                return
            end
        end
    end

    -- map
    if info.map and not player:hasKeyItem(info.map) then
        player:messageSpecial(msgBase)
        npcUtil.giveKeyItem(player, info.map)
        player:confirmTrade()
        moveChest(npc, zoneId, chestType)
        return
    end

    -- illusion: do not consume tool, and relocate chest after short delay
    if os.time() < illusionCooldown then
        player:messageSpecial(msgBase + 6)
        moveChest(npc, zoneId, chestType)
        return
    end

    -- non-quest reward
    player:messageSpecial(msgBase)

    -- make a weighed roll to pick gil, gem, or item reward, so they don't need to sum to 1 anymore
    local sum = info.gil[1] + info.gem[1]
    if info.item then
        sum = sum + info.item[1]
    end
    sum = sum * 1000
    local roll = math.random(0, sum) / 1000

    -- gil
    if roll <= info.gil[1] then
        local partyMembers = player:getAlliance()
        local membersInZone = {}
        for i = 1, #partyMembers do
            if player:getZoneID() == partyMembers[i]:getZoneID() then
                table.insert(membersInZone, partyMembers[i])
            end
        end
        local gilAmount = math.random(info.gil[2], info.gil[3])
        local gil = gilAmount/#membersInZone
        for i = 1, #membersInZone do
            membersInZone[i]:addGil(gil)
            membersInZone[i]:messageSpecial(ID.text.GIL_OBTAINED, gil)
        end

    -- gem
    elseif roll <= (info.gil[1] + info.gem[1]) then
        local gemIndex = math.random(table.getn(info.gem) - 1) + 1
        player:addTreasure(info.gem[gemIndex], npc)

    -- item
    elseif info.item then
        local itemIndex = math.random(table.getn(info.item) - 1) + 1
        player:addTreasure(info.item[itemIndex], npc)
    end

    player:confirmTrade()
    if chestType == tpz.treasure.type.CHEST then
        npc:setLocalVar("illusionCooldown", os.time() + math.random(CHEST_MIN_ILLUSION_TIME, CHEST_MAX_ILLUSION_TIME))
    else
        npc:setLocalVar("illusionCooldown", os.time() + math.random(COFFER_MIN_ILLUSION_TIME, COFFER_MAX_ILLUSION_TIME))
    end
    moveChest(npc, zoneId, chestType)
end

tpz.treasure.onTrigger = function(player, chestType)
    local zoneId = player:getZoneID()
    local msgBase = zones[zoneId].text.CHEST_UNLOCKED
    local info = treasureInfo[chestType].zone[zoneId]

    player:messageSpecial(msgBase + 7, info.key)
end
