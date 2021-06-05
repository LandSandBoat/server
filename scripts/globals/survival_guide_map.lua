require("scripts/globals/zone")

local survival = {}

survival.survivalGuides =
{
    [6] =
    {
        zoneId = xi.zone.WEST_RONFAURE,
        group = 1,
        groupMask = 2^0,
        groupIndex = 1,
        posX = -451.4,
        posY = -19.75,
        posZ = -218,
        posRot = 128
    },
    [11] =
    {
        zoneId = xi.zone.VALKURM_DUNES,
        group = 1,
        groupMask = 2^1,
        groupIndex = 2,
        posX = 137.9,
        posY = -7.5,
        posZ = 97,
        posRot = 162
    },
    [16] =
    {
        zoneId = xi.zone.JUGNER_FOREST,
        group = 1,
        groupMask = 2^2,
        groupIndex = 3,
        posX = 62.99,
        posY = 0,
        posZ = -12.75,
        posRot = 65
    },
    [20] =
    {
        zoneId = xi.zone.NORTH_GUSTABERG,
        group = 1,
        groupMask = 2^3,
        groupIndex = 4,
        posX = -581.84,
        posY = 40,
        posZ = 53.14,
        posRot = 96
    },
    [24] =
    {
        zoneId = xi.zone.PASHHOW_MARSHLANDS,
        group = 1,
        groupMask = 2^4,
        groupIndex = 5,
        posX = 466.06,
        posY = 24,
        posZ = 410.91,
        posRot = 32
    },
    [28] =
    {
        zoneId = xi.zone.WEST_SARUTABARUTA,
        group = 1,
        groupMask = 2^5,
        groupIndex = 6,
        posX = -14.75,
        posY = -12,
        posZ = 315.75,
        posRot = 0
    },
    [33] =
    {
        zoneId = xi.zone.BUBURIMU_PENINSULA,
        group = 1,
        groupMask = 2^6,
        groupIndex = 7,
        posX = -485.74,
        posY = -32,
        posZ = 47.32,
        posRot = 64
    },
    [40] =
    {
        zoneId = xi.zone.BEAUCEDINE_GLACIER,
        group = 1,
        groupMask = 2^7,
        groupIndex = 8,
        posX = -28.92,
        posY = -59,
        posZ = -124.07,
        posRot = 32
    },
    [42] =
    {
        zoneId = xi.zone.XARCABARD,
        group = 1,
        groupMask = 2^8,
        groupIndex = 9,
        posX = 203.98,
        posY = -24.27,
        posZ = -204.31,
        posRot = 192
    },
    [44] =
    {
        zoneId = xi.zone.QUFIM_ISLAND,
        group = 1,
        groupMask = 2^9,
        groupIndex = 10,
        posX = -251.98,
        posY = -19.96,
        posZ = 298.21,
        posRot = 64
    },
    [36] =
    {
        zoneId = xi.zone.MERIPHATAUD_MOUNTAINS,
        group = 1,
        groupMask = 2^10,
        groupIndex = 11,
        posX = -297.76,
        posY = 17,
        posZ = 422.22,
        posRot = 224
    },
    [47] =
    {
        zoneId = xi.zone.THE_SANCTUARY_OF_ZITAH,
        group = 1,
        groupMask = 2^11,
        groupIndex = 12,
        posX = -44.98,
        posY = 0.27,
        posZ = -149.86,
        posRot = 64
    },
    [50] =
    {
        zoneId = xi.zone.EASTERN_ALTEPA_DESERT,
        group = 1,
        groupMask = 2^12,
        groupIndex = 13,
        posX = -258.88,
        posY = 8.6,
        posZ = -265,
        posRot = 128
    },
    [53] =
    {
        zoneId = xi.zone.CAPE_TERIGGAN,
        group = 1,
        groupMask = 2^13,
        groupIndex = 14,
        posX = -186.67,
        posY = 7.9,
        posZ = -67,
        posRot = 128
    },
    [57] =
    {
        zoneId = xi.zone.YUHTUNGA_JUNGLE,
        group = 1,
        groupMask = 2^14,
        groupIndex = 15,
        posX = -239.51,
        posY = 0,
        posZ = -402.77,
        posRot = 64
    },
    [61] =
    {
        zoneId = xi.zone.YHOATOR_JUNGLE,
        group = 1,
        groupMask = 2^15,
        groupIndex = 16,
        posX = 197.82,
        posY = 0,
        posZ = -81.82,
        posRot = 160
    },
    [66] =
    {
        zoneId = xi.zone.LUFAISE_MEADOWS,
        group = 1,
        groupMask = 2^16,
        groupIndex = 17,
        posX = -554,
        posY = -6.2,
        posZ = -57.11,
        posRot = 192
    },
    [64] =
    {
        zoneId = xi.zone.RUAUN_GARDENS,
        group = 1,
        groupMask = 2^17,
        groupIndex = 18,
        posX = 12.99,
        posY = -54.16,
        posZ = -594.21,
        posRot = 192
    },
    [65] =
    {
        zoneId = xi.zone.OLDTON_MOVALPOLOS,
        group = 1,
        groupMask = 2^18,
        groupIndex = 19,
        posX = -260.78,
        posY = 8,
        posZ = -54,
        posRot = 128
    },
    [8] =
    {
        zoneId = xi.zone.BOSTAUNIEUX_OUBLIETTE,
        group = 1,
        groupMask = 2^19,
        groupIndex = 20,
        posX = -12.88,
        posY = 0.1,
        posZ = 25.45,
        posRot = 0
    },
    [29] =
    {
        zoneId = xi.zone.TORAIMARAI_CANAL,
        group = 1,
        groupMask = 2^20,
        groupIndex = 21,
        posX = -308.25,
        posY = 15,
        posZ = 260.78,
        posRot = 192
    },
    [19] =
    {
        zoneId = xi.zone.THE_ELDIEME_NECROPOLIS,
        group = 1,
        groupMask = 2^21,
        groupIndex = 22,
        posX = 419.21,
        posY = -52.25,
        posZ = -99.5,
        posRot = 128
    },
    [27] =
    {
        zoneId = xi.zone.CRAWLERS_NEST,
        group = 1,
        groupMask = 2^22,
        groupIndex = 23,
        posX = 364,
        posY = -32.2,
        posZ = -22.03,
        posRot = 64
    },
    [39] =
    {
        zoneId = xi.zone.GARLAIGE_CITADEL,
        group = 1,
        groupMask = 2^23,
        groupIndex = 24,
        posX = -381.75,
        posY = -6,
        posZ = 363.5,
        posRot = 128
    },
    [0] =
    {
        zoneId = xi.zone.NORTHERN_SAN_DORIA,
        group = 1,
        groupMask = 2^24,
        groupIndex = 25,
        posX = -175.21,
        posY = -4,
        posZ = 80,
        posRot = 0
    },
    [1] =
    {
        zoneId = xi.zone.BASTOK_MINES,
        group = 1,
        groupMask = 2^25,
        groupIndex = 26,
        posX = 18.82,
        posY = 0,
        posZ = -115,
        posRot = 0
    },
    [2] =
    {
        zoneId = xi.zone.PORT_WINDURST,
        group = 1,
        groupMask = 2^26,
        groupIndex = 27,
        posX = -220,
        posY = -8.09,
        posZ = 180.15,
        posRot = 64
    },
    [3] =
    {
        zoneId = xi.zone.RULUDE_GARDENS,
        group = 1,
        groupMask = 2^27,
        groupIndex = 28,
        posX = 44.25,
        posY = 10,
        posZ = -69,
        posRot = 128
    },
    [10] =
    {
        zoneId = xi.zone.LA_THEINE_PLATEAU,
        group = 1,
        groupMask = 2^28,
        groupIndex = 29,
        posX = 774.35,
        posY = 29,
        posZ = -18.57,
        posRot = 224
    },
    [17] =
    {
        zoneId = xi.zone.BATALLIA_DOWNS,
        group = 1,
        groupMask = 2^29,
        groupIndex = 30,
        posX = -67,
        posY = -1.7,
        posZ = 448.25,
        posRot = 192
    },
    [12] =
    {
        zoneId = xi.zone.KONSCHTAT_HIGHLANDS,
        group = 1,
        groupMask = 2^30,
        groupIndex = 31,
        posX = -223,
        posY = 71.07,
        posZ = 828,
        posRot = 32
    },
    [25] =
    {
        zoneId = xi.zone.ROLANBERRY_FIELDS,
        group = 1,
        groupMask = 2^31,
        groupIndex = 32,
        posX = -227.97,
        posY = 4.54,
        posZ = 386.94,
        posRot = 64
    },
    [32] =
    {
        zoneId = xi.zone.TAHRONGI_CANYON,
        group = 2,
        groupMask = 2^0,
        groupIndex = 1,
        posX = -160,
        posY = 47.25,
        posZ = 647.11,
        posRot = 192
    },
    [37] =
    {
        zoneId = xi.zone.SAUROMUGUE_CHAMPAIGN,
        group = 2,
        groupMask = 2^1,
        groupIndex = 2,
        posX = 344.83,
        posY = 6.22,
        posZ = -255.3,
        posRot = 96
    },
    [7] =
    {
        zoneId = xi.zone.FORT_GHELSBA,
        group = 2,
        groupMask = 2^2,
        groupIndex = 3,
        posX = -142.24,
        posY = -19.93,
        posZ = 7.75,
        posRot = 96
    },
    [26] =
    {
        zoneId = xi.zone.BEADEAUX,
        group = 2,
        groupMask = 2^3,
        groupIndex = 4,
        posX = -263.99,
        posY = 1.59,
        posZ = 105.86,
        posRot = 192
    },
    [18] =
    {
        zoneId = xi.zone.DAVOI,
        group = 2,
        groupMask = 2^4,
        groupIndex = 5,
        posX = 221.75,
        posY = -1,
        posZ = -10,
        posRot = 0
    },
    [38] =
    {
        zoneId = xi.zone.CASTLE_OZTROJA,
        group = 2,
        groupMask = 2^5,
        groupIndex = 6,
        posX = -221,
        posY = 0.25,
        posZ = -14.25,
        posRot = 192
    },
    [43] =
    {
        zoneId = xi.zone.CASTLE_ZVAHL_BAILEYS,
        group = 2,
        groupMask = 2^6,
        groupIndex = 7,
        posX = 372,
        posY = -12.05,
        posZ = -23.85,
        posRot = 64
    },
    [41] =
    {
        zoneId = xi.zone.RANGUEMONT_PASS,
        group = 2,
        groupMask = 2^7,
        groupIndex = 8,
        posX = -145.24,
        posY = 4.37,
        posZ = -298.79,
        posRot = 160
    },
    [46] =
    {
        zoneId = xi.zone.LOWER_DELKFUTTS_TOWER,
        group = 2,
        groupMask = 2^8,
        groupIndex = 9,
        posX = 462.73,
        posY = 0,
        posZ = -51,
        posRot = 0
    },
    [9] =
    {
        zoneId = xi.zone.KING_RANPERRES_TOMB,
        group = 2,
        groupMask = 2^9,
        groupIndex = 10,
        posX = -120.23,
        posY = 0,
        posZ = 248.57,
        posRot = 0
    },
    [23] =
    {
        zoneId = xi.zone.DANGRUF_WADI,
        group = 2,
        groupMask = 2^10,
        groupIndex = 11,
        posX = -23.16,
        posY = 0.35,
        posZ = 0.15,
        posRot = 160
    },
    [30] =
    {
        zoneId = xi.zone.INNER_HORUTOTO_RUINS,
        group = 2,
        groupMask = 2^11,
        groupIndex = 12,
        posX = 452.94,
        posY = -8,
        posZ = 181.07,
        posRot = 192
    },
    [13] =
    {
        zoneId = xi.zone.ORDELLES_CAVES,
        group = 2,
        groupMask = 2^12,
        groupIndex = 13,
        posX = -102.91,
        posY = 0.1,
        posZ = 632.9,
        posRot = 128
    },
    [14] =
    {
        zoneId = xi.zone.GUSGEN_MINES,
        group = 2,
        groupMask = 2^13,
        groupIndex = 14,
        posX = 59.91,
        posY = -67.93,
        posZ = -267.18,
        posRot = 192
    },
    [34] =
    {
        zoneId = xi.zone.MAZE_OF_SHAKHRAMI,
        group = 2,
        groupMask = 2^14,
        groupIndex = 15,
        posX = -338.99,
        posY = -12.21,
        posZ = -179,
        posRot = 0
    },
    [48] =
    {
        zoneId = xi.zone.ROMAEVE,
        group = 2,
        groupMask = 2^15,
        groupIndex = 16,
        posX = 13.75,
        posY = -28.25,
        posZ = 54.04,
        posRot = 32
    },
    [51] =
    {
        zoneId = xi.zone.WESTERN_ALTEPA_DESERT,
        group = 2,
        groupMask = 2^16,
        groupIndex = 17,
        posX = 419.33,
        posY = -3.12,
        posZ = 11.68,
        posRot = 32
    },
    [62] =
    {
        zoneId = xi.zone.TEMPLE_OF_UGGALEPIH,
        group = 2,
        groupMask = 2^17,
        groupIndex = 18,
        posX = 60.01,
        posY = -8,
        posZ = 58.19,
        posRot = 64
    },
    [22] =
    {
        zoneId = xi.zone.KORROLOKA_TUNNEL,
        group = 2,
        groupMask = 2^18,
        groupIndex = 19,
        posX = -463.82,
        posY = -10.08,
        posZ = -22.2,
        posRot = 32
    },
    [55] =
    {
        zoneId = xi.zone.KUFTAL_TUNNEL,
        group = 2,
        groupMask = 2^19,
        groupIndex = 20,
        posX = -16.84,
        posY = -20.47,
        posZ = -237,
        posRot = 0
    },
    [58] =
    {
        zoneId = xi.zone.SEA_SERPENT_GROTTO,
        group = 2,
        groupMask = 2^20,
        groupIndex = 21,
        posX = 223.97,
        posY = -23.71,
        posZ = 334.99,
        posRot = 128
    },
    [56] =
    {
        zoneId = xi.zone.GUSTAV_TUNNEL,
        group = 2,
        groupMask = 2^21,
        groupIndex = 22,
        posX = 296.68,
        posY = -40.42,
        posZ = 64.68,
        posRot = 96
    },
    [35] =
    {
        zoneId = xi.zone.LABYRINTH_OF_ONZOZO,
        group = 2,
        groupMask = 2^22,
        groupIndex = 23,
        posX = -62.3,
        posY = -20.1,
        posZ = -280.69,
        posRot = 160
    },
    [15] =
    {
        zoneId = xi.zone.CARPENTERS_LANDING,
        group = 2,
        groupMask = 2^23,
        groupIndex = 24,
        posX = 224.99,
        posY = -2,
        posZ = -529.26,
        posRot = 192
    },
    [31] =
    {
        zoneId = xi.zone.BIBIKI_BAY,
        group = 2,
        groupMask = 2^24,
        groupIndex = 25,
        posX = 493.72,
        posY = -3.04,
        posZ = 728.05,
        posRot = 0
    },
    [67] =
    {
        zoneId = xi.zone.MISAREAUX_COAST,
        group = 2,
        groupMask = 2^25,
        groupIndex = 26,
        posX = -60.98,
        posY = -29.96,
        posZ = 262.22,
        posRot = 64
    },
    [68] =
    {
        zoneId = xi.zone.PHOMIUNA_AQUEDUCTS,
        group = 2,
        groupMask = 2^26,
        groupIndex = 27,
        posX = 253.18,
        posY = 0,
        posZ = -266.02,
        posRot = 128
    },
    [69] =
    {
        zoneId = xi.zone.SACRARIUM,
        group = 2,
        groupMask = 2^27,
        groupIndex = 28,
        posX = -219.99,
        posY = -12,
        posZ = 58.27,
        posRot = 64
    },
    [70] =
    {
        zoneId = xi.zone.WAJAOM_WOODLANDS,
        group = 2,
        groupMask = 2^28,
        groupIndex = 29,
        posX = -838.97,
        posY = -20,
        posZ = 99.19,
        posRot = 64
    },
    [71] =
    {
        zoneId = xi.zone.MAMOOK,
        group = 2,
        groupMask = 2^29,
        groupIndex = 30,
        posX = 217.16,
        posY = -23.84,
        posZ = -103.14,
        posRot = 32
    },
    [72] =
    {
        zoneId = xi.zone.AYDEEWA_SUBTERRANE,
        group = 2,
        groupMask = 2^30,
        groupIndex = 31,
        posX = 5,
        posY = 20.67,
        posZ = -89.98,
        posRot = 128
    },
    [78] =
    {
        zoneId = xi.zone.EAST_RONFAURE_S,
        group = 2,
        groupMask = 2^31,
        groupIndex = 32,
        posX = 662.02,
        posY = -18.96,
        posZ = -595.91,
        posRot = 64
    },
    [79] =
    {
        zoneId = xi.zone.JUGNER_FOREST_S,
        group = 3,
        groupMask = 2^0,
        groupIndex = 1,
        posX = -193.97,
        posY = -7.75,
        posZ = -493.8,
        posRot = 64
    },
    [85] =
    {
        zoneId = xi.zone.VUNKERL_INLET_S,
        group = 3,
        groupMask = 2^1,
        groupIndex = 2,
        posX = -521.01,
        posY = -32.36,
        posZ = 205.91,
        posRot = 192
    },
    [80] =
    {
        zoneId = xi.zone.BATALLIA_DOWNS_S,
        group = 3,
        groupMask = 2^2,
        groupIndex = 3,
        posX = -404,
        posY = -16.02,
        posZ = -164.28,
        posRot = 192
    },
    [83] =
    {
        zoneId = xi.zone.NORTH_GUSTABERG_S,
        group = 3,
        groupMask = 2^3,
        groupIndex = 4,
        posX = -289,
        posY = 38.64,
        posZ = 531.99,
        posRot = 192
    },
    [84] =
    {
        zoneId = xi.zone.GRAUBERG_S,
        group = 3,
        groupMask = 2^4,
        groupIndex = 5,
        posX = 794,
        posY = 71.48,
        posZ = 773.16,
        posRot = 64
    },
    [86] =
    {
        zoneId = xi.zone.PASHHOW_MARSHLANDS_S,
        group = 3,
        groupMask = 2^5,
        groupIndex = 6,
        posX = 547.8,
        posY = 25,
        posZ = -341,
        posRot = 0
    },
    [87] =
    {
        zoneId = xi.zone.ROLANBERRY_FIELDS_S,
        group = 3,
        groupMask = 2^6,
        groupIndex = 7,
        posX = -38,
        posY = 0.5,
        posZ = -866.97,
        posRot = 224
    },
    [90] =
    {
        zoneId = xi.zone.WEST_SARUTABARUTA_S,
        group = 3,
        groupMask = 2^7,
        groupIndex = 8,
        posX = 83,
        posY = -24.65,
        posZ = 566.09,
        posRot = 192
    },
    [91] =
    {
        zoneId = xi.zone.FORT_KARUGO_NARUGO_S,
        group = 3,
        groupMask = 2^8,
        groupIndex = 9,
        posX = 125.37,
        posY = -20.91,
        posZ = 605.38,
        posRot = 224
    },
    [92] =
    {
        zoneId = xi.zone.MERIPHATAUD_MOUNTAINS_S,
        group = 3,
        groupMask = 2^9,
        groupIndex = 10,
        posX = 732.9,
        posY = -33.5,
        posZ = -10,
        posRot = 0
    },
    [93] =
    {
        zoneId = xi.zone.SAUROMUGUE_CHAMPAIGN_S,
        group = 3,
        groupMask = 2^10,
        groupIndex = 11,
        posX = 475.97,
        posY = -8.04,
        posZ = -438.29,
        posRot = 192
    },
    [95] =
    {
        zoneId = xi.zone.BEAUCEDINE_GLACIER_S,
        group = 3,
        groupMask = 2^11,
        groupIndex = 12,
        posX = -144.01,
        posY = -80.13,
        posZ = 232.59,
        posRot = 192
    },
    [96] =
    {
        zoneId = xi.zone.CASTLE_ZVAHL_BAILEYS_S,
        group = 3,
        groupMask = 2^12,
        groupIndex = 13,
        posX = 372,
        posY = -12.05,
        posZ = -23.78,
        posRot = 64
    },
    [94] =
    {
        zoneId = xi.zone.GARLAIGE_CITADEL_S,
        group = 3,
        groupMask = 2^13,
        groupIndex = 14,
        posX = -301.8,
        posY = -6.08,
        posZ = 127.37,
        posRot = 128
    },
    [88] =
    {
        zoneId = xi.zone.CRAWLERS_NEST_S,
        group = 3,
        groupMask = 2^14,
        groupIndex = 15,
        posX = 363.99,
        posY = -32.2,
        posZ = -22.07,
        posRot = 64
    },
    [81] =
    {
        zoneId = xi.zone.THE_ELDIEME_NECROPOLIS_S,
        group = 3,
        groupMask = 2^15,
        groupIndex = 16,
        posX = 419.29,
        posY = -52.25,
        posZ = -99.41,
        posRot = 128
    },
    [59] =
    {
        zoneId = xi.zone.KAZHAM,
        group = 3,
        groupMask = 2^16,
        groupIndex = 17,
        posX = -41.21,
        posY = -10,
        posZ = -93,
        posRot = 0
    },
    [60] =
    {
        zoneId = xi.zone.NORG,
        group = 3,
        groupMask = 2^17,
        groupIndex = 18,
        posX = -13.84,
        posY = 1.1,
        posZ = -33.14,
        posRot = 32
    },
    [52] =
    {
        zoneId = xi.zone.RABAO,
        group = 3,
        groupMask = 2^18,
        groupIndex = 19,
        posX = -3.41,
        posY = -2.7,
        posZ = -93.6,
        posRot = 64
    },
    [4] =
    {
        zoneId = xi.zone.TAVNAZIAN_SAFEHOLD,
        group = 3,
        groupMask = 2^19,
        groupIndex = 20,
        posX = -4.99,
        posY = -28.08,
        posZ = 103.1,
        posRot = 64
    },
    [5] =
    {
        zoneId = xi.zone.AHT_URHGAN_WHITEGATE,
        group = 3,
        groupMask = 2^20,
        groupIndex = 21,
        posX = 133.13,
        posY = 0,
        posZ = 16.17,
        posRot = 224
    },
    [74] =
    {
        zoneId = xi.zone.NASHMAU,
        group = 3,
        groupMask = 2^21,
        groupIndex = 22,
        posX = -18.8,
        posY = 0,
        posZ = -33.01,
        posRot = 128
    },
    [77] =
    {
        zoneId = xi.zone.SOUTHERN_SAN_DORIA_S,
        group = 3,
        groupMask = 2^22,
        groupIndex = 23,
        posX = 82.02,
        posY = 1,
        posZ = -66.79,
        posRot = 64
    },
    [82] =
    {
        zoneId = xi.zone.BASTOK_MARKETS_S,
        group = 3,
        groupMask = 2^23,
        groupIndex = 24,
        posX = -246.17,
        posY = 0,
        posZ = 94.13,
        posRot = 160
    },
    [89] =
    {
        zoneId = xi.zone.WINDURST_WATERS_S,
        group = 3,
        groupMask = 2^24,
        groupIndex = 25,
        posX = -57.08,
        posY = -5.71,
        posZ = 215.99,
        posRot = 128
    },
    [76] =
    {
        zoneId = xi.zone.CAEDARVA_MIRE,
        group = 3,
        groupMask = 2^25,
        groupIndex = 26,
        posX = -660,
        posY = -13.36,
        posZ = 342.78,
        posRot = 64
    },
    [75] =
    {
        zoneId = xi.zone.ARRAPAGO_REEF,
        group = 3,
        groupMask = 2^26,
        groupIndex = 27,
        posX = 475.97,
        posY = -15.64,
        posZ = -20,
        posRot = 128
    },
    [73] =
    {
        zoneId = xi.zone.HALVUNG,
        group = 3,
        groupMask = 2^27,
        groupIndex = 28,
        posX = 503.23,
        posY = -0.17,
        posZ = 241.76,
        posRot = 32
    },
    [45] =
    {
        zoneId = xi.zone.BEHEMOTHS_DOMINION,
        group = 3,
        groupMask = 2^28,
        groupIndex = 29,
        posX = 337.41,
        posY = 26.63,
        posZ = -73.95,
        posRot = 128
    },
    [49] =
    {
        zoneId = xi.zone.DRAGONS_AERY,
        group = 3,
        groupMask = 2^29,
        groupIndex = 30,
        posX = -60.33,
        posY = -1.17,
        posZ = -33.69,
        posRot = 160
    },
    [54] =
    {
        zoneId = xi.zone.VALLEY_OF_SORROWS,
        group = 3,
        groupMask = 2^30,
        groupIndex = 31,
        posX = -163.3,
        posY = -8.29,
        posZ = 23.04,
        posRot = 0
    },
    [63] =
    {
        zoneId = xi.zone.IFRITS_CAULDRON,
        group = 3,
        groupMask = 2^31,
        groupIndex = 32,
        posX = 89,
        posY = 0.32,
        posZ = -298.11,
        posRot = 192
    },
    [21] =
    {
        zoneId = xi.zone.ZERUHN_MINES,
        group = 4,
        groupMask = 2^0,
        groupIndex = 1,
        posX = -10.05,
        posY = 0,
        posZ = 5.81,
        posRot = 192
    },
    [97] =
    {
        zoneId = xi.zone.EASTERN_ADOULIN,
        group = 4,
        groupMask = 2^1,
        groupIndex = 2,
        posX = -53.5,
        posY = 0.15,
        posZ = -116.93,
        posRot = 64
    }
}

survival.zoneIdToGuideIdMap =
{
    [xi.zone.NORTHERN_SAN_DORIA] = 0,
    [xi.zone.BASTOK_MINES] = 1,
    [xi.zone.PORT_WINDURST] = 2,
    [xi.zone.RULUDE_GARDENS] = 3,
    [xi.zone.TAVNAZIAN_SAFEHOLD] = 4,
    [xi.zone.AHT_URHGAN_WHITEGATE] = 5,
    [xi.zone.WEST_RONFAURE] = 6,
    [xi.zone.FORT_GHELSBA] = 7,
    [xi.zone.BOSTAUNIEUX_OUBLIETTE] = 8,
    [xi.zone.KING_RANPERRES_TOMB] = 9,
    [xi.zone.LA_THEINE_PLATEAU] = 10,
    [xi.zone.VALKURM_DUNES] = 11,
    [xi.zone.KONSCHTAT_HIGHLANDS] = 12,
    [xi.zone.ORDELLES_CAVES] = 13,
    [xi.zone.GUSGEN_MINES] = 14,
    [xi.zone.CARPENTERS_LANDING] = 15,
    [xi.zone.JUGNER_FOREST] = 16,
    [xi.zone.BATALLIA_DOWNS] = 17,
    [xi.zone.DAVOI] = 18,
    [xi.zone.THE_ELDIEME_NECROPOLIS] = 19,
    [xi.zone.NORTH_GUSTABERG] = 20,
    [xi.zone.ZERUHN_MINES] = 21,
    [xi.zone.KORROLOKA_TUNNEL] = 22,
    [xi.zone.DANGRUF_WADI] = 23,
    [xi.zone.PASHHOW_MARSHLANDS] = 24,
    [xi.zone.ROLANBERRY_FIELDS] = 25,
    [xi.zone.BEADEAUX] = 26,
    [xi.zone.CRAWLERS_NEST] = 27,
    [xi.zone.WEST_SARUTABARUTA] = 28,
    [xi.zone.TORAIMARAI_CANAL] = 29,
    [xi.zone.INNER_HORUTOTO_RUINS] = 30,
    [xi.zone.BIBIKI_BAY] = 31,
    [xi.zone.TAHRONGI_CANYON] = 32,
    [xi.zone.BUBURIMU_PENINSULA] = 33,
    [xi.zone.MAZE_OF_SHAKHRAMI] = 34,
    [xi.zone.LABYRINTH_OF_ONZOZO] = 35,
    [xi.zone.MERIPHATAUD_MOUNTAINS] = 36,
    [xi.zone.SAUROMUGUE_CHAMPAIGN] = 37,
    [xi.zone.CASTLE_OZTROJA] = 38,
    [xi.zone.GARLAIGE_CITADEL] = 39,
    [xi.zone.BEAUCEDINE_GLACIER] = 40,
    [xi.zone.RANGUEMONT_PASS] = 41,
    [xi.zone.XARCABARD] = 42,
    [xi.zone.CASTLE_ZVAHL_BAILEYS] = 43,
    [xi.zone.QUFIM_ISLAND] = 44,
    [xi.zone.BEHEMOTHS_DOMINION] = 45,
    [xi.zone.LOWER_DELKFUTTS_TOWER] = 46,
    [xi.zone.THE_SANCTUARY_OF_ZITAH] = 47,
    [xi.zone.ROMAEVE] = 48,
    [xi.zone.DRAGONS_AERY] = 49,
    [xi.zone.EASTERN_ALTEPA_DESERT] = 50,
    [xi.zone.WESTERN_ALTEPA_DESERT] = 51,
    [xi.zone.RABAO] = 52,
    [xi.zone.CAPE_TERIGGAN] = 53,
    [xi.zone.VALLEY_OF_SORROWS] = 54,
    [xi.zone.KUFTAL_TUNNEL] = 55,
    [xi.zone.GUSTAV_TUNNEL] = 56,
    [xi.zone.YUHTUNGA_JUNGLE] = 57,
    [xi.zone.SEA_SERPENT_GROTTO] = 58,
    [xi.zone.KAZHAM] = 59,
    [xi.zone.NORG] = 60,
    [xi.zone.YHOATOR_JUNGLE] = 61,
    [xi.zone.TEMPLE_OF_UGGALEPIH] = 62,
    [xi.zone.IFRITS_CAULDRON] = 63,
    [xi.zone.RUAUN_GARDENS] = 64,
    [xi.zone.OLDTON_MOVALPOLOS] = 65,
    [xi.zone.LUFAISE_MEADOWS] = 66,
    [xi.zone.MISAREAUX_COAST] = 67,
    [xi.zone.PHOMIUNA_AQUEDUCTS] = 68,
    [xi.zone.SACRARIUM] = 69,
    [xi.zone.WAJAOM_WOODLANDS] = 70,
    [xi.zone.MAMOOK] = 71,
    [xi.zone.AYDEEWA_SUBTERRANE] = 72,
    [xi.zone.HALVUNG] = 73,
    [xi.zone.NASHMAU] = 74,
    [xi.zone.ARRAPAGO_REEF] = 75,
    [xi.zone.CAEDARVA_MIRE] = 76,
    [xi.zone.SOUTHERN_SAN_DORIA_S] = 77,
    [xi.zone.EAST_RONFAURE_S] = 78,
    [xi.zone.JUGNER_FOREST_S] = 79,
    [xi.zone.BATALLIA_DOWNS_S] = 80,
    [xi.zone.THE_ELDIEME_NECROPOLIS_S] = 81,
    [xi.zone.BASTOK_MARKETS_S] = 82,
    [xi.zone.NORTH_GUSTABERG_S] = 83,
    [xi.zone.GRAUBERG_S] = 84,
    [xi.zone.VUNKERL_INLET_S] = 85,
    [xi.zone.PASHHOW_MARSHLANDS_S] = 86,
    [xi.zone.ROLANBERRY_FIELDS_S] = 87,
    [xi.zone.CRAWLERS_NEST_S] = 88,
    [xi.zone.WINDURST_WATERS_S] = 89,
    [xi.zone.WEST_SARUTABARUTA_S] = 90,
    [xi.zone.FORT_KARUGO_NARUGO_S] = 91,
    [xi.zone.MERIPHATAUD_MOUNTAINS_S] = 92,
    [xi.zone.SAUROMUGUE_CHAMPAIGN_S] = 93,
    [xi.zone.GARLAIGE_CITADEL_S] = 94,
    [xi.zone.BEAUCEDINE_GLACIER_S] = 95,
    [xi.zone.CASTLE_ZVAHL_BAILEYS_S] = 96,
    [xi.zone.EASTERN_ADOULIN] = 97
}

return survival
