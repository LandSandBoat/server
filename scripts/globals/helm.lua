-----------------------------------
-- Harvesting, Excavation, Logging, Mining
-- https://ffxiclopedia.wikia.com/wiki/Harvesting
-- https://ffxiclopedia.wikia.com/wiki/Excavation
-- https://ffxiclopedia.wikia.com/wiki/Logging
-- https://ffxiclopedia.wikia.com/wiki/Mining
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/roe')
require('scripts/missions/amk/helpers')
require('scripts/missions/wotg/helpers')
-----------------------------------
xi = xi or {}
xi.helm = xi.helm or {}

xi.helm.type =
{
    HARVESTING = 1,
    EXCAVATION = 2,
    LOGGING    = 3,
    MINING     = 4,
}

-----------------------------------
-- drops are { weight, itemId }
-- (R) for retail-verified coordinates
-----------------------------------

local helmInfo =
{
    [xi.helm.type.HARVESTING] =
    {
        id           = 'HARVESTING',
        animation    = xi.emote.HARVESTING,
        mod          = xi.mod.HARVESTING_RESULT,
        settingRate  = xi.settings.main.HARVESTING_RATE,
        settingBreak = xi.settings.main.HARVESTING_BREAK_CHANCE,
        message      = 'HARVESTING_IS_POSSIBLE_HERE',
        tool         = xi.item.SICKLE,

        zone =
        {
            [xi.zone.WAJAOM_WOODLANDS] =
            {
                drops =
                {
                    { 1880, xi.item.SPRIG_OF_FRESH_MARJORAM      },
                    { 1060, xi.item.BAG_OF_SIMSIM                },
                    { 1310, xi.item.CLUMP_OF_MOHBWA_GRASS        },
                    { 1760, xi.item.PEPHEDRO_HIVE_CHIP           },
                    {  590, xi.item.EGGPLANT                     },
                    {  960, xi.item.BAG_OF_COFFEE_CHERRIES       },
                    {  450, xi.item.EASTERN_GINGER_ROOT          },
                    {  860, xi.item.CLUMP_OF_IMPERIAL_TEA_LEAVES },
                    {  470, xi.item.CLUMP_OF_RED_MOKO_GRASS      },
                    {  430, xi.item.SPRIG_OF_FRESH_MUGWORT       },
                    {  240, xi.item.WIJNRUIT                     },
                },

                points =
                {
                    { -672.000,  -9.000,  -98.000 },
                    { -627.523, -16.499, -170.648 },  -- (R)D-10
                    { -512.039,  -9.567,   52.392 },
                    { -494.000, -12.000,   38.000 },
                    { -263.000, -10.000, -496.000 },
                    { -226.018, -20.499, -427.732 },  -- (R)G-11
                    { -173.870, -19.269, -494.178 },  -- (R)G-12
                    { -105.863, -18.999, -549.446 },  -- (R)H-12
                    {  -92.755,  -9.914, -612.687 },  -- (R)H-13
                    {  -69.460, -15.749, -563.268 },
                    {  -54.692, -19.403, -391.613 },  -- (R)H-11
                    {  -18.261, -17.999, -258.059 },  -- (R)H-10
                    {    1.000, -16.000, -308.000 },
                    {   10.000, -16.000,   21.000 },
                    {  116.662, -23.750,  370.150 },  -- (R)I-6
                    {  119.060, -24.212,  314.353 },  -- (R)I-7
                    {  157.231, -26.000,  134.428 },  -- (R)I-8
                    {  213.094, -26.000,  283.819 },
                },
            },

            [xi.zone.BHAFLAU_THICKETS] =
            {
                drops =
                {
                    { 1510, xi.item.CLUMP_OF_MOHBWA_GRASS        },
                    { 1470, xi.item.SPRIG_OF_FRESH_MARJORAM      },
                    { 1480, xi.item.PEPHEDRO_HIVE_CHIP           },
                    { 1170, xi.item.BAG_OF_SIMSIM                },
                    { 1100, xi.item.CLUMP_OF_IMPERIAL_TEA_LEAVES },
                    { 1000, xi.item.BAG_OF_COFFEE_CHERRIES       },
                    {  510, xi.item.EGGPLANT                     },
                    {  580, xi.item.CLUMP_OF_RED_MOKO_GRASS      },
                    {  460, xi.item.SPRIG_OF_FRESH_MUGWORT       },
                    {  370, xi.item.WIJNRUIT                     },
                    {  360, xi.item.EASTERN_GINGER_ROOT          },
                },

                points =
                {
                    { 146.059, -16.499,  338.636 },  -- (R)G-8
                    { 172.610, -18.000,  325.926 },
                    { 175.034, -36.249,  515.783 },  -- (R)G-7
                    { 177.026, -18.207,  313.230 },  -- (R)G-8
                    { 211.644, -17.999,  377.011 },  -- (R)H-7
                    { 242.654, -31.830,  486.744 },  -- (R)H-7
                    { 292.001, -20.297,  402.706 },  -- (R)H-7
                    { 292.814, -28.262,  508.026 },
                    { 335.562, -25.114,  448.904 },  -- (R)H-7
                    { 336.927, -18.188,  393.128 },  -- (R)H-7
                },
            },

            [xi.zone.GRAUBERG_S] =
            {
                drops =
                {
                    { 1830, xi.item.CLUMP_OF_MOKO_GRASS     },
                    { 1850, xi.item.CLUMP_OF_RED_MOKO_GRASS },
                    { 1250, xi.item.BAG_OF_VEGETABLE_SEEDS  },
                    { 1560, xi.item.BURDOCK_ROOT            },
                    { 1060, xi.item.BAG_OF_GRAIN_SEEDS      },
                    { 1200, xi.item.BAG_OF_HERB_SEEDS       },
                    { 1270, xi.item.LESSER_CHIGOE           },
                    { 1160, xi.item.WINTERFLOWER            },
                },

                points =
                {
                    {  40.395, -16.458, -313.137 },
                    { 205.724, -15.962, -281.248 },
                    { 249.687,  -2.796, -309.275 },
                    { 314.531,  10.516, -337.111 },
                    { 358.720,   0.500, -287.350 },
                    { 482.951,  39.900, -401.927 },
                },
            },

            [xi.zone.WEST_SARUTABARUTA_S] =
            {
                drops =
                {
                    { 1630, xi.item.SPRIG_OF_FRESH_MARJORAM },
                    { 1580, xi.item.CLUMP_OF_MOKO_GRASS     },
                    { 1680, xi.item.BALL_OF_SARUTA_COTTON   },
                    {  890, xi.item.BURDOCK_ROOT            },
                    {  830, xi.item.CLUMP_OF_RED_MOKO_GRASS },
                    {  910, xi.item.FLAX_FLOWER             },
                    {  540, xi.item.BAG_OF_VEGETABLE_SEEDS  },
                    {  550, xi.item.SKULL_LOCUST            },
                    {  390, xi.item.SPRIG_OF_FRESH_MUGWORT  },
                    {  350, xi.item.KING_LOCUST             },
                    {  280, xi.item.BAG_OF_HERB_SEEDS       },
                    {  370, xi.item.BAG_OF_GRAIN_SEEDS      },
                },

                points =
                {
                    { -436.396, -28.036,  322.590 },
                    { -426.938, -27.991,  326.684 },
                    { -363.990, -16.464,  325.456 },
                    { -157.420, -17.258,  -97.549 },
                    { -105.093, -17.056,  -81.489 },
                    {  -41.743, -16.149,   -2.631 },
                },
            },

            [xi.zone.WEST_SARUTABARUTA] =
            {
                drops =
                {
                    { 1680, xi.item.CLUMP_OF_MOKO_GRASS             },
                    { 1290, xi.item.BALL_OF_SARUTA_COTTON           },
                    { 1180, xi.item.SPRIG_OF_FRESH_MARJORAM         },
                    { 1090, xi.item.CLUMP_OF_RED_MOKO_GRASS         },
                    {  920, xi.item.FLAX_FLOWER                     },
                    {  880, xi.item.SPRIG_OF_DYERS_WOAD             },
                    {  670, xi.item.BUNCH_OF_GYSAHL_GREENS          },
                    {  650, xi.item.CLUMP_OF_WINDURSTIAN_TEA_LEAVES },
                    {  480, xi.item.SKULL_LOCUST                    },
                    {  360, xi.item.WIJNRUIT                        },
                    {  320, xi.item.BAG_OF_VEGETABLE_SEEDS          },
                    {  210, xi.item.BAG_OF_HERB_SEEDS               },
                    {  190, xi.item.BAG_OF_GRAIN_SEEDS              },
                    {  160, xi.item.PIECE_OF_CRAWLER_COCOON         },
                    {   10, xi.item.SPRIG_OF_FRESH_MUGWORT          },
                },

                points =
                {
                    { -437.564, -28.414,  349.393 },
                    { -433.726, -28.143,  359.270 },
                    { -392.602, -28.175,  372.697 },
                    { -391.068, -27.890,  361.257 },
                    { -356.123, -20.537,  212.243 },
                    { -159.075, -16.103,  394.371 },
                },
            },

            [xi.zone.YUHTUNGA_JUNGLE] =
            {
                drops =
                {
                    { 4000, xi.item.WOOZYSHROOM     },
                    { 2000, xi.item.DANCESHROOM     },
                    { 2000, xi.item.SLEEPSHROOM     },
                    {  700, xi.item.SCREAM_FUNGUS   },
                    {  700, xi.item.PUFFBALL        },
                    {  300, xi.item.KING_TRUFFLE    },
                    {  300, xi.item.MUSHROOM_LOCUST },
                },

                points =
                {
                    { -650.923, 11.987,  -59.148 },
                    { -250.381, 12.358, -418.463 },
                    { -370.951, 12.426,  -99.086 },
                    {  -60.695,  8.121,  308.915 },
                    {  179.165,  7.985,  509.125 },
                },
            },

            [xi.zone.YHOATOR_JUNGLE] =
            {
                drops =
                {
                    { 4000, xi.item.WOOZYSHROOM     },
                    { 2000, xi.item.DANCESHROOM     },
                    { 2000, xi.item.SLEEPSHROOM     },
                    {  700, xi.item.SCREAM_FUNGUS   },
                    {  700, xi.item.CORAL_FUNGUS    },
                    {  300, xi.item.REISHI_MUSHROOM },
                    {  300, xi.item.MUSHROOM_LOCUST },
                },

                points =
                {
                    { -61.479,  8.475, -210.413 },
                    { 108.884,  8.263, -579.216 },
                    { 140.242, 12.319, -108.471 },
                    { 539.998,  7.964, -348.331 },
                },
            },

            [xi.zone.GIDDEUS] =
            {
                drops =
                {
                    { 1500, xi.item.CLUMP_OF_RED_MOKO_GRASS         },
                    { 1430, xi.item.SPRIG_OF_DYERS_WOAD             },
                    { 1430, xi.item.FLAX_FLOWER                     },
                    { 1400, xi.item.BALL_OF_SARUTA_COTTON           },
                    { 1210, xi.item.SPRIG_OF_FRESH_MARJORAM         },
                    { 1030, xi.item.CLUMP_OF_MOKO_GRASS             },
                    {  570, xi.item.CLUMP_OF_WINDURSTIAN_TEA_LEAVES },
                    {  520, xi.item.BUNCH_OF_GYSAHL_GREENS          },
                    {  440, xi.item.KING_LOCUST                     },
                    {  370, xi.item.WIJNRUIT                        },
                    {  230, xi.item.BAG_OF_GRAIN_SEEDS              },
                    {  210, xi.item.BAG_OF_HERB_SEEDS               },
                    {  200, xi.item.SPRIG_OF_FRESH_MUGWORT          },
                    {  190, xi.item.PIECE_OF_CRAWLER_COCOON         },
                    {  160, xi.item.BAG_OF_VEGETABLE_SEEDS          },
                },

                points =
                {
                    { -172.157,   0.999, -240.557 },  -- (R)F-11
                    { -151.868,   1.034, -253.653 },  -- (R)G-12
                    { -147.392,   0.899, -225.795 },  -- (R)G-11
                    { -136.130,   0.445, -105.579 },  -- (R)G-10
                    { -131.994,   0.999, -143.293 },
                    { -130.178,   1.003, -223.769 },  -- (R)G-11
                    { -114.369,   1.028, -254.640 },  -- (R)G-12
                    { -100.234,   0.999, -123.214 },  -- (R)G-10
                    {  -88.187,   0.990, -170.598 },  -- (R)G-11
                    {  -86.760,  -1.035,  -93.932 },  -- (R)G-10
                    {  -81.266,   0.999, -134.860 },  -- (R)H-10
                    {  -56.830,   0.967,  -64.066 },  -- (R)H-9
                    {  -48.923,   1.000,  -81.608 },
                    {  -48.674,   0.211, -131.659 },  -- (R)H-10
                    {  -27.667,   0.999, -118.469 },  -- (R)H-10
                    {   64.683,   1.042,  -91.841 },  -- (R)I-10
                    {   67.046,   1.096, -228.942 },  -- (R)I-11
                    {   70.370,   0.915, -125.264 },  -- (R)J-10
                    {   73.554,   0.979, -255.111 },  -- (R)I-12
                    {   79.169,   0.999,  -96.919 },  -- (R)I-10
                    {   89.595,  -0.592, -134.787 },  -- (R)J-10
                    {   91.514,  -0.468, -222.407 },  -- (R)J-11
                    {   93.845,   0.843,  -74.347 },  -- (R)J-9
                    {   95.663,  -1.442, -197.238 },  -- (R)J-11
                    {   96.135,   1.197, -113.206 },  -- (R)J-10
                    {  105.684,   0.785, -225.174 },  -- (R)J-11
                    {  106.571,  -3.405, -264.287 },  -- (R)J-12
                    {  110.600,   1.000, -240.900 },
                    {  120.195,   1.000, -123.556 },  -- (R)J-10
                    {  129.688,   0.573, -206.573 },  -- (R)J-11
                    {  133.626,   1.729, -186.761 },  -- (R)J-11
                    {  136.799,   0.682, -225.955 },  -- (R)J-11
                },
            },

            [xi.zone.ABYSSEA_GRAUBERG] =
            {
                drops =
                {
                    {  970, xi.item.BAG_OF_HERB_SEEDS        },
                    { 1330, xi.item.CLUMP_OF_MOKO_GRASS      },
                    {  880, xi.item.LESSER_CHIGOE            },
                    {  880, xi.item.BAG_OF_GRAIN_SEEDS       },
                    { 1180, xi.item.CLUMP_OF_RED_MOKO_GRASS  },
                    { 1000, xi.item.BURDOCK_ROOT             },
                    {  790, xi.item.BAG_OF_VEGETABLE_SEEDS   },
                    {  940, xi.item.BUNCH_OF_GRAUBERG_GREENS },
                },

                points =
                {
                    {  21.699, -28.069, -277.679 },
                    {  34.277, -16.453, -314.041 },
                    { 179.928, -17.122, -286.430 },
                    { 179.928, -17.122, -286.430 },
                    { 219.698,  -5.833, -307.260 },
                    { 276.849,  16.356, -406.434 },
                },
            },

            [xi.zone.YAHSE_HUNTING_GROUNDS] =
            {
                drops =
                {
                    -- TODO
                },
                points =
                {
                    -- TODO
                },
            },
        },
    },

    -----------------------------------

    [xi.helm.type.EXCAVATION] =
    {
        id           = 'EXCAVATION',
        animation    = xi.emote.EXCAVATION,
        mod          = nil,
        settingRate  = xi.settings.main.EXCAVATION_RATE,
        settingBreak = xi.settings.main.EXCAVATION_BREAK_CHANCE,
        message      = 'MINING_IS_POSSIBLE_HERE',
        tool         = xi.item.PICKAXE,

        zone =
        {
            [xi.zone.ATTOHWA_CHASM] =
            {
                drops =
                {
                    { 2220, xi.item.BONE_CHIP                   },
                    { 2220, xi.item.CHICKEN_BONE                },
                    { 1220, xi.item.BAT_FANG                    },
                    { 1220, xi.item.LITTLE_WORM                 },
                    {  720, xi.item.SCORPION_CLAW               },
                    {  720, xi.item.SCORPION_SHELL              },
                    {  420, xi.item.ANTLION_JAW                 },
                    {  420, xi.item.BAG_OF_CACTUS_STEMS         },
                    {  420, xi.item.HIGH_QUALITY_SCORPION_SHELL },
                    {  420, xi.item.RED_ROCK                    },
                },

                points =
                {
                    { -559.629, -13.114,  -88.864 },
                    { -328.481, -12.000,   68.200 },
                    { -343.760, -12.232,   66.061 },
                    { -375.399,  -3.264,  356.472 },
                    { -378.857,  -3.720,  342.842 },
                },
            },

            [xi.zone.TAHRONGI_CANYON] =
            {
                drops =
                {
                    { 2690, xi.item.BONE_CHIP      },
                    { 1830, xi.item.CHICKEN_BONE   },
                    { 1300, xi.item.BAT_FANG       },
                    { 1440, xi.item.GIANT_FEMUR    },
                    { 1250, xi.item.LITTLE_WORM    },
                    {   50, xi.item.SCORPION_CLAW  },
                    {  290, xi.item.SCORPION_SHELL },
                    {  240, xi.item.TURTLE_SHELL   },
                    {  190, xi.item.SACK_OF_SILICA },
                },

                points =
                {
                    { -431.357,  16.212,  403.870 },
                    { -430.459,  16.043,  432.710 },
                    { -410.614,  15.921,  406.142 },
                    { -402.544,  16.857,  422.846 },
                    { -394.414,  16.189,  429.645 },
                    { -385.442,  15.999,  405.979 },
                    {  198.504,  11.425,  100.823 },
                    {  208.640,   7.794,   84.708 },
                    {  218.195,   7.500,   62.938 },
                    {  345.129,  40.682,  477.808 },
                    {  349.811,  39.389,  503.690 },
                    {  359.168,  40.737,  504.589 },
                    {  384.409,  44.856,  517.706 },
                    {  391.380,  47.623,  493.986 },
                    {  425.145,  47.862,  487.601 },
                    {  439.581,  47.928,  475.796 },
                },
            },

            [xi.zone.KORROLOKA_TUNNEL] =
            {
                drops =
                {
                    { 2130, xi.item.CHUNK_OF_ROCK_SALT     },
                    { 1700, xi.item.SEASHELL               },
                    {  430, xi.item.CRAB_SHELL             },
                    { 1490, xi.item.FISH_SCALES            },
                    { 2130, xi.item.LUGWORM                },
                    { 1060, xi.item.SHELL_BUG              },
                    {  100, xi.item.CORAL_FRAGMENT         },
                    {  100, xi.item.BAG_OF_VEGETABLE_SEEDS },
                    {  430, xi.item.TURTLE_SHELL           },
                    {  100, xi.item.BAG_OF_GRAIN_SEEDS     },
                    {  640, xi.item.HELMET_MOLE            },
                },

                points =
                {
                    { -343.873,  -7.293,   90.243 },
                    { -223.228,  -2.330,  -16.983 },
                    { -184.039,  -7.080,   79.053 },
                    { -162.855,  -7.433,  135.520 },
                    { -146.129,  -0.971,  -82.968 },
                    { -102.172,  -1.953,  -30.428 },
                    {  -12.104,  -6.361,   95.735 },
                    {   61.417,   0.342,  -29.337 },
                    {   61.890,   0.012,   90.298 },
                },
            },

            [xi.zone.MAZE_OF_SHAKHRAMI] =
            {
                drops =
                {
                    { 2560, xi.item.BONE_CHIP      },
                    { 2560, xi.item.BAT_FANG       },
                    { 2330, xi.item.LITTLE_WORM    },
                    {  930, xi.item.GIANT_FEMUR    },
                    {  700, xi.item.SCORPION_CLAW  },
                    {  230, xi.item.SCORPION_SHELL },
                    {  230, xi.item.PETRIFIED_LOG  },
                    {  100, xi.item.RED_ROCK       },
                    {  470, xi.item.SACK_OF_SILICA },
                },

                points =
                {
                    { -117.322,   0.901,  -22.471 },
                    { -109.760,   0.277,  -35.497 },
                    {  -95.072,   0.407,  -27.887 },
                    {  -56.496,  -4.040,   14.833 },
                    {  -37.038,  -4.160,    8.707 },
                    {   82.317,   0.939,   57.508 },
                    {  123.376,   0.949,   28.916 },
                    {  170.729,   0.117,  -91.409 },
                    {  233.929,   0.307,   31.796 },
                    {  235.017,  -0.918, -107.491 },
                    {  255.110,   0.364, -169.030 },
                    {  255.750,  -0.179, -144.886 },
                    {  405.577,  -0.284,  -44.539 },
                },
            },
        },
    },

    -----------------------------------

    [xi.helm.type.LOGGING] =
    {
        id = 'LOGGING',
        animation    = xi.emote.LOGGING,
        mod          = xi.mod.LOGGING_RESULT,
        settingRate  = xi.settings.main.LOGGING_RATE,
        settingBreak = xi.settings.main.LOGGING_BREAK_CHANCE,
        message      = 'LOGGING_IS_POSSIBLE_HERE',
        tool         = xi.item.HATCHET,

        zone =
        {
            [xi.zone.CARPENTERS_LANDING] =
            {
                drops =
                {
                    { 1750, xi.item.WALNUT_LOG    },
                    { 1750, xi.item.WILLOW_LOG    },
                    { 1000, xi.item.YEW_LOG       },
                    {  750, xi.item.ARROWWOOD_LOG },
                    {  500, xi.item.ASH_LOG       },
                    {  500, xi.item.DRYAD_ROOT    },
                    {  250, xi.item.ACORN         },
                    {  100, xi.item.OAK_LOG       },
                },

                points =
                {
                    { -242.410,  -5.991,  -22.328 },
                    { -203.982,  -6.850, -118.981 },
                    { -203.024,  -6.850,  117.348 },
                },
            },

            [xi.zone.LUFAISE_MEADOWS] =
            {
                drops =
                {
                    { 3330, xi.item.ARROWWOOD_LOG },
                    { 1750, xi.item.ASH_LOG       },
                    { 2000, xi.item.MAPLE_LOG     },
                    { 1420, xi.item.FAERIE_APPLE  },
                    {  830, xi.item.WALNUT_LOG    },
                    {  170, xi.item.ACORN         },
                    {  330, xi.item.ELM_LOG       },
                    {  170, xi.item.OAK_LOG       },
                },

                points =
                {
                    { -218.855, -16.142,  286.809 },
                    { -212.218, -16.399,  316.257 },
                    {   93.994,  -9.035,  -55.871 },
                    {  120.026,  -8.607,   -9.430 },
                },
            },

            [xi.zone.MISAREAUX_COAST] =
            {
                drops =
                {
                    { 2220, xi.item.ARROWWOOD_LOG },
                    { 2220, xi.item.FAERIE_APPLE  },
                    { 2220, xi.item.ASH_LOG       },
                    { 2220, xi.item.MAPLE_LOG     },
                    {  100, xi.item.WALNUT_LOG    },
                    {  100, xi.item.ACORN         },
                    { 1110, xi.item.ELM_LOG       },
                    {  100, xi.item.OAK_LOG       },
                },

                points =
                {
                    { -323.737, -32.938,  203.954 },
                    { -288.729, -32.055,  140.837 },
                    { -260.170, -32.656,  174.636 },
                    { -213.362, -32.315,  150.466 },
                },
            },

            [xi.zone.MAMOOK] =
            {
                drops =
                {
                    { 1070, xi.item.ARROWWOOD_LOG        },
                    { 1070, xi.item.DOGWOOD_LOG          },
                    { 2300, xi.item.HANDFUL_OF_PINE_NUTS },
                    { 1070, xi.item.HANDFUL_OF_ALMONDS   },
                    {  500, xi.item.CHESTNUT_LOG         },
                    { 2300, xi.item.DATE                 },
                    {  500, xi.item.EBONY_LOG            },
                    {  500, xi.item.LAUAN_LOG            },
                    {  490, xi.item.ROSEWOOD_LOG         },
                    {  200, xi.item.BLOODWOOD_LOG        },
                },

                points =
                {
                    { -211.390, 13.457, -196.026 },
                    {   40.262, 13.757, -165.215 },
                    {  154.679, 13.627, -328.038 },
                    {  214.878, 13.883, -285.525 },
                    {  243.243, 13.635, -236.196 },
                },
            },

            [xi.zone.CAEDARVA_MIRE] =
            {
                drops =
                {
                    { 2200, xi.item.DOGWOOD_LOG          },
                    { 1520, xi.item.HANDFUL_OF_ALMONDS   },
                    { 1260, xi.item.ARROWWOOD_LOG        },
                    {  470, xi.item.CHESTNUT_LOG         },
                    {  680, xi.item.DATE                 },
                    {  940, xi.item.LAUAN_LOG            },
                    { 1150, xi.item.HANDFUL_OF_PINE_NUTS },
                    {  680, xi.item.ROSEWOOD_LOG         },
                    {  260, xi.item.BLOODWOOD_LOG        },
                    {  310, xi.item.EBONY_LOG            },
                },

                points =
                {
                    { -597.552,   2.990, -121.253 },
                    { -562.612,  -7.343,   56.605 },
                    { -494.911,  -8.994,   -6.408 },
                    {  175.217, -11.000, -186.769 },
                    {  443.342, -10.943, -332.972 },
                },
            },

            [xi.zone.EAST_RONFAURE_S] =
            {
                drops =
                {
                    { 1890, xi.item.ARROWWOOD_LOG      },
                    { 1400, xi.item.ASH_LOG            },
                    { 1430, xi.item.MAPLE_LOG          },
                    { 1270, xi.item.WALNUT             },
                    {  850, xi.item.CHESTNUT_LOG       },
                    { 1000, xi.item.RONFAURE_CHESTNUT  },
                    {  760, xi.item.WALNUT_LOG         },
                    {  490, xi.item.BAG_OF_FRUIT_SEEDS },
                    {   40, xi.item.JACARANDA_LOG      },
                    {  400, xi.item.OAK_LOG            },
                    {  290, xi.item.TEAK_LOG           },
                },

                points =
                {
                    { 222.991, -40.415,  44.056 },
                    { 345.419, -50.323, 117.994 },
                    { 350.243, -31.120, -46.766 },
                    { 354.731, -40.341,  41.963 },
                    { 452.671, -35.452, -18.765 },
                    { 531.209, -40.911,  62.020 },
                },
            },

            [xi.zone.JUGNER_FOREST_S] =
            {
                drops =
                {
                    { 2000, xi.item.WALNUT        },
                    { 1540, xi.item.WALNUT_LOG    },
                    { 1140, xi.item.ARROWWOOD_LOG },
                    { 1090, xi.item.ASH_LOG       },
                    {  860, xi.item.OAK_LOG       },
                    {  860, xi.item.WILLOW_LOG    },
                    {  510, xi.item.ACORN         },
                    {  170, xi.item.JACARANDA_LOG },
                    {  230, xi.item.TEAK_LOG      },
                },

                points =
                {
                    { -354.290, -1.097,  250.329 },
                    { -350.528, -1.309,  208.797 },
                    { -315.343, -0.267, -282.008 },
                    { -306.495, -1.426, -294.459 },
                    {  280.660, -8.300, -481.961 },
                    {  321.760,  0.396,  375.028 },
                },
            },

            [xi.zone.FORT_KARUGO_NARUGO_S] =
            {
                drops =
                {
                    { 2910, xi.item.FLASK_OF_HOLY_WATER },
                    { 2230, xi.item.PAIR_OF_NOPALES     },
                    { 1650, xi.item.DRAGON_FRUIT        },
                    { 1490, xi.item.BIRD_FEATHER        },
                    { 1250, xi.item.BIRD_EGG            },
                    {  170, xi.item.BAG_OF_CACTUS_STEMS },
                    {   50, xi.item.OPTICAL_NEEDLE      },
                },

                points =
                {
                    { -521.214, -13.000, -560.295 },
                    { -392.821, -21.748, -599.909 },
                    {  638.955,   2.343,    6.815 },
                    {  651.475,   3.371,   -3.022 },
                    {  712.770,   3.000,    3.157 },
                    {  717.546,  19.000,   79.003 },
                },
            },

            [xi.zone.EAST_RONFAURE] =
            {
                drops =
                {
                    { 2610, xi.item.ARROWWOOD_LOG      },
                    { 2030, xi.item.ASH_LOG            },
                    { 2570, xi.item.MAPLE_LOG          },
                    {  540, xi.item.CHESTNUT_LOG       },
                    {  580, xi.item.BAG_OF_FRUIT_SEEDS },
                    {  910, xi.item.YEW_LOG            },
                    {  410, xi.item.RONFAURE_CHESTNUT  },
                },

                points =
                {
                    { 196.373, -40.003,   35.752 },
                    { 209.782, -49.787,  141.166 },
                    { 250.523, -49.500,  161.705 },
                    { 284.853, -39.629,   29.429 },
                    { 305.741, -29.948, -116.309 },
                    { 325.402, -49.033,  192.153 },
                    { 341.363, -47.123,  101.801 },
                    { 351.158, -30.835,  -47.330 },
                    { 354.529, -39.894,   42.323 },
                    { 360.099, -19.500, -191.274 },
                    { 386.498, -20.311, -181.709 },
                    { 394.596, -10.089, -357.890 },
                    { 402.134, -39.517,   -6.029 },
                    { 411.102, -49.699,  160.998 },
                    { 425.535, -37.472,   25.342 },
                    { 441.810, -34.947,  -18.469 },
                    { 442.906, -19.848, -181.535 },
                    { 458.255, -10.012, -425.381 },
                    { 462.036, -19.882, -290.810 },
                    { 479.695, -10.026, -396.656 },
                    { 485.110, -16.273, -335.118 },
                    { 490.698, -48.511,  148.541 },
                    { 510.034, -20.435, -218.850 },
                    { 514.089, -19.911, -182.812 },
                    { 531.105, -40.381,   61.704 },
                },
            },

            [xi.zone.JUGNER_FOREST] =
            {
                drops =
                {
                    { 2040, xi.item.WALNUT_LOG    },
                    { 1850, xi.item.WILLOW_LOG    },
                    { 1790, xi.item.YEW_LOG       },
                    { 1460, xi.item.ARROWWOOD_LOG },
                    { 1430, xi.item.ASH_LOG       },
                    {  580, xi.item.ACORN         },
                    {  550, xi.item.DRYAD_ROOT    },
                    {   60, xi.item.OAK_LOG       },
                },

                points =
                {
                    { -375.776,  -2.479,  265.413 },
                    { -363.039,  -0.155,  278.719 },
                    { -362.183,   1.040,  187.201 },
                    { -361.487,   0.955,  260.862 },
                    { -360.785,   0.601,  186.697 },
                    { -360.724,  -0.570,  197.760 },
                    { -354.966,  -0.758,  269.810 },
                    { -312.027,  -0.251, -181.046 },
                    { -310.207,  -1.021, -133.936 },
                    { -283.216,  -8.276, -161.810 },
                    { -254.882,  -0.892, -127.219 },
                    {  166.288,  -0.429,  325.607 },
                    {  166.359,  -0.131,  288.858 },
                    {  181.752,  -1.926,  303.702 },
                    {  190.731,  -0.328,  283.439 },
                    {  201.896,  -0.464,  352.711 },
                    {  231.605,  -9.362, -454.103 },
                    {  236.693,   0.924,  333.902 },
                    {  242.888,  -7.612, -433.149 },
                    {  245.702,  -8.694, -489.239 },
                    {  256.600,  -1.132,  349.891 },
                    {  263.964,  -7.661, -410.469 },
                    {  282.077,   0.233,  264.735 },
                    {  313.204, -16.092, -485.070 },
                    {  315.953, -16.525, -509.135 },
                    {  331.033, -16.324, -430.928 },
                },
            },

            [xi.zone.BUBURIMU_PENINSULA] =
            {
                drops =
                {
                    { 2410, xi.item.LAUAN_LOG                },
                    { 1980, xi.item.ARROWWOOD_LOG            },
                    { 1550, xi.item.YAGUDO_CHERRY            },
                    { 1030, xi.item.BUNCH_OF_BUBURIMU_GRAPES },
                    {  780, xi.item.DRYAD_ROOT               },
                    {  520, xi.item.BAG_OF_FRUIT_SEEDS       },
                    {  950, xi.item.HOLLY_LOG                },
                    {  340, xi.item.EBONY_LOG                },
                    {  170, xi.item.MAHOGANY_LOG             },
                    {  260, xi.item.ROSEWOOD_LOG             },
                },

                points =
                {
                    { -110.755, -3.078, -181.437 },
                    {  -84.193, -0.300, -190.190 },
                    {  -65.646, -0.359, -170.275 },
                    {  -19.019,  0.386, -171.550 },
                    {   11.418, -0.649, -293.818 },
                    {   53.507, -1.185, -214.939 },
                    {  110.580, -0.500, -149.698 },
                    {  310.157, -0.560,   65.354 },
                    {  310.208, -0.002,   65.439 },
                    {  312.565, -0.471,  186.672 },
                    {  322.591,  0.373,   97.789 },
                    {  322.739, -0.642,   72.812 },
                    {  332.584,  0.075,  208.970 },
                    {  339.798,  0.181,   47.695 },
                    {  346.440, -0.597,  221.773 },
                    {  353.854, -0.258,  226.408 },
                    {  366.606, -1.901,  311.305 },
                    {  385.858, -0.082, -146.487 },
                    {  395.512, -0.337,  292.128 },
                    {  397.876, -0.300,  310.969 },
                    {  404.632, -0.514,  204.580 },
                    {  417.319, -0.406,  223.184 },
                    {  425.219, -0.220, -235.833 },
                    {  434.439, -0.461, -210.946 },
                    {  437.086, -0.567,   27.766 },
                    {  459.803,  0.248,   -7.479 },
                    {  496.791, -0.234, -257.340 },
                    {  498.299,  0.379,   -2.789 },
                    {  501.236,  0.046, -274.448 },
                    {  506.554, -0.250, -271.176 },
                    {  514.138, -0.453, -212.523 },
                    {  525.399,  0.082, -245.548 },
                },
            },

            [xi.zone.YUHTUNGA_JUNGLE] =
            {
                drops =
                {
                    { 1900, xi.item.ARROWWOOD_LOG          },
                    { 1430, xi.item.PIECE_OF_RATTAN_LUMBER },
                    { 1190, xi.item.LAUAN_LOG              },
                    { 1190, xi.item.REVIVAL_TREE_ROOT      },
                    {  950, xi.item.AQUILARIA_LOG          },
                    {  480, xi.item.BEEHIVE_CHIP           },
                    {  480, xi.item.BAG_OF_TREE_CUTTINGS   },
                    {  100, xi.item.DRAGON_FRUIT           },
                    {  240, xi.item.EBONY_LOG              },
                    {  100, xi.item.HOLLY_LOG              },
                    {  100, xi.item.ROSEWOOD_LOG           },
                },

                points =
                {
                    { -534.010, -0.086,  168.876 },
                    { -494.337,  2.541,  174.775 },
                    { -217.955,  2.944, -142.003 },
                    {  -52.218,  1.830, -456.071 },
                    {   22.268,  4.422, -496.500 },
                },
            },

            [xi.zone.YHOATOR_JUNGLE] =
            {
                drops =
                {
                    { 2220, xi.item.ARROWWOOD_LOG          },
                    { 2220, xi.item.PIECE_OF_RATTAN_LUMBER },
                    { 1130, xi.item.LAUAN_LOG              },
                    {  780, xi.item.BEEHIVE_CHIP           },
                    {  650, xi.item.DRYAD_ROOT             },
                    {  650, xi.item.BUTTERPEAR             },
                    {  610, xi.item.REVIVAL_TREE_ROOT      },
                    {  610, xi.item.AQUILARIA_LOG          },
                    {  570, xi.item.KAPOR_LOG              },
                    {  350, xi.item.MAHOGANY_LOG           },
                    {  170, xi.item.EBONY_LOG              },
                    {   90, xi.item.BAG_OF_TREE_CUTTINGS   },
                },

                points =
                {
                    { -472.137,  0.661, -224.905 },
                    { -469.513,  1.481, -136.747 },
                    { -459.799,  0.362, -162.191 },
                    { -458.480,  0.855, -327.581 },
                    { -457.910,  0.219, -282.931 },
                    { -384.176,  2.696,  -16.097 },
                    { -377.890,  0.230,   36.990 },
                    { -373.440,  2.991,   64.697 },
                    { -341.286,  4.744,   16.386 },
                    { -305.919,  2.113,   16.102 },
                    { -262.318,  4.630,   56.490 },
                    { -262.101,  4.662,   56.436 },
                    { -175.928,  0.000,   62.958 },
                    { -141.997,  8.634,   43.667 },
                    { -111.119, 10.306,   38.538 },
                    {  -92.006, -0.083,   23.846 },
                    {  -36.545, -3.437,  -82.424 },
                    {  -22.870,  0.250,  -44.010 },
                    {  -22.719,  7.038,  -90.699 },
                    {   -5.442, -3.153,  -84.789 },
                },
            },

            [xi.zone.GHELSBA_OUTPOST] =
            {
                drops =
                {
                    { 2950, xi.item.ARROWWOOD_LOG },
                    { 2230, xi.item.ASH_LOG       },
                    { 2120, xi.item.MAPLE_LOG     },
                    { 1000, xi.item.WILLOW_LOG    },
                    {  620, xi.item.ELM_LOG       },
                    {  650, xi.item.HOLLY_LOG     },
                },

                points =
                {
                    { -27.182, -0.380,  65.124 },
                    { -20.304, -0.275,  81.280 },
                    {  -8.220, -0.202,  55.144 }, -- (R)
                    {  -7.436, -0.568,  67.797 }, -- (R)
                    {  -5.814, -0.012,   1.814 }, -- (R)
                    {  -4.152, -0.016,  42.191 }, -- (R)
                    {  -2.576,  0.000,  97.617 }, -- (R)
                    {  -2.496, -0.374, -21.350 }, -- (R)
                    {   0.220,  0.000,  13.612 }, -- (R)
                    {   3.029, -0.016,  82.753 }, -- (R)
                    {  11.311,  0.035,  47.594 }, -- (R)
                    {  18.655, -0.289, -15.905 },
                    {  23.524, -0.759,  53.766 },
                },
            },
        },
    },

    -----------------------------------

    [xi.helm.type.MINING] =
    {
        id           = 'MINING',
        animation    = xi.emote.EXCAVATION,
        mod          = xi.mod.MINING_RESULT,
        settingRate  = xi.settings.main.MINING_RATE,
        settingBreak = xi.settings.main.MINING_BREAK_CHANCE,
        message      = 'MINING_IS_POSSIBLE_HERE',
        tool         = xi.item.PICKAXE,

        zone =
        {
            [xi.zone.OLDTON_MOVALPOLOS] =
            {
                drops =
                {
                    { 1150, xi.item.IGNEOUS_ROCK           },
                    { 1130, xi.item.CHUNK_OF_ZINC_ORE      },
                    { 1100, xi.item.CHUNK_OF_COPPER_ORE    },
                    { 1080, xi.item.CHUNK_OF_TIN_ORE       },
                    { 1050, xi.item.CHUNK_OF_SILVER_ORE    },
                    {  970, xi.item.CHUNK_OF_IRON_ORE      },
                    {  680, xi.item.SUIT_OF_MOBLIN_MAIL    },
                    {  630, xi.item.MOBLIN_HELM            },
                    {  600, xi.item.MOBLIN_MASK            },
                    {  570, xi.item.GOBLIN_DIE             },
                    {  570, xi.item.SUIT_OF_MOBLIN_ARMOR   },
                    {   80, xi.item.CHUNK_OF_DARKSTEEL_ORE },
                    {   80, xi.item.CHUNK_OF_MYTHRIL_ORE   },
                    {   70, xi.item.CHUNK_OF_GOLD_ORE      },
                    {   70, xi.item.CHUNK_OF_PLATINUM_ORE  },
                },

                points =
                {
                    { -328.808, -2.267,  297.294 },
                    { -261.965,  0.170,  105.879 }, -- (R)F-8
                    { -177.497,  2.548,  216.203 }, -- (R)G-7
                    { -165.574,  6.665,  217.462 },
                    { -136.898,  6.974,   56.038 }, -- (R)G-9
                    { -133.856, 11.649, -148.462 },
                    { -130.416, 13.254, -144.601 }, -- (R)G-11
                    { -105.935,  7.780,   99.428 },
                    {  -98.912,  7.446,   98.006 }, -- (R)H-8
                    {  -31.868, 13.631,  -17.028 },
                    {  -29.411, 13.201,  -15.271 }, -- (R)I-10
                    {  -27.353, 11.397, -141.638 }, -- (R)I-11
                    {  -26.393, 11.359, -141.096 },
                },
            },

            [xi.zone.NEWTON_MOVALPOLOS] =
            {
                drops =
                {
                    { 1660, xi.item.CHUNK_OF_COPPER_ORE    },
                    { 1100, xi.item.CHUNK_OF_TIN_ORE       },
                    { 1450, xi.item.CHUNK_OF_ZINC_ORE      },
                    { 1790, xi.item.IGNEOUS_ROCK           },
                    { 1450, xi.item.CHUNK_OF_SILVER_ORE    },
                    {  140, xi.item.CHUNK_OF_ALUMINUM_ORE  },
                    { 1720, xi.item.CHUNK_OF_IRON_ORE      },
                    {   70, xi.item.CHUNK_OF_DARKSTEEL_ORE },
                    {  210, xi.item.CHUNK_OF_MYTHRIL_ORE   },
                    {  140, xi.item.CHUNK_OF_GOLD_ORE      },
                    {  340, xi.item.CHUNK_OF_PLATINUM_ORE  },
                    {   70, xi.item.RED_ROCK               },
                },

                points =
                {
                    { -103.572, 15.108,   91.212 },
                    { -103.015, 15.125, -192.438 },
                    {  -66.134, 15.021, -148.815 }, -- (R)G-10
                    {  -40.404, 15.131,  223.666 }, -- (R)G-6
                    {  -21.469, 15.331,  -98.196 },
                    {   26.597, 15.204,   21.926 }, -- (R)H-8
                    {   56.794, 15.170,  -22.242 },
                    {   64.517, 14.841, -135.909 }, -- (R)I-10
                    {   69.433, 19.221,  185.247 }, -- (R)I-6
                    {  109.614, 19.689, -104.522 }, -- (R)I-10
                },
            },

            [xi.zone.MOUNT_ZHAYOLM] =
            {
                drops =
                {
                    { 2250, xi.item.PINCH_OF_SULFUR      },
                    { 2990, xi.item.CHUNK_OF_IRON_ORE    },
                    { 1590, xi.item.HANDFUL_OF_IRON_SAND },
                    { 1540, xi.item.FLINT_STONE          },
                    { 1340, xi.item.PINCH_OF_BOMB_ASH    },
                    {  960, xi.item.SUIT_OF_MOBLIN_MAIL  },
                    { 1150, xi.item.MOBLIN_HELM          },
                    {  450, xi.item.SUIT_OF_MOBLIN_ARMOR },
                    {  380, xi.item.TROLL_PAULDRON       },
                    {  450, xi.item.TROLL_VAMBRACE       },
                    {  430, xi.item.MOBLIN_MASK          },
                    {  210, xi.item.DEMON_HORN           },
                    {  140, xi.item.CHUNK_OF_ADAMAN_ORE  },
                    {   30, xi.item.CHUNK_OF_KHROMA_ORE  },
                },

                points =
                {
                    { -27.628, -16.173, 135.104 },
                    {   3.022,  -7.050, 135.379 },
                    {  26.084, -26.136, 268.944 },
                    {  51.594,  -7.509, 175.145 }, -- (R)G-7
                    {  94.963, -14.108, -50.331 }, -- (R)H-8
                    {  99.304, -26.282, 218.188 },
                    { 106.324, -18.436, 150.852 }, -- (R)H-7
                    { 140.944, -26.258, 177.117 }, -- (R)H-7
                    { 178.522, -15.053,  19.833 }, -- (R)H-8
                    { 255.030, -26.153, 227.752 },
                    { 285.170, -24.484, -95.371 },
                    { 286.892, -24.598, -95.068 },
                    { 299.400, -24.263,  97.863 },
                    { 339.710, -25.044, -98.825 },
                    { 340.491, -24.954, 138.624 }, -- (R)I-7
                    { 496.659,  -9.840,  59.863 },
                    { 530.386,  -8.711,  67.537 },
                    { 548.402,  -8.744,  91.171 },
                    { 671.016, -30.461, 213.677 },
                    { 775.315, -17.618, 135.347 },
                    { 775.692, -16.750, 163.576 },
                    { 783.844, -15.593, 172.404 },
                },
            },

            [xi.zone.HALVUNG] =
            {
                drops =
                {
                    { 2010, xi.item.CHUNK_OF_AHT_URHGAN_BRASS },
                    { 1000, xi.item.PINCH_OF_BOMB_ASH         },
                    { 1720, xi.item.FLINT_STONE               },
                    {  290, xi.item.CHUNK_OF_GOLD_ORE         },
                    { 1440, xi.item.HANDFUL_OF_IRON_SAND      },
                    {   50, xi.item.CHUNK_OF_LUMINIUM_ORE     },
                    {  430, xi.item.SUIT_OF_MOBLIN_ARMOR      },
                    {  430, xi.item.MOBLIN_HELM               },
                    {  480, xi.item.SUIT_OF_MOBLIN_MAIL       },
                    {  290, xi.item.MOBLIN_MASK               },
                    {  100, xi.item.CHUNK_OF_ORICHALCUM_ORE   },
                    { 1200, xi.item.PINCH_OF_SULFUR           },
                    {  480, xi.item.TROLL_PAULDRON            },
                    {  330, xi.item.TROLL_VAMBRACE            },
                },

                points =
                {
                    {  61.098, -13.424, 271.717 },
                    {  66.042, -12.557, 268.774 },
                    {  68.513, -10.772, 191.556 },
                    {  99.078,  -1.201, 342.029 },
                    { 100.407,  -0.797, 340.620 },
                    { 117.425, -10.403, 146.647 },
                    { 139.606,  10.292,  15.050 }, -- (R)J-8
                    { 149.589,  -1.720, 309.317 },
                    { 151.561,  -1.709, 308.078 },
                    { 162.031, -10.902, 215.599 },
                    { 168.380,  -1.756, 332.076 },
                    { 170.745,   3.442,  91.990 }, -- (R)J-7
                    { 201.595,  -6.522, 182.385 },
                    { 204.065,  -5.658, 186.315 },
                    { 205.708,  -6.420, 244.649 },
                    { 226.012,  -6.200, 215.825 },
                    { 228.740,  -6.307, 243.411 },
                    { 228.203,  -6.233, 154.503 }, -- (R)K-7
                    { 269.172,   3.433, 228.107 }, -- (R)K-6
                    { 270.880,   2.490, 226.690 },
                },
            },

            [xi.zone.NORTH_GUSTABERG_S] =
            {
                drops =
                {
                    { 1870, xi.item.CHUNK_OF_COPPER_ORE   },
                    { 1930, xi.item.CHUNK_OF_ZINC_ORE     },
                    { 1500, xi.item.CHUNK_OF_TIN_ORE      },
                    { 1340, xi.item.PEBBLE                },
                    {  860, xi.item.CHUNK_OF_SILVER_ORE   },
                    { 1180, xi.item.CHUNK_OF_IRON_ORE     },
                    {  750, xi.item.CHUNK_OF_MYTHRIL_ORE  },
                    {  210, xi.item.MOBLIN_MASK           },
                    {  110, xi.item.MOBLIN_HELM           },
                    {  110, xi.item.SUIT_OF_MOBLIN_MAIL   },
                    {   50, xi.item.SUIT_OF_MOBLIN_ARMOR  },
                    {  160, xi.item.CHUNK_OF_PLATINUM_ORE },
                },

                points =
                {
                    { -252.577,  38.568,  329.700 },
                    { -234.388,  38.007,  285.331 },
                    { -233.113,  38.287,  315.211 }, -- (R)E-8
                    { -232.485,  38.922,  398.626 },
                    {  142.096,  -8.326,  345.036 }, -- (R)I-8
                    {  157.439, -20.374,  354.538 },
                    {  191.357, -12.355,  972.764 },
                    {  195.803, -21.933,  410.947 }, -- (R)I-8
                    {  207.830, -24.770, 1010.240 }, -- (R)I-4
                    {  222.290, -22.865,  377.707 }, -- (R)I-8
                    {  245.408, -25.333, 1050.080 },
                    {  256.123, -41.300,  570.585 }, -- (R)I-7
                    {  271.875, -23.170, 1081.926 },
                    {  277.426, -60.351,  565.171 },
                    {  285.748, -40.397,  397.697 },
                    {  312.277, -42.261,  591.145 },
                    {  315.420, -51.965,  580.746 },
                    {  316.092, -40.000,  446.817 },
                    {  339.449, -20.589,  406.374 },
                    {  344.650, -42.057,  471.047 },
                    {  352.273, -41.346,  552.837 },
                    {  356.020, -20.000,  406.790 },
                    {  360.109, -41.908,  499.796 },
                    {  367.718, -33.187, 1067.718 },
                    {  368.578, -23.415,  958.287 },
                    {  368.667, -33.438,  997.861 },
                    {  368.705, -32.736, 1031.617 },
                    {  376.297, -31.999, 1100.808 },
                    {  394.958, -20.922,  458.055 },
                },
            },

            [xi.zone.YUGHOTT_GROTTO] =
            {
                drops =
                {
                    { 1460, xi.item.CHUNK_OF_COPPER_ORE    },
                    { 1650, xi.item.CHUNK_OF_IRON_ORE      },
                    { 1300, xi.item.CHUNK_OF_TIN_ORE       },
                    { 1140, xi.item.PEBBLE                 },
                    { 1320, xi.item.CHUNK_OF_ZINC_ORE      },
                    {  840, xi.item.FLINT_STONE            },
                    {  360, xi.item.CHUNK_OF_SILVER_ORE    },
                    {  170, xi.item.RED_ROCK               },
                    {  150, xi.item.CHUNK_OF_DARKSTEEL_ORE },
                    {  110, xi.item.CHUNK_OF_GOLD_ORE      },
                },

                points =
                {
                    { -272.354,  -0.378,  -78.058 },
                    { -269.857,  -0.812,  -71.180 }, -- (R)D-9
                    { -245.622,  -1.350,  -86.981 }, -- (R)D-10
                    { -224.477,  -1.165, -112.948 }, -- (R)E-10
                    { -181.213,  -1.156, -111.072 },
                    { -175.728,  -1.133,  -95.682 },
                    { -141.144,  -1.407,  -97.973 },
                    { -124.625,  -0.655,  -73.322 },
                    { -122.534,  -0.804,   -5.241 },
                    { -117.765,  -1.018,   -5.093 },
                    {  -85.180,  -0.821,  -37.458 },
                    {  -71.048,  -0.883,   -9.980 }, -- (R)G-9
                    {  -33.193,  -0.962,   -7.588 },
                    {  -25.004,  -1.122,   30.867 },
                    {  -22.575,  -0.848,   34.002 },
                    {  -16.529,  -1.251,  -62.637 },
                    {   12.319,  -1.143,   38.814 },
                    {   15.087,  -1.349,  -41.581 }, -- (R)H-9
                    {   25.143,  -1.219,   21.085 },
                    {   69.955,  -3.219,   27.781 },
                    {   70.715,  -3.235,   27.636 },
                    {  104.726, -13.868,   47.164 },
                    {  140.836, -13.275,  131.468 }, -- (R)I-7
                    {  148.312, -13.154,   55.118 },
                    {  175.534, -12.809,   36.799 },
                    {  183.111, -13.205,  134.862 },
                    {  213.887, -13.077,  138.546 },
                    {  218.911, -13.094,   47.544 },
                    {  258.910, -13.445,  122.106 },
                    {  280.000, -21.813,  169.367 },
                    {  310.232, -24.639,  161.209 },
                    {  312.119, -24.797,  212.536 },
                    {  330.931, -24.900,  239.451 },
                    {  363.273, -24.758,  164.485 },
                },
            },

            [xi.zone.PALBOROUGH_MINES] =
            {
                drops =
                {
                    { 1130, xi.item.CHUNK_OF_ZINC_ORE     },
                    {  940, xi.item.CHUNK_OF_IRON_ORE     },
                    { 1040, xi.item.PEBBLE                },
                    {  970, xi.item.CHUNK_OF_TIN_ORE      },
                    {  900, xi.item.CHUNK_OF_MYTHRIL_ORE  },
                    {  900, xi.item.CHUNK_OF_SILVER_ORE   },
                    {  800, xi.item.CHUNK_OF_COPPER_ORE   },
                    {  100, xi.item.CHUNK_OF_PLATINUM_ORE },
                },

                points =
                {
                    { -68.142, -16.709,  250.590 },
                    { -63.334,  -9.468,  191.074 }, -- (R)F-7
                    { -48.409, -17.077,  227.142 },
                    {  22.365, -32.317,   82.608 },
                    {  22.911, -32.471, -109.982 }, -- (R)G-10
                    { 104.773, -32.418,   82.766 },
                    { 132.025,  -1.226,  169.978 }, -- (R)H-7
                    { 133.693,  -0.063,  167.560 },
                    { 152.025, -17.085,  143.561 }, -- (R)H-7
                    { 152.190, -16.394,  142.365 },
                    { 186.116, -15.432,    6.930 },
                    { 216.457,  -1.625,  112.444 }, -- (R)I-8
                    { 223.246, -11.863,  185.263 },
                    { 241.255, -16.567,  256.516 }, -- (R)I-6
                    { 256.587, -33.185,  190.811 }, -- (R)J-6
                    { 266.499, -32.401,  -71.379 },
                    { 269.898, -32.782,  -68.259 }, -- (R)J-9
                    { 282.245, -16.391,  177.981 }, -- (R)J-7
                    { 288.996, -16.535,   93.222 }, -- (R)J-8
                    { 290.244, -15.718,  104.856 },
                    { 306.015, -16.275,   49.876 },
                },
            },

            [xi.zone.ZERUHN_MINES] =
            {
                drops =
                {
                    { 2450, xi.item.CHUNK_OF_IRON_ORE      },
                    { 1800, xi.item.PEBBLE                 },
                    { 1850, xi.item.CHUNK_OF_COPPER_ORE    },
                    { 1330, xi.item.CHUNK_OF_ZINC_ORE      },
                    { 1120, xi.item.CHUNK_OF_TIN_ORE       },
                    {  550, xi.item.SNAPPING_MOLE          },
                    {  180, xi.item.CHUNK_OF_SILVER_ORE    },
                    {   40, xi.item.CHUNK_OF_DARKSTEEL_ORE },
                },

                points =
                {
                    { -91.345, 8.038, -218.532 },
                    { -87.426, 7.436, -333.037 },
                    { -61.159, 6.427, -149.922 },
                    { -57.674, 6.631, -168.595 },
                    { -52.187, 7.880, -103.336 },
                    { -50.801, 7.795, -178.933 },
                    { -27.681, 7.125, -267.218 },
                    { -11.095, 6.485, -180.763 }, -- (R)I-9
                    {   1.854, 8.113, -176.282 },
                    {  13.896, 7.429, -291.885 }, -- (R)I-11
                    {  14.347, 7.068,  -50.338 }, -- (R)I-8
                    {  14.464, 7.335,  -50.905 },
                    {  16.606, 8.071, -119.420 },
                    {  52.265, 6.909, -107.853 }, -- (R)J-8
                    {  53.561, 7.657, -272.379 },
                    {  58.583, 7.729, -273.176 },
                    {  66.074, 7.700, -151.352 },
                    {  68.980, 7.312, -253.231 }, -- (R)J-10
                    { 103.774, 6.930, -187.465 }, -- (R)J-9
                    { 133.030, 7.434, -207.489 },
                    { 133.341, 7.255, -141.532 },
                    { 133.975, 7.184, -131.237 },
                    { 134.829, 7.634, -131.175 },
                    { 146.979, 7.881, -209.748 },
                },
            },

            [xi.zone.GUSGEN_MINES] =
            {
                drops =
                {
                    { 1890, xi.item.PEBBLE                 },
                    { 1670, xi.item.CHUNK_OF_ZINC_ORE      },
                    { 1510, xi.item.CHUNK_OF_COPPER_ORE    },
                    { 1470, xi.item.CHUNK_OF_TIN_ORE       },
                    { 1450, xi.item.CHUNK_OF_IRON_ORE      },
                    {  810, xi.item.CHUNK_OF_SILVER_ORE    },
                    {  590, xi.item.CHUNK_OF_DARKSTEEL_ORE },
                    {  400, xi.item.RED_ROCK               },
                    {   80, xi.item.CHUNK_OF_GOLD_ORE      },
                },

                points =
                {
                    { -172.555,  -0.330,  303.216 },
                    { -171.214,  -0.100,  376.661 },
                    { -161.341, -24.382,  222.992 },
                    { -145.420, -28.425,  326.760 },
                    { -137.089, -40.658,  150.613 },
                    { -107.372,  -0.380,  256.981 }, -- (R)H-8
                    {  -64.416, -40.104,  253.775 },
                    {  -26.623, -60.805, -141.508 },
                    {  -24.341, -60.806, -169.115 }, -- (R)G-8
                    {  -13.810, -40.108,  -87.118 }, -- (R)G-7
                    {  -10.364, -40.028,  -84.169 },
                    {   27.651, -40.074,   62.101 },
                    {   31.350, -41.101,  195.396 }, -- (R)H-6
                    {   71.523, -60.258, -174.060 },
                    {   92.931, -60.659, -224.312 },
                    {  100.512, -41.629,  209.397 }, -- (R)I-6
                    {  145.349, -40.450,   24.710 }, -- (R)I-8
                    {  155.746, -20.678,  216.857 }, -- (R)I-9
                },
            },

            [xi.zone.IFRITS_CAULDRON] =
            {
                drops =
                {
                    { 3260, xi.item.FLINT_STONE             },
                    { 1520, xi.item.CHUNK_OF_IRON_ORE       },
                    {  430, xi.item.PINCH_OF_SULFUR         },
                    {  650, xi.item.BOMB_ARM                },
                    {  870, xi.item.PINCH_OF_BOMB_ASH       },
                    { 1300, xi.item.HANDFUL_OF_IRON_SAND    },
                    {  250, xi.item.CHUNK_OF_ADAMAN_ORE     },
                    {  600, xi.item.CHUNK_OF_DARKSTEEL_ORE  },
                    { 1520, xi.item.CHUNK_OF_ORPIMENT       },
                    {  100, xi.item.CHUNK_OF_ORICHALCUM_ORE },
                    {  220, xi.item.RED_ROCK                },
                },

                points =
                {
                    { -230.764, 38.248,  131.501 }, -- Map 8 H-8
                    { -179.897,  2.841, -183.614 }, -- Map 7 D-12 -- (R)D-12
                    { -144.081, 16.047, -177.289 }, -- Map 7 E-12
                    { -129.569, 38.263,   83.389 }, -- Map 8 J-9
                    { -109.431, 16.818,   25.500 }, -- Map 7 F-7 -- (R)F-7
                    { -108.781, -3.446,   50.634 }, -- Map 2 F-6 -- (R)F-6
                    { -104.457, -1.927,  -66.331 }, -- Map 2 F-9
                    {  -98.921, -1.524,  -16.917 }, -- Map 2 F-8
                    {  -73.008, -0.541,  -96.456 }, -- Map 2 G-10
                    {  -64.817, -1.146,   61.395 }, -- Map 2 G-6 -- (R)G-6
                    {  -15.084,  4.648,  176.277 }, -- Map 7 H-3
                    {   -3.945,  9.675,   95.107 }, -- Map 7 H-5
                    {   25.588,  8.467,   96.117 }, -- Map 7 I-5
                    {   27.931, -2.754,   50.856 }, -- Map 2 I-6
                    {   41.822, -0.888,  -24.337 }, -- Map 2 J-8
                    {   67.766, -2.801,   27.572 }, -- Map 2 J-7
                    {   92.615, 19.226,   -5.734 }, -- Map 6 H-11
                    {   96.232, 10.479,  227.291 }, -- Map 6 H-5
                    {   96.820,  8.636,  141.280 }, -- Map 7 K-4 -- (R)K-4
                    {  139.082,  3.224,  -61.040 }, -- Map 1 G-8
                },
            },
        },
    },
}

-----------------------------------
-- colored rocks array
-----------------------------------

local rocks =
{
    [xi.element.FIRE   ] = xi.item.RED_ROCK,
    [xi.element.ICE    ] = xi.item.TRANSLUCENT_ROCK,
    [xi.element.WIND   ] = xi.item.GREEN_ROCK,
    [xi.element.EARTH  ] = xi.item.YELLOW_ROCK,
    [xi.element.THUNDER] = xi.item.PURPLE_ROCK,
    [xi.element.WATER  ] = xi.item.BLUE_ROCK,
    [xi.element.LIGHT  ] = xi.item.WHITE_ROCK,
    [xi.element.DARK   ] = xi.item.BLACK_ROCK,
}

-----------------------------------
-- local functions
-----------------------------------

local function doesToolBreak(player, info)
    local roll  = math.random(1, 100)
    local mod   = info.mod

    if mod then
        roll = roll + (player:getMod(mod) / 10)
    end

    if roll <= info.settingBreak then
        player:tradeComplete()
        return true
    end

    return false
end

local function pickItem(player, info)
    local zoneId = player:getZoneID()

    -- found nothing
    if math.random(1, 100) > info.settingRate then
        return 0
    end

    -- possible drops
    local drops = info.zone[zoneId].drops

    -- sum weights
    local sum = 0
    for i = 1, #drops do
        sum = sum + drops[i][1]
    end

    -- pick weighted result
    local item = 0
    local pick = math.random(1, sum)
    sum = 0

    for i = 1, #drops do
        sum = sum + drops[i][1]
        if sum >= pick then
            item = drops[i][2]
            break
        end
    end

    -- if we picked a colored rock, change it to the day's element
    if item == xi.item.RED_ROCK then
        item = rocks[VanadielDayElement()]
    end

    return item
end

local function doMove(npc, x, y, z)
    return function(entity)
        entity:setPos(x, y, z, 0)
    end
end

local function movePoint(player, npc, zoneId, info)
    local points = info.zone[zoneId].points
    local point  = points[math.random(1, #points)]

    npc:hideNPC(120)
    npc:queue(3000, doMove(npc, unpack(point)))
end

-----------------------------------
-- public functions
-----------------------------------

xi.helm.initZone = function(zone, helmType)
    local zoneId = zone:getID()
    local info   = helmInfo[helmType]
    local npcs   = zones[zoneId].npc[info.id]

    for _, npcId in ipairs(npcs) do
        local npc = GetNPCByID(npcId)
        if npc then
            npc:setStatus(xi.status.NORMAL)
            movePoint(nil, npc, zoneId, info)
        end
    end
end

xi.helm.result = function(player, helmType, broke, itemID)
    local zoneId = player:getZoneID()

    -- Quest: Vanishing Act
    if
        helmType == xi.helm.type.HARVESTING and
        player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.VANISHING_ACT) == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.RAINBOW_BERRY) and
        broke ~= 1 and
        zoneId == xi.zone.WAJAOM_WOODLANDS
    then
        npcUtil.giveKeyItem(player, xi.ki.RAINBOW_BERRY)
    end

    -- Missiom: AMK04
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.helmTrade(player, helmType, broke)
    end

    -- Item results
    if itemID > 0 then
        -- Egg-Hunt Extravaganza Event
        if xi.events and xi.events.eggHunt then
            xi.events.eggHunt.helmResult(player)
        end

        -- Records of Eminence
        player:triggerRoeEvent(xi.roeTrigger.HELM_SUCCESS, { ['skillType'] = helmType })
    end
end

xi.helm.onTrade = function(player, npc, trade, helmType, csid, func)
    local info   = helmInfo[helmType]
    local zoneId = player:getZoneID()

    -- HELM should remove invisible
    player:delStatusEffect(xi.effect.INVISIBLE)

    if trade:hasItemQty(info.tool, 1) and trade:getItemCount() == 1 then
        -- start event
        local itemID = pickItem(player, info)
        local broke  = doesToolBreak(player, info) and 1 or 0
        local full   = (player:getFreeSlotsCount() == 0) and 1 or 0

        if csid then
            player:startEvent(csid, itemID, broke, full)
        end

        player:sendEmote(npc, info.animation, xi.emoteMode.MOTION)

        -- WotG : The Price of Valor; Success does not award an item, but only KI.
        if xi.wotg.helpers.helmTrade(player, helmType, broke) then
            return
        end

        -- no item obtained if inventory is full
        if full == 1 then
            itemID = 0
        end

        -- success! reward item and decrement number of remaining uses on the point
        if itemID ~= 0 then
            player:addItem(itemID)

            local uses = (npc:getLocalVar('uses') - 1) % 4
            npc:setLocalVar('uses', uses)

            if uses == 0 then
                movePoint(player, npc, zoneId, info)
            end
        end

        xi.helm.result(player, helmType, broke, itemID)

        if type(func) == 'function' then
            func(player)
        end
    else
        player:messageSpecial(zones[zoneId].text[info.message], info.tool)
    end
end

xi.helm.onTrigger = function(player, helmType)
    local zoneId = player:getZoneID()
    local info = helmInfo[helmType]
    player:messageSpecial(zones[zoneId].text[info.message], info.tool)
end
