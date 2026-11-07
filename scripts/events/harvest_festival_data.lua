-----------------------------------
-- Harvest Festival NPCs and treats
-----------------------------------
-- Source: https://wiki.ffo.jp/html/11058.html
-- Source: https://wikiwiki.jp/ffxi/%E3%82%A4%E3%83%99%E3%83%B3%E3%83%88/%E3%83%8F%E3%83%AD%E3%82%A6%E3%82%A3%E3%83%B32005
-- Source: https://wikiwiki.jp/ffxi/%E3%82%A4%E3%83%99%E3%83%B3%E3%83%88/%E3%83%8F%E3%83%AD%E3%82%A6%E3%82%A3%E3%83%B32007
-- Models and routes are estimates.
-----------------------------------
local costumes =
{
    ghost    = 368,
    hound    = 365,
    orc      = { 612, 639 },
    quadav   = { 644, 671 },
    shadow   = { 531, 538 },
    skeleton = 564,
    yagudo   = { 580, 607 },
}

return
{
    treats =
    {
        [xi.item.ACORN_COOKIE]                 = 2005,
        [xi.item.APPLE_PIE]                    = 2005,
        [xi.item.APPLE_PIE_P1]                 = 2007,
        [xi.item.BAKED_APPLE]                  = 2005,
        [xi.item.BIJOU_GLACE]                  = 2007,
        [xi.item.BOWL_OF_SUTLAC]               = 2007,
        [xi.item.BOWL_OF_SUTLAC_P1]            = 2007,
        [xi.item.CHUNK_OF_BUBBLE_CHOCOLATE]    = 2005,
        [xi.item.CHUNK_OF_GOBLIN_CHOCOLATE]    = 2005,
        [xi.item.CHUNK_OF_HEART_CHOCOLATE]     = 2005,
        [xi.item.CHUNK_OF_HOBGOBLIN_CHOCOLATE] = 2005,
        [xi.item.CINNA_COOKIE]                 = 2005,
        [xi.item.COIN_COOKIE]                  = 2005,
        [xi.item.CONE_OF_SNOLL_GELATO]         = 2005,
        [xi.item.DRIED_DATE]                   = 2007,
        [xi.item.DRIED_DATE_P1]                = 2007,
        [xi.item.GARLIC_CRACKER]               = 2005,
        [xi.item.GARLIC_CRACKER_P1]            = 2005,
        [xi.item.GATEAU_AUX_FRAISES]           = 2007,
        [xi.item.GINGER_COOKIE]                = 2005,
        [xi.item.GOBLIN_PIE]                   = 2005,
        [xi.item.HOBGOBLIN_PIE]                = 2007,
        [xi.item.IRMIK_HELVASI]                = 2007,
        [xi.item.IRMIK_HELVASI_P1]             = 2007,
        [xi.item.KONIGSKUCHEN]                 = 2007,
        [xi.item.MARRON_GLACE]                 = 2007,
        [xi.item.MELON_PIE]                    = 2005,
        [xi.item.MELON_PIE_P1]                 = 2007,
        [xi.item.MIDWINTER_DREAM]              = 2007,
        [xi.item.OPO_OPO_TART]                 = 2007,
        [xi.item.ORANGE_KUCHEN]                = 2007,
        [xi.item.ORANGE_KUCHEN_P1]             = 2007,
        [xi.item.PAMAMA_TART]                  = 2005,
        [xi.item.PUMPKIN_PIE]                  = 2005,
        [xi.item.PUMPKIN_PIE_P1]               = 2007,
        [xi.item.RED_HOT_CRACKER]              = 2005,
        [xi.item.ROLANBERRY_PIE]               = 2005,
        [xi.item.ROLANBERRY_PIE_P1]            = 2007,
        [xi.item.SERVING_OF_BLACK_PUDDING]     = 2007,
        [xi.item.SERVING_OF_CRIMSON_JELLY]     = 2007,
        [xi.item.SERVING_OF_DUSKY_INDULGENCE]  = 2007,
        [xi.item.SERVING_OF_FLURRY_COURANTE]   = 2007,
        [xi.item.SERVING_OF_ICECAP_ROLANBERRY] = 2007,
        [xi.item.SERVING_OF_SNOWY_ROLANBERRY]  = 2007,
        [xi.item.SERVING_OF_SQUIRRELS_DELIGHT] = 2007,
        [xi.item.SERVING_OF_VERMILLION_JELLY]  = 2007,
        [xi.item.SPICY_CRACKER]                = 2005,
        [xi.item.SWEET_BAKED_APPLE]            = 2005,
        [xi.item.SWEET_RICE_CAKE]              = 2005,
        [xi.item.UBERKUCHEN]                   = 2007,
        [xi.item.WILD_COOKIE]                  = 2007,
        [xi.item.WIZARD_COOKIE]                = 2005,
    },

    [xi.zone.BASTOK_MARKETS] =
    {
        npcs =
        {
            ['Belizieg']            = { costume = costumes.orc, model = 531, goblinNation = xi.nation.SANDORIA },
            ['Carmelide']           = { costume = costumes.hound, model = 564, standard = true },
            ['Charging_Chocobo']    = { costume = costumes.skeleton, model = 564, standard = true },
            ['Ciqala']              = { costume = costumes.quadav, model = 531, standard = true, goblinNation = xi.nation.BASTOK, goblinYear = 2007 },
            ['Harmodios']           = { costume = costumes.shadow, model = 531 },
            ['Olwyn']               = { costume = costumes.ghost, model = 368 },
            ['Peritrage']           = { costume = costumes.yagudo, model = 531, goblinNation = xi.nation.WINDURST },
            ['Trick_Bones'] =
            {
                costume = costumes.ghost,
                model = 564,
                path =
                {
                    { x = -319.1778, y = -15.0012, z = -51.7979 },
                    { x = -310.5735, y = -12.0000, z = -48.9353 },
                },
            },
            ['Trick_Ghast'] =
            {
                costume = costumes.shadow,
                model = 564,
                path =
                {
                    { x = -308.9009, y = -12.0000, z = -68.0757 },
                    { x = -317.0030, y = -15.0013, z = -67.7697 },
                },
            },
            ['Trick_Ghost'] =
            {
                costume = costumes.hound,
                model = 368,
                path =
                {
                    { x = -242.083, y = -12.467, z = -40.182 },
                    { x = -245.333, y = -12.733, z = -52.849 },
                },
            },
            ['Trick_Phantom'] =
            {
                costume = costumes.quadav,
                model = 368,
                goblinNation = xi.nation.BASTOK,
                path =
                {
                    { x = -245.333, y = -1.333, z = 64.651 },
                    { x = -246.000, y = -1.200, z = 57.901 },
                },
            },
            ['Trick_Shade'] =
            {
                costume = costumes.shadow,
                model = 531,
                path =
                {
                    { x = -174.667, y = -5.000, z = 61.401 },
                    { x = -178.500, y = -5.000, z = 66.651 },
                },
            },
            ['Trick_Shadow'] =
            {
                costume = costumes.skeleton,
                model = 531,
                path =
                {
                    { x = -106.600, y = -5.000, z = -81.149 },
                    { x = -105.833, y = -5.000, z = -87.516 },
                },
            },
            ['Trick_Skeleton'] =
            {
                costume = costumes.yagudo,
                model = 564,
                goblinNation = xi.nation.WINDURST,
                goblinYear = 2007,
                path =
                {
                    { x = -91.167, y = -5.000, z = -108.182 },
                    { x = -90.625, y = -4.550, z = -97.224 },
                },
            },
            ['Trick_Specter'] =
            {
                costume = costumes.ghost,
                model = 531,
                path =
                {
                    { x = -34.000, y = -7.800, z = -73.266 },
                    { x = -39.167, y = -6.733, z = -76.432 },
                },
            },
            ['Trick_Spirit'] =
            {
                costume = costumes.orc,
                model = 368,
                goblinNation = xi.nation.SANDORIA,
                path =
                {
                    { x = -279.000, y = -16.000, z = -139.474 },
                    { x = -285.083, y = -16.000, z = -139.016 },
                },
            },
            ['Trick_Wight'] =
            {
                costume = costumes.skeleton,
                model = 564,
                path =
                {
                    { x = -113.000, y = -4.850, z = -113.224 },
                    { x = -101.875, y = -4.600, z = -114.849 },
                },
            },
            ['Visala']              = { costume = costumes.hound, model = 564, standard = true },
        },
    },

    [xi.zone.BASTOK_MINES] =
    {
        npcs =
        {
            ['Aulavia']             = { costume = costumes.ghost, model = 368 },
            ['Deegis']              = { costume = costumes.orc, model = 531, goblinNation = xi.nation.SANDORIA },
            ['Emaliveulaux']        = { costume = costumes.skeleton, model = 564 },
            ['Faustin']             = { costume = costumes.hound, model = 564 },
            ['Galdeo']              = { costume = costumes.skeleton, model = 564 },
            ['Griselda']            = { costume = costumes.ghost, model = 368, standard = true },
            ['Maymunah']            = { costume = costumes.quadav, model = 531, goblinNation = xi.nation.BASTOK, standard = true },
            ['Mille']               = { costume = costumes.quadav, model = 531, goblinNation = xi.nation.BASTOK },
            ['Neigepance']          = { costume = costumes.shadow, model = 531 },
            ['Odoba']               = { costume = costumes.yagudo, model = 531 },
            ['Proud_Beard']         = { costume = costumes.shadow, model = 531 },
            ['Tibelda']             = { costume = costumes.yagudo, model = 531, goblinNation = xi.nation.WINDURST },
        },
    },

    [xi.zone.NORTHERN_SAN_DORIA] =
    {
        npcs =
        {
            ['Antonian']            = { costume = costumes.hound, model = 564, goblinNation = xi.nation.SANDORIA },
            ['Attarena']            = { costume = costumes.orc, model = 531, goblinNation = xi.nation.SANDORIA, goblinYear = 2007 },
            ['Justi']               = { costume = costumes.yagudo, model = 531, goblinNation = xi.nation.WINDURST, goblinYear = 2007 },
            ['Palguevion']          = { costume = costumes.shadow, model = 531 },
            ['Pirvidiauce']         = { costume = costumes.skeleton, model = 564 },
            ['Tavourine']           = { costume = costumes.quadav, model = 531, goblinNation = xi.nation.BASTOK, goblinYear = 2007 },
            ['Trick_Bones'] =
            {
                costume = costumes.quadav,
                model = 564,
                goblinNation = xi.nation.BASTOK,
                path =
                {
                    { x = 6.963, y = 0.400, z = 30.462 },
                    { x = 4.630, y = -0.033, z = 19.921 },
                },
            },
            ['Trick_Ghast'] =
            {
                costume = costumes.yagudo,
                model = 564,
                goblinNation = xi.nation.WINDURST,
                goblinYear = 2007,
                path =
                {
                    { x = -0.0208, y = 0.0000, z = -29.6482 },
                    { x = 0.0795, y = 0.0000, z = -7.9821 },
                },
            },
            ['Trick_Ghost'] =
            {
                costume = costumes.skeleton,
                model = 368,
                path =
                {
                    { x = 135.3171, y = 0.0000, z = 130.4728 },
                    { x = 126.1359, y = 0.0000, z = 121.3776 },
                },
            },
            ['Trick_Phantom'] =
            {
                costume = costumes.shadow,
                model = 368,
                path =
                {
                    { x = 142.6511, y = 0.0000, z = 130.3664 },
                    { x = 132.4361, y = 0.0000, z = 120.2951 },
                },
            },
            ['Trick_Shade'] =
            {
                costume = costumes.yagudo,
                model = 531,
                goblinNation = xi.nation.WINDURST,
                goblinYear = 2007,
                path =
                {
                    { x = -139.8232, y = -5.1992, z = 48.3568 },
                    { x = -130.8798, y = -2.1991, z = 56.6121 },
                },
            },
            ['Trick_Shadow'] =
            {
                costume = costumes.orc,
                model = 531,
                path =
                {
                    { x = -222.3146, y = 8.0000, z = 65.1859 },
                    { x = -234.1228, y = 8.0000, z = 53.8308 },
                },
            },
            ['Trick_Skeleton'] =
            {
                costume = costumes.hound,
                model = 564,
                path =
                {
                    { x = -146.3264, y = 12.0000, z = 217.4898 },
                    { x = -146.5434, y = 12.0000, z = 199.7671 },
                },
            },
            ['Trick_Specter'] =
            {
                costume = costumes.quadav,
                model = 531,
                path =
                {
                    { x = -146.8793, y = 12.0000, z = 148.5256 },
                    { x = -147.1096, y = 12.0000, z = 178.8684 },
                },
            },
            ['Trick_Spirit'] =
            {
                costume = costumes.ghost,
                model = 368,
                path =
                {
                    { x = 8.296, y = 0.400, z = 48.337 },
                    { x = 4.213, y = 0.200, z = 55.921 },
                },
            },
            ['Trick_Wight'] =
            {
                costume = costumes.orc,
                model = 564,
                goblinNation = xi.nation.SANDORIA,
                path =
                {
                    { x = 112.0989, y = -0.1990, z = -7.8260 },
                    { x = 121.7189, y = -0.1990, z = 0.6969 },
                },
            },
            ['Vichuel']             = { costume = costumes.ghost, model = 368 },
        },
    },

    [xi.zone.SOUTHERN_SAN_DORIA] =
    {
        npcs =
        {
            ['Apairemant']          = { costume = costumes.shadow, model = 531 },
            ['Aveline']             = { costume = costumes.orc, model = 531, goblinNation = xi.nation.SANDORIA },
            ['Benaige']             = { costume = costumes.hound, model = 564 },
            ['Corua']               = { costume = costumes.skeleton, model = 564, standard = true },
            ['Kueh_Igunahmori']     = { costume = costumes.ghost, model = 368 },
            ['Lotte']               = { costume = costumes.quadav, model = 531, goblinNation = xi.nation.BASTOK },
            ['Lusiane']             = { costume = costumes.yagudo, model = 531, goblinNation = xi.nation.WINDURST },
            ['Machielle']           = { costume = costumes.yagudo, model = 531, goblinNation = xi.nation.WINDURST },
            ['Malecharisant']       = { costume = costumes.shadow, model = 531 },
            ['Ostalie']             = { costume = costumes.skeleton, model = 564 },
            ['Paunelie']            = { costume = costumes.hound, model = 564 },
            ['Phamelise']           = { costume = costumes.ghost, model = 368 },
            ['Pourette']            = { costume = costumes.orc, model = 531 },
        },
    },

    [xi.zone.WINDURST_WATERS] =
    {
        npcs =
        {
            ['Ahyeekih']            = { costume = costumes.shadow, model = 531 },
            ['Ensasa']              = { costume = costumes.skeleton, model = 564 },
            ['Hilkomu-Makimu']      = { costume = costumes.yagudo, model = 531, goblinNation = xi.nation.WINDURST },
            ['Maqu_Molpih']         = { costume = costumes.orc, model = 531, goblinNation = xi.nation.SANDORIA },
            ['Ness_Rugetomal']      = { costume = costumes.hound, model = 564 },
            ['Orez-Ebrez']          = { costume = costumes.orc, model = 531 },
            ['Shohrun-Tuhrun']      = { costume = costumes.quadav, model = 531, goblinNation = xi.nation.BASTOK },
            ['Trick_Bones'] =
            {
                costume = costumes.orc,
                model = 564,
                goblinNation = xi.nation.SANDORIA,
                path =
                {
                    { x = -40.000, y = -5.200, z = 126.350 },
                    { x = -40.417, y = -5.200, z = 118.683 },
                },
            },
            ['Trick_Ghast'] =
            {
                costume = costumes.quadav,
                model = 564,
                goblinNation = xi.nation.BASTOK,
                path =
                {
                    { x = -29.125, y = -2.600, z = -109.775 },
                    { x = -35.834, y = -2.600, z = -101.817 },
                },
            },
            ['Trick_Ghost'] =
            {
                costume = costumes.yagudo,
                model = 368,
                goblinNation = xi.nation.WINDURST,
                goblinYear = 2007,
                path =
                {
                    { x = -95.750, y = -2.367, z = 50.100 },
                    { x = -87.500, y = -2.200, z = 46.600 },
                },
            },
            ['Trick_Phantom'] =
            {
                costume = costumes.ghost,
                model = 368,
                path =
                {
                    { x = -17.500, y = -4.050, z = 77.725 },
                    { x = -22.400, y = -5.520, z = 90.900 },
                },
            },
            ['Trick_Shade'] =
            {
                costume = costumes.quadav,
                model = 531,
                goblinNation = xi.nation.BASTOK,
                path =
                {
                    { x = -40.500, y = -4.767, z = 81.100 },
                    { x = -40.875, y = -5.200, z = 91.225 },
                },
            },
            ['Trick_Shadow'] =
            {
                costume = costumes.hound,
                model = 531,
                path =
                {
                    { x = 148.500, y = -2.700, z = 133.100 },
                    { x = 156.500, y = -3.067, z = 129.433 },
                },
            },
            ['Trick_Skeleton'] =
            {
                costume = costumes.shadow,
                model = 564,
                path =
                {
                    { x = -110.500, y = -2.200, z = 45.933 },
                    { x = -104.375, y = -2.300, z = 37.600 },
                },
            },
            ['Trick_Specter'] =
            {
                costume = costumes.orc,
                model = 531,
                goblinNation = xi.nation.SANDORIA,
                path =
                {
                    { x = 109.916, y = -2.767, z = 83.600 },
                    { x = 108.000, y = -2.700, z = 75.850 },
                },
            },
            ['Trick_Spirit'] =
            {
                costume = costumes.skeleton,
                model = 368,
                path =
                {
                    { x = -40.125, y = -3.600, z = 45.100 },
                    { x = -39.875, y = -3.600, z = 38.100 },
                },
            },
            ['Trick_Wight'] =
            {
                costume = costumes.hound,
                model = 564,
                path =
                {
                    { x = 18.583, y = -2.200, z = 69.017 },
                    { x = 18.625, y = -2.400, z = 62.850 },
                },
            },
            ['Upih_Khachla']        = { costume = costumes.ghost, model = 368 },
        },
    },

    [xi.zone.WINDURST_WOODS] =
    {
        npcs =
        {
            ['Bin_Stejihna']        = { costume = costumes.skeleton, model = 564, standard = true },
            ['Kuzah_Hpirohpon']     = { costume = costumes.yagudo, model = 531 },
            ['Meriri']              = { costume = costumes.quadav, model = 531, goblinNation = xi.nation.BASTOK },
            ['Millerovieunet']      = { costume = costumes.orc, model = 531, goblinNation = xi.nation.SANDORIA },
            ['Mono_Nchaa']          = { costume = costumes.hound, model = 564 },
            ['Nhobi_Zalkia']        = { costume = costumes.shadow, model = 531 },
            ['Nya_Labiccio']        = { costume = costumes.yagudo, model = 531, goblinNation = xi.nation.WINDURST },
            ['Quesse']              = { costume = costumes.shadow, model = 531 },
            ['Retto-Marutto']       = { costume = costumes.ghost, model = 368 },
            ['Shih_Tayuun']         = { costume = costumes.skeleton, model = 564 },
            ['Taraihi-Perunhi']     = { costume = costumes.ghost, model = 368 },
            ['Wije_Tiren']          = { costume = costumes.quadav, model = 531, goblinNation = xi.nation.BASTOK },
        },
    },
}
