xi.chocoboDig = xi.chocoboDig or {}

-----------------------------------
-- Experience needed to level up.
-----------------------------------
xi.chocoboDig.xpToLevel =
{
    [  1] =   155,
    [  2] =   220,
    [  3] =   355,
    [  4] =   445,
    [  5] =   615,
    [  6] =   740,
    [  7] =   900,
    [  8] =  1070,
    [  9] =  1230,
    [ 10] =  1320,
    [ 11] =  1470,
    [ 12] =  1705,
    [ 13] =  2015,
    [ 14] =  2245,
    [ 15] =  2495,
    [ 16] =  2755,
    [ 17] =  3020,
    [ 18] =  3315,
    [ 19] =  3610,
    [ 20] =  3915,
    [ 21] =  4315,
    [ 22] =  4655,
    [ 23] =  5010,
    [ 24] =  5380,
    [ 25] =  5765,
    [ 26] =  6160,
    [ 27] =  6570,
    [ 28] =  6995,
    [ 29] =  7435,
    [ 30] =  7895,
    [ 31] =  8485,
    [ 32] =  8975,
    [ 33] =  9480,
    [ 34] = 10000,
    [ 35] = 10545,
    [ 36] = 11085,
    [ 37] = 11660,
    [ 38] = 12240,
    [ 39] = 12680,
    [ 40] = 13115,
    [ 41] = 13745,
    [ 42] = 14200,
    [ 43] = 14665,
    [ 44] = 15130,
    [ 45] = 15605,
    [ 46] = 16080,
    [ 47] = 16560,
    [ 48] = 17045,
    [ 49] = 17535,
    [ 50] = 18025,
    [ 51] = 18730,
    [ 52] = 19240,
    [ 53] = 19755,
    [ 54] = 20275,
    [ 55] = 20790,
    [ 56] = 21325,
    [ 57] = 21850,
    [ 58] = 22390,
    [ 59] = 22925,
    [ 60] = 23470,
    [ 61] = 24185,
    [ 62] = 24735,
    [ 63] = 25305,
    [ 64] = 25865,
    [ 65] = 26430,
    [ 66] = 27000,
    [ 67] = 27575,
    [ 68] = 28165,
    [ 69] = 28750,
    [ 70] = 29335,
    [ 71] = 30085,
    [ 72] = 30685,
    [ 73] = 31290,
    [ 74] = 31900,
    [ 75] = 32510,
    [ 76] = 33125,
    [ 77] = 33745,
    [ 78] = 34365,
    [ 79] = 35000,
    [ 80] = 35630,
    [ 81] = 36395,
    [ 82] = 37040,
    [ 83] = 37680,
    [ 84] = 38335,
    [ 85] = 38990,
    [ 86] = 39645,
    [ 87] = 40305,
    [ 88] = 40970,
    [ 89] = 41640,
    [ 90] = 44745,
    [ 91] = 45565,
    [ 92] = 46280,
    [ 93] = 47005,
    [ 94] = 47735,
    [ 95] = 48465,
    [ 96] = 49210,
    [ 97] = 49950,
    [ 98] = 50695,
    [ 99] = 51440,
    [100] = 52200,
}

-----------------------------------
-- Experience granted per successful dig, by the item row's rank (0-10) in the zone table.
-----------------------------------
xi.chocoboDig.experiencePerItem =
{
    [xi.craftRank.AMATEUR    ] = 30,
    [xi.craftRank.RECRUIT    ] = 40,
    [xi.craftRank.INITIATE   ] = 45,
    [xi.craftRank.NOVICE     ] = 50,
    [xi.craftRank.APPRENTICE ] = 55,
    [xi.craftRank.JOURNEYMAN ] = 60,
    [xi.craftRank.CRAFTSMAN  ] = 65,
    [xi.craftRank.ARTISAN    ] = 70,
    [xi.craftRank.ADEPT      ] = 80,
    [xi.craftRank.VETERAN    ] = 85,
    [xi.craftRank.EXPERT     ] = 100,
}

-----------------------------------
-- Digging accuracy is affected by player's rank only. No moon influence.
-----------------------------------
xi.chocoboDig.accuracy =
{
    [xi.craftRank.AMATEUR    ] = 30,
    [xi.craftRank.RECRUIT    ] = 34,
    [xi.craftRank.INITIATE   ] = 38,
    [xi.craftRank.NOVICE     ] = 42,
    [xi.craftRank.APPRENTICE ] = 46,
    [xi.craftRank.JOURNEYMAN ] = 50,
    [xi.craftRank.CRAFTSMAN  ] = 51,
    [xi.craftRank.ARTISAN    ] = 52,
    [xi.craftRank.ADEPT      ] = 53,
    [xi.craftRank.VETERAN    ] = 54,
    [xi.craftRank.EXPERT     ] = 55,
}

-----------------------------------
-- Areas where Elemental Ores can be dug.
-----------------------------------
xi.chocoboDig.elementalOreZones =
set{
    xi.zone.BATALLIA_DOWNS,
    xi.zone.BUBURIMU_PENINSULA,
    xi.zone.EAST_RONFAURE,
    xi.zone.EAST_SARUTABARUTA,
    xi.zone.JUGNER_FOREST,
    xi.zone.KONSCHTAT_HIGHLANDS,
    xi.zone.LA_THEINE_PLATEAU,
    xi.zone.MERIPHATAUD_MOUNTAINS,
    xi.zone.NORTH_GUSTABERG,
    xi.zone.PASHHOW_MARSHLANDS,
    xi.zone.ROLANBERRY_FIELDS,
    xi.zone.SAUROMUGUE_CHAMPAIGN,
    xi.zone.SOUTH_GUSTABERG,
    xi.zone.TAHRONGI_CANYON,
    xi.zone.VALKURM_DUNES,
    xi.zone.WEST_RONFAURE,
    xi.zone.WEST_SARUTABARUTA,
    xi.zone.BIBIKI_BAY,
    xi.zone.CARPENTERS_LANDING,
    xi.zone.BHAFLAU_THICKETS,
    xi.zone.WAJAOM_WOODLANDS,
    xi.zone.THE_SANCTUARY_OF_ZITAH,
}

-----------------------------------
-- Elemental Ore weight. Full weight set at Expert Rank.
-----------------------------------
xi.chocoboDig.elementalOreWeight =
{
    [xi.craftRank.AMATEUR    ] =  0,
    [xi.craftRank.RECRUIT    ] =  0,
    [xi.craftRank.INITIATE   ] =  0,
    [xi.craftRank.NOVICE     ] =  0,
    [xi.craftRank.APPRENTICE ] =  0,
    [xi.craftRank.JOURNEYMAN ] = 15,
    [xi.craftRank.CRAFTSMAN  ] = 30,
    [xi.craftRank.ARTISAN    ] = 45,
    [xi.craftRank.ADEPT      ] = 55,
    [xi.craftRank.VETERAN    ] = 65,
    [xi.craftRank.EXPERT     ] = 80,
}

-----------------------------------
-- Crystal chance. Full weight set at Novice Rank.
-----------------------------------
xi.chocoboDig.crystalWeight =
{
    [xi.craftRank.AMATEUR    ] =  440,
    [xi.craftRank.RECRUIT    ] =  560,
    [xi.craftRank.INITIATE   ] =  680,
    [xi.craftRank.NOVICE     ] =  800,
    [xi.craftRank.APPRENTICE ] =  800,
    [xi.craftRank.JOURNEYMAN ] =  800,
    [xi.craftRank.CRAFTSMAN  ] =  800,
    [xi.craftRank.ARTISAN    ] =  800,
    [xi.craftRank.ADEPT      ] =  800,
    [xi.craftRank.VETERAN    ] =  800,
    [xi.craftRank.EXPERT     ] =  800,
}

-----------------------------------
-- Cluster chance. Full weight set at Journeyman Rank.
-----------------------------------
xi.chocoboDig.clusterWeight =
{
    [xi.craftRank.AMATEUR    ] =   80,
    [xi.craftRank.RECRUIT    ] =  160,
    [xi.craftRank.INITIATE   ] =  220,
    [xi.craftRank.NOVICE     ] =  280,
    [xi.craftRank.APPRENTICE ] =  340,
    [xi.craftRank.JOURNEYMAN ] =  400,
    [xi.craftRank.CRAFTSMAN  ] =  400,
    [xi.craftRank.ARTISAN    ] =  400,
    [xi.craftRank.ADEPT      ] =  400,
    [xi.craftRank.VETERAN    ] =  400,
    [xi.craftRank.EXPERT     ] =  400,
}

-----------------------------------
-- Elemental Ore awarded based on the day of the week.
-----------------------------------
xi.chocoboDig.elementalOreByDay =
{
    [xi.day.FIRESDAY         ] = xi.item.CHUNK_OF_FIRE_ORE,
    [xi.day.ICEDAY           ] = xi.item.CHUNK_OF_ICE_ORE,
    [xi.day.WINDSDAY         ] = xi.item.CHUNK_OF_WIND_ORE,
    [xi.day.EARTHSDAY        ] = xi.item.CHUNK_OF_EARTH_ORE,
    [xi.day.LIGHTNINGDAY     ] = xi.item.CHUNK_OF_LIGHTNING_ORE,
    [xi.day.WATERSDAY        ] = xi.item.CHUNK_OF_WATER_ORE,
    [xi.day.LIGHTSDAY        ] = xi.item.CHUNK_OF_LIGHT_ORE,
    [xi.day.DARKSDAY         ] = xi.item.CHUNK_OF_DARK_ORE,
}

-----------------------------------
-- Crystals awarded based on the current weather.
-----------------------------------
xi.chocoboDig.crystalByWeather =
{
    [xi.weather.HOT_SPELL    ] = xi.item.FIRE_CRYSTAL,
    [xi.weather.SNOW         ] = xi.item.ICE_CRYSTAL,
    [xi.weather.WIND         ] = xi.item.WIND_CRYSTAL,
    [xi.weather.DUST_STORM   ] = xi.item.EARTH_CRYSTAL,
    [xi.weather.THUNDER      ] = xi.item.LIGHTNING_CRYSTAL,
    [xi.weather.RAIN         ] = xi.item.WATER_CRYSTAL,
    [xi.weather.AURORAS      ] = xi.item.LIGHT_CRYSTAL,
    [xi.weather.GLOOM        ] = xi.item.DARK_CRYSTAL,
}

-----------------------------------
-- Clusters awarded based on the current weather.
-----------------------------------
xi.chocoboDig.clusterByWeather =
{
    [xi.weather.HEAT_WAVE    ] = xi.item.FIRE_CLUSTER,
    [xi.weather.BLIZZARDS    ] = xi.item.ICE_CLUSTER,
    [xi.weather.GALES        ] = xi.item.WIND_CLUSTER,
    [xi.weather.SAND_STORM   ] = xi.item.EARTH_CLUSTER,
    [xi.weather.THUNDERSTORMS] = xi.item.LIGHTNING_CLUSTER,
    [xi.weather.SQUALL       ] = xi.item.WATER_CLUSTER,
    [xi.weather.STELLAR_GLARE] = xi.item.LIGHT_CLUSTER,
    [xi.weather.DARKNESS     ] = xi.item.DARK_CLUSTER,
}

-----------------------------------
-- Seeds can only be dug up at night.
-----------------------------------
xi.chocoboDig.nightOnlyItems =
set{
    xi.item.BAG_OF_FRUIT_SEEDS,
    xi.item.BAG_OF_GRAIN_SEEDS,
    xi.item.BAG_OF_HERB_SEEDS,
    xi.item.BAG_OF_TREE_CUTTINGS,
    xi.item.BAG_OF_VEGETABLE_SEEDS,
}

-----------------------------------
-- { itemId, item rank (drives XP), weights at rank 0-10 }
-----------------------------------
xi.chocoboDig.zoneTable =
{
    [xi.zone.BATALLIA_DOWNS] =
    {
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.FLINT_STONE,              xi.craftRank.AMATEUR,     910,  910,  910,  910,  910,  910,  910,  910,  910,  910,  910 },
        { xi.item.BONE_CHIP,                xi.craftRank.AMATEUR,     810,  810,  810,  810,  810,  810,  810,  810,  810,  810,  810 },
        { xi.item.CHUNK_OF_COPPER_ORE,      xi.craftRank.INITIATE,    370,  450,  530,  530,  530,  530,  530,  530,  530,  530,  530 },
        { xi.item.CHUNK_OF_IRON_ORE,        xi.craftRank.APPRENTICE,  145,  200,  255,  310,  365,  365,  365,  365,  365,  365,  365 },
        { xi.item.BIRD_FEATHER,             xi.craftRank.APPRENTICE,  130,  175,  225,  275,  325,  325,  325,  325,  325,  325,  325 },
        { xi.item.RED_JAR,                  xi.craftRank.JOURNEYMAN,   50,  100,  135,  175,  215,  250,  250,  250,  250,  250,  250 },
        { xi.item.PURPLE_ROCK,              xi.craftRank.JOURNEYMAN,   40,   80,  115,  145,  175,  205,  205,  205,  205,  205,  205 },
        { xi.item.BLACK_CHOCOBO_FEATHER,    xi.craftRank.ADEPT,         1,    2,    5,   10,   20,   30,   35,   45,   50,   50,   50 },
        { xi.item.REISHI_MUSHROOM,          xi.craftRank.VETERAN,       1,    1,    2,    5,    5,   10,   15,   20,   25,   30,   30 },
    },

    [xi.zone.BUBURIMU_PENINSULA] =
    {
        { xi.item.CHUNK_OF_TIN_ORE,         xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.SEASHELL,                 xi.craftRank.AMATEUR,     765,  765,  765,  765,  765,  765,  765,  765,  765,  765,  765 },
        { xi.item.LUGWORM,                  xi.craftRank.INITIATE,    420,  510,  600,  600,  600,  600,  600,  600,  600,  600,  600 },
        { xi.item.GIANT_FEMUR,              xi.craftRank.INITIATE,    310,  385,  450,  450,  450,  450,  450,  450,  450,  450,  450 },
        { xi.item.BIRD_FEATHER,             xi.craftRank.APPRENTICE,  135,  175,  230,  270,  325,  325,  325,  325,  325,  325,  325 },
        { xi.item.SHELL_BUG,                xi.craftRank.JOURNEYMAN,   95,  170,  235,  310,  375,  435,  435,  435,  435,  435,  435 },
        { xi.item.SHALL_SHELL,              xi.craftRank.JOURNEYMAN,   60,  120,  180,  220,  280,  320,  320,  320,  320,  320,  320 },
        { xi.item.CHUNK_OF_PLATINUM_ORE,    xi.craftRank.ADEPT,         1,    1,    2,    5,   10,   15,   20,   25,   35,   35,   35 },
        { xi.item.TURTLE_SHELL,             xi.craftRank.VETERAN,       1,    2,    3,    8,   15,   30,   45,   55,   70,   85,   85 },
    },

    [xi.zone.EAST_RONFAURE] =
    {
        { xi.item.ACORN,                    xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.LITTLE_WORM,              xi.craftRank.AMATEUR,     875,  875,  875,  875,  875,  875,  875,  875,  875,  875,  875 },
        { xi.item.ARROWWOOD_LOG,            xi.craftRank.AMATEUR,     780,  780,  780,  780,  780,  780,  780,  780,  780,  780,  780 },
        { xi.item.CHOCOBO_FEATHER,          xi.craftRank.RECRUIT,     455,  535,  535,  535,  535,  535,  535,  535,  535,  535,  535 },
        { xi.item.MAPLE_LOG,                xi.craftRank.INITIATE,    330,  400,  470,  470,  470,  470,  470,  470,  470,  470,  470 },
        { xi.item.RONFAURE_CHESTNUT,        xi.craftRank.INITIATE,    325,  390,  460,  460,  460,  460,  460,  460,  460,  460,  460 },
        { xi.item.ASH_LOG,                  xi.craftRank.INITIATE,    295,  360,  420,  420,  420,  420,  420,  420,  420,  420,  420 },
        { xi.item.CHESTNUT_LOG,             xi.craftRank.APPRENTICE,  100,  140,  175,  215,  250,  250,  250,  250,  250,  250,  250 },
        { xi.item.BAG_OF_FRUIT_SEEDS,       xi.craftRank.CRAFTSMAN,    25,   35,   70,   95,  120,  145,  170,  170,  170,  170,  170 },
        { xi.item.SPRIG_OF_MISTLETOE,       xi.craftRank.VETERAN,       2,    5,   10,   15,   20,   40,   55,   70,   85,  100,  100 },
    },

    [xi.zone.EAST_SARUTABARUTA] =
    {
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.LAUAN_LOG,                xi.craftRank.AMATEUR,     930,  930,  930,  930,  930,  930,  930,  930,  930,  930,  930 },
        { xi.item.PAPAKA_GRASS,             xi.craftRank.AMATEUR,     825,  825,  825,  825,  825,  825,  825,  825,  825,  825,  825 },
        { xi.item.INSECT_WING,              xi.craftRank.AMATEUR,     630,  630,  630,  630,  630,  630,  630,  630,  630,  630,  630 },
        { xi.item.YAGUDO_FEATHER,           xi.craftRank.NOVICE,      330,  420,  510,  600,  600,  600,  600,  600,  600,  600,  600 },
        { xi.item.BIRD_FEATHER,             xi.craftRank.APPRENTICE,  220,  305,  385,  470,  550,  550,  550,  550,  550,  550,  550 },
        { xi.item.ROSEWOOD_LOG,             xi.craftRank.APPRENTICE,   55,  110,  150,  190,  230,  275,  275,  275,  275,  275,  275 },
        { xi.item.GREEN_ROCK,               xi.craftRank.JOURNEYMAN,   50,   95,  130,  170,  205,  240,  240,  240,  240,  240,  240 },
        { xi.item.BAG_OF_HERB_SEEDS,        xi.craftRank.CRAFTSMAN,    25,   35,   70,   95,  120,  145,  170,  170,  170,  170,  170 },
        { xi.item.BALL_OF_SARUTA_COTTON,    xi.craftRank.CRAFTSMAN,    20,   30,   60,   85,  110,  135,  155,  155,  155,  155,  155 },
    },

    [xi.zone.JUGNER_FOREST] =
    {
        { xi.item.ACORN,                    xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.ARROWWOOD_LOG,            xi.craftRank.AMATEUR,     745,  745,  745,  745,  745,  745,  745,  745,  745,  745,  745 },
        { xi.item.LITTLE_WORM,              xi.craftRank.AMATEUR,     730,  730,  730,  730,  730,  730,  730,  730,  730,  730,  730 },
        { xi.item.MAPLE_LOG,                xi.craftRank.INITIATE,    505,  615,  725,  725,  725,  725,  725,  725,  725,  725,  725 },
        { xi.item.WILLOW_LOG,               xi.craftRank.INITIATE,    350,  425,  500,  500,  500,  500,  500,  500,  500,  500,  500 },
        { xi.item.HOLLY_LOG,                xi.craftRank.INITIATE,    290,  355,  415,  415,  415,  415,  415,  415,  415,  415,  415 },
        { xi.item.OAK_LOG,                  xi.craftRank.JOURNEYMAN,   55,  110,  150,  190,  230,  270,  270,  270,  270,  270,  270 },
        { xi.item.SCREAM_FUNGUS,            xi.craftRank.ARTISAN,      15,   25,   30,   60,   85,  105,  130,  150,  150,  150,  150 },
        { xi.item.SPRIG_OF_MISTLETOE,       xi.craftRank.VETERAN,       2,    5,   10,   15,   20,   40,   55,   70,   85,  100,  100 },
    },

    [xi.zone.KONSCHTAT_HIGHLANDS] =
    {
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.BONE_CHIP,                xi.craftRank.AMATEUR,     820,  820,  820,  820,  820,  820,  820,  820,  820,  820,  820 },
        { xi.item.FLINT_STONE,              xi.craftRank.AMATEUR,     550,  550,  550,  550,  550,  550,  550,  550,  550,  550,  550 },
        { xi.item.HANDFUL_OF_FISH_SCALES,   xi.craftRank.AMATEUR,     520,  520,  520,  520,  520,  520,  520,  520,  520,  520,  520 },
        { xi.item.CHUNK_OF_ZINC_ORE,        xi.craftRank.NOVICE,      260,  335,  405,  475,  475,  475,  475,  475,  475,  475,  475 },
        { xi.item.ELM_LOG,                  xi.craftRank.NOVICE,      205,  265,  320,  375,  375,  375,  375,  375,  375,  375,  375 },
        { xi.item.BIRD_FEATHER,             xi.craftRank.APPRENTICE,  115,  160,  205,  250,  290,  290,  290,  290,  290,  290,  290 },
        { xi.item.LIZARD_MOLT,              xi.craftRank.APPRENTICE,  110,  155,  200,  240,  280,  280,  280,  280,  280,  280,  280 },
        { xi.item.MYTHRIL_BEASTCOIN,        xi.craftRank.JOURNEYMAN,   50,   95,  135,  170,  205,  240,  240,  240,  240,  240,  240 },
        { xi.item.PHOENIX_FEATHER,          xi.craftRank.EXPERT,        1,    2,    5,   10,   15,   20,   40,   50,   65,   80,   95 },
    },

    [xi.zone.LA_THEINE_PLATEAU] =
    {
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.ARROWWOOD_LOG,            xi.craftRank.AMATEUR,     905,  905,  905,  905,  905,  905,  905,  905,  905,  905,  905 },
        { xi.item.LITTLE_WORM,              xi.craftRank.AMATEUR,     800,  800,  800,  800,  800,  800,  800,  800,  800,  800,  800 },
        { xi.item.CHUNK_OF_TIN_ORE,         xi.craftRank.AMATEUR,     700,  700,  700,  700,  700,  700,  700,  700,  700,  700,  700 },
        { xi.item.CHOCOBO_FEATHER,          xi.craftRank.RECRUIT,     340,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400 },
        { xi.item.YEW_LOG,                  xi.craftRank.NOVICE,      195,  245,  300,  350,  350,  350,  350,  350,  350,  350,  350 },
        { xi.item.CHUNK_OF_ZINC_ORE,        xi.craftRank.NOVICE,      170,  215,  265,  310,  310,  310,  310,  310,  310,  310,  310 },
        { xi.item.CHESTNUT_LOG,             xi.craftRank.APPRENTICE,   85,  115,  145,  175,  205,  205,  205,  205,  205,  205,  205 },
        { xi.item.PINCH_OF_DRIED_MARJORAM,  xi.craftRank.APPRENTICE,   70,   95,  125,  150,  175,  175,  175,  175,  175,  175,  175 },
        { xi.item.MAHOGANY_LOG,             xi.craftRank.APPRENTICE,   45,   60,   80,  100,  115,  115,  115,  115,  115,  115,  115 },
    },

    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.FLINT_STONE,              xi.craftRank.AMATEUR,     810,  810,  810,  810,  810,  810,  810,  810,  810,  810,  810 },
        { xi.item.INSECT_WING,              xi.craftRank.AMATEUR,     635,  635,  635,  635,  635,  635,  635,  635,  635,  635,  635 },
        { xi.item.LIZARD_MOLT,              xi.craftRank.AMATEUR,     615,  615,  615,  615,  615,  615,  615,  615,  615,  615,  615 },
        { xi.item.CHUNK_OF_COPPER_ORE,      xi.craftRank.INITIATE,    405,  490,  575,  575,  575,  575,  575,  575,  575,  575,  575 },
        { xi.item.GIANT_FEMUR,              xi.craftRank.INITIATE,    170,  205,  240,  240,  240,  240,  240,  240,  240,  240,  240 },
        { xi.item.YELLOW_ROCK,              xi.craftRank.JOURNEYMAN,   35,   70,   95,  125,  150,  175,  175,  175,  175,  175,  175 },
        { xi.item.GOLD_BEASTCOIN,           xi.craftRank.ARTISAN,      15,   25,   30,   65,   90,  115,  135,  160,  160,  160,  160 },
        { xi.item.BLACK_CHOCOBO_FEATHER,    xi.craftRank.ADEPT,         2,    5,   10,   15,   30,   40,   50,   60,   70,   70,   70 },
        { xi.item.CHUNK_OF_ADAMAN_ORE,      xi.craftRank.EXPERT,        1,    1,    1,    2,    5,   10,   20,   25,   30,   40,   45 },
    },

    [xi.zone.NORTH_GUSTABERG] =
    {
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.INSECT_WING,              xi.craftRank.AMATEUR,     785,  785,  785,  785,  785,  785,  785,  785,  785,  785,  785 },
        { xi.item.LITTLE_WORM,              xi.craftRank.AMATEUR,     775,  775,  775,  775,  775,  775,  775,  775,  775,  775,  775 },
        { xi.item.BONE_CHIP,                xi.craftRank.AMATEUR,     625,  625,  625,  625,  625,  625,  625,  625,  625,  625,  625 },
        { xi.item.HANDFUL_OF_FISH_SCALES,   xi.craftRank.AMATEUR,     520,  520,  520,  520,  520,  520,  520,  520,  520,  520,  520 },
        { xi.item.LIZARD_MOLT,              xi.craftRank.AMATEUR,     365,  365,  365,  365,  365,  365,  365,  365,  365,  365,  365 },
        { xi.item.FLINT_STONE,              xi.craftRank.AMATEUR,     120,  120,  120,  120,  120,  120,  120,  120,  120,  120,  120 },
        { xi.item.BIRD_FEATHER,             xi.craftRank.APPRENTICE,   85,  115,  145,  175,  205,  205,  205,  205,  205,  205,  205 },
        { xi.item.MYTHRIL_BEASTCOIN,        xi.craftRank.JOURNEYMAN,   45,   90,  125,  160,  195,  230,  230,  230,  230,  230,  230 },
        { xi.item.CHUNK_OF_DARKSTEEL_ORE,   xi.craftRank.ADEPT,        10,   15,   25,   30,   60,   85,  110,  130,  155,  155,  155 },
    },

    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        { xi.item.INSECT_WING,              xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,     700,  700,  700,  700,  700,  700,  700,  700,  700,  700,  700 },
        { xi.item.LIZARD_MOLT,              xi.craftRank.AMATEUR,     615,  615,  615,  615,  615,  615,  615,  615,  615,  615,  615 },
        { xi.item.WILLOW_LOG,               xi.craftRank.INITIATE,    210,  255,  300,  300,  300,  300,  300,  300,  300,  300,  300 },
        { xi.item.CHUNK_OF_SILVER_ORE,      xi.craftRank.NOVICE,      150,  195,  235,  275,  275,  275,  275,  275,  275,  275,  275 },
        { xi.item.MYTHRIL_BEASTCOIN,        xi.craftRank.JOURNEYMAN,   50,   95,  130,  165,  200,  235,  235,  235,  235,  235,  235 },
        { xi.item.BLACK_ROCK,               xi.craftRank.JOURNEYMAN,   35,   65,   90,  115,  140,  165,  165,  165,  165,  165,  165 },
        { xi.item.PUFFBALL,                 xi.craftRank.JOURNEYMAN,   30,   60,   80,  105,  125,  145,  145,  145,  145,  145,  145 },
        { xi.item.TURTLE_SHELL,             xi.craftRank.VETERAN,       1,    1,    1,    2,    5,   10,   15,   20,   25,   30,   30 },
    },

    [xi.zone.ROLANBERRY_FIELDS] =
    {
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.FLINT_STONE,              xi.craftRank.AMATEUR,     890,  890,  890,  890,  890,  890,  890,  890,  890,  890,  890 },
        { xi.item.LITTLE_WORM,              xi.craftRank.AMATEUR,     820,  820,  820,  820,  820,  820,  820,  820,  820,  820,  820 },
        { xi.item.INSECT_WING,              xi.craftRank.AMATEUR,     630,  630,  630,  630,  630,  630,  630,  630,  630,  630,  630 },
        { xi.item.SPRIG_OF_SAGE,            xi.craftRank.APPRENTICE,  240,  330,  420,  510,  600,  600,  600,  600,  600,  600,  600 },
        { xi.item.MYTHRIL_BEASTCOIN,        xi.craftRank.JOURNEYMAN,   55,  110,  150,  195,  235,  275,  275,  275,  275,  275,  275 },
        { xi.item.RED_JAR,                  xi.craftRank.JOURNEYMAN,   50,  100,  140,  175,  215,  250,  250,  250,  250,  250,  250 },
        { xi.item.CORAL_FUNGUS,             xi.craftRank.CRAFTSMAN,    20,   30,   60,   80,  105,  125,  150,  150,  150,  150,  150 },
        { xi.item.GOLD_BEASTCOIN,           xi.craftRank.ARTISAN,      10,   15,   20,   40,   55,   70,   85,  100,  100,  100,  100 },
        { xi.item.CHUNK_OF_ORICHALCUM_ORE,  xi.craftRank.EXPERT,        1,    1,    1,    2,    5,   10,   20,   30,   35,   45,   50 },
    },

    [xi.zone.SAUROMUGUE_CHAMPAIGN] =
    {
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.BONE_CHIP,                xi.craftRank.AMATEUR,     685,  685,  685,  685,  685,  685,  685,  685,  685,  685,  685 },
        { xi.item.FLINT_STONE,              xi.craftRank.AMATEUR,     665,  665,  665,  665,  665,  665,  665,  665,  665,  665,  665 },
        { xi.item.INSECT_WING,              xi.craftRank.AMATEUR,     610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610 },
        { xi.item.LIZARD_MOLT,              xi.craftRank.AMATEUR,     335,  335,  335,  335,  335,  335,  335,  335,  335,  335,  335 },
        { xi.item.CHUNK_OF_IRON_ORE,        xi.craftRank.APPRENTICE,  130,  185,  230,  280,  330,  330,  330,  330,  330,  330,  330 },
        { xi.item.RED_JAR,                  xi.craftRank.JOURNEYMAN,   50,  100,  135,  175,  215,  250,  250,  250,  250,  250,  250 },
        { xi.item.GOLD_BEASTCOIN,           xi.craftRank.ARTISAN,      25,   40,   50,  100,  135,  175,  210,  245,  245,  245,  245 },
        { xi.item.BLACK_CHOCOBO_FEATHER,    xi.craftRank.ADEPT,         1,    2,    5,   10,   20,   30,   35,   45,   50,   50,   50 },
    },

    [xi.zone.SOUTH_GUSTABERG] =
    {
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.LITTLE_WORM,              xi.craftRank.AMATEUR,     910,  910,  910,  910,  910,  910,  910,  910,  910,  910,  910 },
        { xi.item.LIZARD_MOLT,              xi.craftRank.AMATEUR,     735,  735,  735,  735,  735,  735,  735,  735,  735,  735,  735 },
        { xi.item.BONE_CHIP,                xi.craftRank.AMATEUR,     635,  635,  635,  635,  635,  635,  635,  635,  635,  635,  635 },
        { xi.item.INSECT_WING,              xi.craftRank.AMATEUR,     450,  450,  450,  450,  450,  450,  450,  450,  450,  450,  450 },
        { xi.item.CHUNK_OF_ROCK_SALT,       xi.craftRank.APPRENTICE,  160,  220,  280,  340,  400,  400,  400,  400,  400,  400,  400 },
        { xi.item.BIRD_FEATHER,             xi.craftRank.APPRENTICE,  150,  205,  265,  320,  375,  375,  375,  375,  375,  375,  375 },
        { xi.item.MYTHRIL_BEASTCOIN,        xi.craftRank.JOURNEYMAN,   70,  140,  190,  240,  295,  345,  345,  345,  345,  345,  345 },
        { xi.item.BAG_OF_GRAIN_SEEDS,       xi.craftRank.CRAFTSMAN,    25,   35,   70,   95,  120,  145,  170,  170,  170,  170,  170 },
    },

    [xi.zone.TAHRONGI_CANYON] =
    {
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.BONE_CHIP,                xi.craftRank.AMATEUR,     875,  875,  875,  875,  875,  875,  875,  875,  875,  875,  875 },
        { xi.item.SEASHELL,                 xi.craftRank.AMATEUR,     800,  800,  800,  800,  800,  800,  800,  800,  800,  800,  800 },
        { xi.item.CHUNK_OF_TIN_ORE,         xi.craftRank.AMATEUR,     550,  550,  550,  550,  550,  550,  550,  550,  550,  550,  550 },
        { xi.item.INSECT_WING,              xi.craftRank.AMATEUR,     450,  450,  450,  450,  450,  450,  450,  450,  450,  450,  450 },
        { xi.item.YAGUDO_FEATHER,           xi.craftRank.NOVICE,      220,  280,  340,  400,  400,  400,  400,  400,  400,  400,  400 },
        { xi.item.GIANT_FEMUR,              xi.craftRank.APPRENTICE,  150,  205,  265,  320,  375,  375,  375,  375,  375,  375,  375 },
        { xi.item.RED_ROCK,                 xi.craftRank.JOURNEYMAN,   45,   90,  125,  160,  190,  225,  225,  225,  225,  225,  225 },
        { xi.item.CHUNK_OF_GOLD_ORE,        xi.craftRank.ARTISAN,      20,   30,   40,   80,  110,  140,  170,  195,  195,  195,  195 },
    },

    [xi.zone.VALKURM_DUNES] =
    {
        { xi.item.SEASHELL,                 xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.BONE_CHIP,                xi.craftRank.AMATEUR,     755,  755,  755,  755,  755,  755,  755,  755,  755,  755,  755 },
        { xi.item.HANDFUL_OF_FISH_SCALES,   xi.craftRank.AMATEUR,     470,  470,  470,  470,  470,  470,  470,  470,  470,  470,  470 },
        { xi.item.LIZARD_MOLT,              xi.craftRank.AMATEUR,     435,  435,  435,  435,  435,  435,  435,  435,  435,  435,  435 },
        { xi.item.LUGWORM,                  xi.craftRank.INITIATE,    315,  385,  450,  450,  450,  450,  450,  450,  450,  450,  450 },
        { xi.item.GIANT_FEMUR,              xi.craftRank.INITIATE,    175,  215,  250,  250,  250,  250,  250,  250,  250,  250,  250 },
        { xi.item.SHALL_SHELL,              xi.craftRank.JOURNEYMAN,   40,   75,  105,  135,  160,  190,  190,  190,  190,  190,  190 },
        { xi.item.SHELL_BUG,                xi.craftRank.JOURNEYMAN,   25,   50,   75,   90,  110,  130,  130,  130,  130,  130,  130 },
        { xi.item.TURTLE_SHELL,             xi.craftRank.VETERAN,       1,    2,    5,   10,   15,   30,   40,   55,   65,   75,   75 },
    },

    [xi.zone.WEST_RONFAURE] =
    {
        { xi.item.LITTLE_WORM,              xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.ACORN,                    xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.ARROWWOOD_LOG,            xi.craftRank.AMATEUR,     900,  900,  900,  900,  900,  900,  900,  900,  900,  900,  900 },
        { xi.item.CLUMP_OF_MOKO_GRASS,      xi.craftRank.AMATEUR,     450,  450,  450,  450,  450,  450,  450,  450,  450,  450,  450 },
        { xi.item.CHOCOBO_FEATHER,          xi.craftRank.RECRUIT,     425,  500,  500,  500,  500,  500,  500,  500,  500,  500,  500 },
        { xi.item.MAPLE_LOG,                xi.craftRank.INITIATE,    385,  470,  550,  550,  550,  550,  550,  550,  550,  550,  550 },
        { xi.item.ASH_LOG,                  xi.craftRank.INITIATE,    245,  300,  350,  350,  350,  350,  350,  350,  350,  350,  350 },
        { xi.item.RONFAURE_CHESTNUT,        xi.craftRank.INITIATE,     90,  105,  125,  125,  125,  125,  125,  125,  125,  125,  125 },
        { xi.item.CHESTNUT_LOG,             xi.craftRank.APPRENTICE,   60,   80,  105,  130,  150,  150,  150,  150,  150,  150,  150 },
        { xi.item.BAG_OF_VEGETABLE_SEEDS,   xi.craftRank.CRAFTSMAN,    25,   35,   70,   95,  120,  145,  170,  170,  170,  170,  170 },
        { xi.item.SPRIG_OF_MISTLETOE,       xi.craftRank.VETERAN,       0,    5,   10,   15,   20,   40,   55,   70,   85,  100,  100 },
    },

    [xi.zone.WEST_SARUTABARUTA] =
    {
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.LITTLE_WORM,              xi.craftRank.AMATEUR,     830,  830,  830,  830,  830,  830,  830,  830,  830,  830,  830 },
        { xi.item.LAUAN_LOG,                xi.craftRank.AMATEUR,     740,  740,  740,  740,  740,  740,  740,  740,  740,  740,  740 },
        { xi.item.INSECT_WING,              xi.craftRank.AMATEUR,     565,  565,  565,  565,  565,  565,  565,  565,  565,  565,  565 },
        { xi.item.CLUMP_OF_MOKO_GRASS,      xi.craftRank.AMATEUR,     435,  435,  435,  435,  435,  435,  435,  435,  435,  435,  435 },
        { xi.item.YAGUDO_FEATHER,           xi.craftRank.NOVICE,      215,  275,  330,  390,  390,  390,  390,  390,  390,  390,  390 },
        { xi.item.BIRD_FEATHER,             xi.craftRank.APPRENTICE,  105,  145,  180,  220,  260,  260,  260,  260,  260,  260,  260 },
        { xi.item.BALL_OF_SARUTA_COTTON,    xi.craftRank.CRAFTSMAN,    35,   50,   95,  130,  170,  205,  240,  240,  240,  240,  240 },
        { xi.item.BAG_OF_TREE_CUTTINGS,     xi.craftRank.CRAFTSMAN,    25,   35,   70,   95,  120,  145,  170,  170,  170,  170,  170 },
    },

    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {
        { xi.item.BONE_CHIP,                xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,     740,  690,  640,  590,  540,  490,  490,  490,  490,  490,  490 },
        { xi.item.GIANT_FEMUR,              xi.craftRank.RECRUIT,     425,  500,  500,  500,  500,  500,  500,  500,  500,  500,  500 },
        { xi.item.CHUNK_OF_ZINC_ORE,        xi.craftRank.NOVICE,      180,  230,  280,  330,  330,  330,  330,  330,  330,  330,  330 },
        { xi.item.CHUNK_OF_SILVER_ORE,      xi.craftRank.NOVICE,      125,  160,  190,  225,  225,  225,  225,  225,  225,  225,  225 },
        { xi.item.HANDFUL_OF_WYVERN_SCALES, xi.craftRank.ARTISAN,      25,   35,   45,   90,  125,  160,  195,  230,  230,  230,  230 },
        { xi.item.CHUNK_OF_MYTHRIL_ORE,     xi.craftRank.ARTISAN,      20,   25,   35,   70,   95,  120,  150,  175,  175,  175,  175 },
        { xi.item.CHUNK_OF_PLATINUM_ORE,    xi.craftRank.ADEPT,         5,   10,   15,   20,   40,   60,   75,   90,  105,  105,  105 },
        { xi.item.PHILOSOPHERS_STONE,       xi.craftRank.VETERAN,       1,    1,    2,    5,   10,   15,   20,   30,   35,   40,   40 },
    },

    [xi.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.BONE_CHIP,                xi.craftRank.AMATEUR,     750,  750,  750,  750,  750,  750,  750,  750,  750,  750,  750 },
        { xi.item.CLUMP_OF_MOKO_GRASS,      xi.craftRank.AMATEUR,     715,  715,  715,  715,  715,  715,  715,  715,  715,  715,  715 },
        { xi.item.ARROWWOOD_LOG,            xi.craftRank.AMATEUR,     570,  570,  570,  570,  570,  570,  570,  570,  570,  570,  570 },
        { xi.item.YEW_LOG,                  xi.craftRank.NOVICE,      195,  250,  300,  355,  355,  355,  355,  355,  355,  355,  355 },
        { xi.item.ELM_LOG,                  xi.craftRank.NOVICE,      165,  210,  255,  300,  300,  300,  300,  300,  300,  300,  300 },
        { xi.item.TRANSLUCENT_ROCK,         xi.craftRank.JOURNEYMAN,   35,   70,   95,  120,  150,  175,  175,  175,  175,  175,  175 },
        { xi.item.KING_TRUFFLE,             xi.craftRank.EXPERT,        0,    0,    5,    5,   10,   10,   20,   30,   35,   45,   50 },
    },

    [xi.zone.WESTERN_ALTEPA_DESERT] =
    {
        { xi.item.BONE_CHIP,                xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,     650,  650,  650,  650,  650,  650,  650,  650,  650,  650,  650 },
        { xi.item.GIANT_FEMUR,              xi.craftRank.RECRUIT,     445,  525,  525,  525,  525,  525,  525,  525,  525,  525,  525 },
        { xi.item.CHUNK_OF_ZINC_ORE,        xi.craftRank.NOVICE,      215,  275,  330,  390,  390,  390,  390,  390,  390,  390,  390 },
        { xi.item.CHUNK_OF_IRON_ORE,        xi.craftRank.APPRENTICE,  100,  140,  175,  215,  250,  250,  250,  250,  250,  250,  250 },
        { xi.item.CORAL_FRAGMENT,           xi.craftRank.CRAFTSMAN,    30,   45,   90,  125,  135,  190,  225,  225,  225,  225,  225 },
        { xi.item.CHUNK_OF_GOLD_ORE,        xi.craftRank.ARTISAN,      20,   30,   40,   80,  110,  140,  170,  195,  195,  195,  195 },
        { xi.item.CHUNK_OF_DARKSTEEL_ORE,   xi.craftRank.ADEPT,         2,    5,   10,   15,   30,   45,   55,   65,   80,   80,   80 },
        { xi.item.PHILOSOPHERS_STONE,       xi.craftRank.VETERAN,       1,    1,    2,    5,   10,   20,   30,   35,   45,   50,   50 },
    },

    [xi.zone.YHOATOR_JUNGLE] =
    {
        { xi.item.BONE_CHIP,                xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.LAUAN_LOG,                xi.craftRank.AMATEUR,     545,  545,  545,  545,  545,  545,  545,  545,  545,  545,  545 },
        { xi.item.KAZHAM_PINEAPPLE,         xi.craftRank.AMATEUR,     540,  540,  540,  540,  540,  540,  540,  540,  540,  540,  540 },
        { xi.item.DRYAD_ROOT,               xi.craftRank.AMATEUR,     365,  365,  365,  365,  365,  365,  365,  365,  365,  365,  365 },
        { xi.item.MAHOGANY_LOG,             xi.craftRank.JOURNEYMAN,  155,  175,  195,  215,  330,  390,  390,  390,  390,  390,  390 },
        { xi.item.EBONY_LOG,                xi.craftRank.JOURNEYMAN,   55,   85,  115,  150,  210,  270,  270,  270,  270,  270,  270 },
        { xi.item.CORAL_FUNGUS,             xi.craftRank.CRAFTSMAN,    20,   25,   55,   75,   95,  115,  135,  135,  135,  135,  135 },
        { xi.item.PETRIFIED_LOG,            xi.craftRank.ARTISAN,      10,   15,   20,   35,   50,   65,   75,   90,   90,   90,   90 },
        { xi.item.REISHI_MUSHROOM,          xi.craftRank.ADEPT,         2,    5,   10,   15,   25,   35,   45,   55,   65,   65,   65 },
    },

    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        { xi.item.BONE_CHIP,                xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.PIECE_OF_RATTAN_LUMBER,   xi.craftRank.AMATEUR,     750,  750,  750,  750,  750,  750,  750,  750,  750,  750,  750 },
        { xi.item.STICK_OF_CINNAMON,        xi.craftRank.AMATEUR,     560,  560,  560,  560,  560,  560,  560,  560,  560,  560,  560 },
        { xi.item.DANCESHROOM,              xi.craftRank.INITIATE,    275,  335,  395,  395,  395,  395,  395,  395,  395,  395,  395 },
        { xi.item.ROSEWOOD_LOG,             xi.craftRank.APPRENTICE,  100,  135,  170,  210,  245,  245,  245,  245,  245,  245,  245 },
        { xi.item.EBONY_LOG,                xi.craftRank.JOURNEYMAN,   35,   70,   95,  120,  145,  170,  170,  170,  170,  170,  170 },
        { xi.item.PETRIFIED_LOG,            xi.craftRank.ARTISAN,      15,   25,   30,   60,   85,  110,  130,  155,  155,  155,  155 },
        { xi.item.PUFFBALL,                 xi.craftRank.VETERAN,       2,    5,   10,   15,   20,   40,   55,   70,   85,  100,  100 },
        { xi.item.KING_TRUFFLE,             xi.craftRank.EXPERT,        1,    1,    2,    5,   10,   10,   20,   30,   35,   45,   50 },
    },

    [xi.zone.BIBIKI_BAY] =
    {
        { xi.item.SEASHELL,                 xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.CHUNK_OF_TIN_ORE,         xi.craftRank.AMATEUR,     875,  875,  875,  875,  875,  875,  875,  875,  875,  875,  875 },
        { xi.item.LUGWORM,                  xi.craftRank.INITIATE,    560,  675,  795,  795,  795,  795,  795,  795,  795,  795,  795 },
        { xi.item.GIANT_FEMUR,              xi.craftRank.INITIATE,    280,  345,  400,  400,  400,  400,  400,  400,  400,  400,  400 },
        { xi.item.BIRD_FEATHER,             xi.craftRank.APPRENTICE,  320,  445,  560,  675,  795,  795,  795,  795,  795,  795,  795 },
        { xi.item.SHALL_SHELL,              xi.craftRank.JOURNEYMAN,   60,  125,  170,  220,  260,  310,  310,  310,  310,  310,  310 },
        { xi.item.SHELL_BUG,                xi.craftRank.JOURNEYMAN,   85,  160,  220,  285,  345,  405,  405,  405,  405,  405,  405 },
        { xi.item.TURTLE_SHELL,             xi.craftRank.VETERAN,       2,    5,   10,   15,   25,   40,   55,   70,   85,  100,  100 },
    },

    [xi.zone.CARPENTERS_LANDING] =
    {
        { xi.item.ACORN,                    xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.LITTLE_WORM,              xi.craftRank.AMATEUR,     835,  835,  835,  835,  835,  835,  835,  835,  835,  835,  835 },
        { xi.item.ARROWWOOD_LOG,            xi.craftRank.AMATEUR,     610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610 },
        { xi.item.MAPLE_LOG,                xi.craftRank.INITIATE,    530,  645,  760,  760,  760,  760,  760,  760,  760,  760,  760 },
        { xi.item.HOLLY_LOG,                xi.craftRank.INITIATE,    270,  325,  385,  385,  385,  385,  385,  385,  385,  385,  385 },
        { xi.item.WILLOW_LOG,               xi.craftRank.INITIATE,    265,  320,  375,  375,  375,  375,  375,  375,  375,  375,  375 },
        { xi.item.OAK_LOG,                  xi.craftRank.JOURNEYMAN,   35,   75,  100,  130,  155,  185,  185,  185,  185,  185,  185 },
        { xi.item.SCREAM_FUNGUS,            xi.craftRank.ARTISAN,      15,   20,   25,   50,   70,   90,  110,  130,  130,  130,  130 },
        { xi.item.SPRIG_OF_MISTLETOE,       xi.craftRank.VETERAN,       2,    5,   10,   15,   20,   40,   55,   70,   85,  100,  100 },
        { xi.item.KING_TRUFFLE,             xi.craftRank.EXPERT,        1,    1,    2,    5,   10,   10,   20,   30,   35,   45,   50 },
    },

    [xi.zone.BHAFLAU_THICKETS] =
    {
        { xi.item.PINCH_OF_DRIED_MARJORAM,  xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,     650,  650,  650,  650,  650,  650,  650,  650,  650,  650,  650 },
        { xi.item.HANDFUL_OF_PINE_NUTS,     xi.craftRank.RECRUIT,     470,  550,  550,  550,  550,  550,  550,  550,  550,  550,  550 },
        { xi.item.COLIBRI_FEATHER,          xi.craftRank.JOURNEYMAN,   80,  150,  215,  280,  345,  430,  430,  430,  430,  430,  430 },
        { xi.item.PETRIFIED_LOG,            xi.craftRank.CRAFTSMAN,    50,   70,  135,  190,  240,  290,  340,  340,  340,  340,  340 },
        { xi.item.BLUE_ROCK,                xi.craftRank.ARTISAN,      15,   25,   45,   90,  125,  160,  200,  250,  250,  250,  250 },
        { xi.item.LESSER_CHIGOE,            xi.craftRank.ADEPT,        10,   15,   20,   30,   60,   80,  100,  125,  145,  145,  145 },
        { xi.item.SPIDER_WEB,               xi.craftRank.VETERAN,       1,    2,    5,   10,   15,   30,   40,   50,   60,   75,   75 },
        { xi.item.CHUNK_OF_ORICHALCUM_ORE,  xi.craftRank.EXPERT,        1,    1,    1,    1,    2,    5,   10,   15,   20,   30,   40 },
    },

    [xi.zone.WAJAOM_WOODLANDS] =
    {
        { xi.item.CLUMP_OF_MOKO_GRASS,      xi.craftRank.AMATEUR,    1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 },
        { xi.item.PEBBLE,                   xi.craftRank.AMATEUR,     900,  900,  900,  900,  900,  900,  900,  900,  900,  900,  900 },
        { xi.item.HANDFUL_OF_PINE_NUTS,     xi.craftRank.RECRUIT,     480,  600,  600,  600,  600,  600,  600,  600,  600,  600,  600 },
        { xi.item.BLACK_CHOCOBO_FEATHER,    xi.craftRank.RECRUIT,     315,  315,  315,  315,  315,  315,  315,  315,  315,  315,  315 },
        { xi.item.BLUE_ROCK,                xi.craftRank.JOURNEYMAN,   40,   80,  110,  140,  170,  200,  200,  200,  200,  200,  200 },
        { xi.item.EBONY_LOG,                xi.craftRank.CRAFTSMAN,    35,   45,   90,  125,  160,  190,  220,  220,  220,  220,  220 },
        { xi.item.PEPHREDO_HIVE_CHIP,       xi.craftRank.ADEPT,         1,    2,    5,   15,   25,   40,   60,   85,  110,  110,  110 },
        { xi.item.SPIDER_WEB,               xi.craftRank.VETERAN,       1,    2,    3,    8,   15,   30,   45,   55,   65,   80,   80 },
        { xi.item.CHUNK_OF_ADAMAN_ORE,      xi.craftRank.EXPERT,        1,    1,    2,    5,    5,   10,   15,   20,   25,   30,   40 },
    }
}
