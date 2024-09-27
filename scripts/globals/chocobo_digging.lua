-----------------------------------
-- Chocobo Digging
-- http://ffxiclopedia.wikia.com/wiki/Chocobo_Digging
-- https://www.bg-wiki.com/bg/Category:Chocobo_Digging
-----------------------------------
require('scripts/globals/roe')
require('scripts/globals/utils')
require('scripts/missions/amk/helpers')
-----------------------------------
xi = xi or {}
xi.chocoboDig = xi.chocoboDig or {}

-- This contais all digging zones with the ones without loot tables defined commented out.
local diggingZoneList =
set{
    xi.zone.CARPENTERS_LANDING,
    xi.zone.BIBIKI_BAY,
    -- xi.zone.ULEGUERAND_RANGE,
    -- xi.zone.ATTOHWA_CHASM,
    -- xi.zone.LUFAISE_MEADOWS,
    -- xi.zone.MISAREAUX_COAST,
    xi.zone.WAJAOM_WOODLANDS,
    xi.zone.BHAFLAU_THICKETS,
    -- xi.zone.CAEDARVA_MIRE,
    -- xi.zone.EAST_RONFAURE_S,
    -- xi.zone.JUGNER_FOREST_S,
    -- xi.zone.VUNKERL_INLET_S,
    -- xi.zone.BATALLIA_DOWNS_S,
    -- xi.zone.NORTH_GUSTABERG_S,
    -- xi.zone.GRAUBERG_S,
    -- xi.zone.PASHHOW_MARSHLANDS_S,
    -- xi.zone.ROLANBERRY_FIELDS_S,
    -- xi.zone.WEST_SARUTABARUTA_S,
    -- xi.zone.FORT_KARUGO_NARUGO_S,
    -- xi.zone.MERIPHATAUD_MOUNTAINS_S,
    -- xi.zone.SAUROMUGUE_CHAMPAIGN_S,
    xi.zone.WEST_RONFAURE,
    xi.zone.EAST_RONFAURE,
    xi.zone.LA_THEINE_PLATEAU,
    xi.zone.VALKURM_DUNES,
    xi.zone.JUGNER_FOREST,
    xi.zone.BATALLIA_DOWNS,
    xi.zone.NORTH_GUSTABERG,
    xi.zone.SOUTH_GUSTABERG,
    xi.zone.KONSCHTAT_HIGHLANDS,
    xi.zone.PASHHOW_MARSHLANDS,
    xi.zone.ROLANBERRY_FIELDS,
    -- xi.zone.BEAUCEDINE_GLACIER,
    -- xi.zone.XARCABARD,
    -- xi.zone.CAPE_TERIGGAN,
    xi.zone.EASTERN_ALTEPA_DESERT,
    xi.zone.WEST_SARUTABARUTA,
    xi.zone.EAST_SARUTABARUTA,
    xi.zone.TAHRONGI_CANYON,
    xi.zone.BUBURIMU_PENINSULA,
    xi.zone.MERIPHATAUD_MOUNTAINS,
    xi.zone.SAUROMUGUE_CHAMPAIGN,
    xi.zone.THE_SANCTUARY_OF_ZITAH,
    xi.zone.YUHTUNGA_JUNGLE,
    xi.zone.YHOATOR_JUNGLE,
    xi.zone.WESTERN_ALTEPA_DESERT,
    -- xi.zone.QUFIM_ISLAND,
    -- xi.zone.BEHEMOTHS_DOMINION,
    -- xi.zone.VALLEY_OF_SORROWS,
    -- xi.zone.BEAUCEDINE_GLACIER_S,
    -- xi.zone.XARCABARD_S,
    -- xi.zone.YAHSE_HUNTING_GROUNDS,
    -- xi.zone.CEIZAK_BATTLEGROUNDS,
    -- xi.zone.FORET_DE_HENNETIEL,
    -- xi.zone.YORCIA_WEALD,
    -- xi.zone.MORIMAR_BASALT_FIELDS,
    -- xi.zone.MARJAMI_RAVINE,
    -- xi.zone.KAMIHR_DRIFTS,
}

-- local crystalMap =
-- {
--     -- Single weather by elemental order.
--     [xi.weather.HOT_SPELL    ] = xi.item.FIRE_CRYSTAL,
--     [xi.weather.SNOW         ] = xi.item.ICE_CRYSTAL,
--     [xi.weather.WIND         ] = xi.item.WIND_CRYSTAL,
--     [xi.weather.DUST_STORM   ] = xi.item.EARTH_CRYSTAL,
--     [xi.weather.THUNDER      ] = xi.item.LIGHTNING_CRYSTAL,
--     [xi.weather.RAIN         ] = xi.item.WATER_CRYSTAL,
--     [xi.weather.AURORAS      ] = xi.item.LIGHT_CRYSTAL,
--     [xi.weather.GLOOM        ] = xi.item.DARK_CRYSTAL,

--     -- Double weather by elemental order.
--     [xi.weather.HEAT_WAVE    ] = xi.item.FIRE_CLUSTER,
--     [xi.weather.BLIZZARDS    ] = xi.item.ICE_CLUSTER,
--     [xi.weather.GALES        ] = xi.item.WIND_CLUSTER,
--     [xi.weather.SAND_STORM   ] = xi.item.EARTH_CLUSTER,
--     [xi.weather.THUNDERSTORMS] = xi.item.LIGHTNING_CLUSTER,
--     [xi.weather.SQUALL       ] = xi.item.WATER_CLUSTER,
--     [xi.weather.STELLAR_GLARE] = xi.item.LIGHT_CLUSTER,
--     [xi.weather.DARKNESS     ] = xi.item.DARK_CLUSTER,
-- }

-- local oreMap =
-- {
--     [xi.day.FIRESDAY    ] = xi.item.CHUNK_OF_FIRE_ORE,
--     [xi.day.ICEDAY      ] = xi.item.CHUNK_OF_ICE_ORE,
--     [xi.day.WINDSDAY    ] = xi.item.CHUNK_OF_WIND_ORE,
--     [xi.day.EARTHSDAY   ] = xi.item.CHUNK_OF_EARTH_ORE,
--     [xi.day.LIGHTNINGDAY] = xi.item.CHUNK_OF_LIGHTNING_ORE,
--     [xi.day.WATERSDAY   ] = xi.item.CHUNK_OF_WATER_ORE,
--     [xi.day.LIGHTSDAY   ] = xi.item.CHUNK_OF_LIGHT_ORE,
--     [xi.day.DARKSDAY    ] = xi.item.CHUNK_OF_DARK_ORE,
-- }

-----------------------------------
-- Table for common items without special conditions. [Zone ID] = { itemId, weight, dig requirement }
-- Data from BG wiki: https://www.bg-wiki.com/ffxi/Category:Chocobo_Digging
-----------------------------------
local diggingLayer =
{
    TREASURE = 1, -- This layer takes precedence over all others AND no other layer will trigger if we manage to dig something from it.
    REGULAR  = 2, -- Regular layers. Crystals from weather and ores are applied here.
    BURROW   = 3, -- Special "Raised chocobo only" layer. Requires the mounted chocobo to have a concrete skill. It's an independent AND additional item dig.
    BORE     = 4, -- Special "Raised chocobo only" layer. Requires the mounted chocobo to have a concrete skill. It's an independent AND additional item dig.
}

local digInfo =
{
    [xi.zone.CARPENTERS_LANDING] = -- 2
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.LITTLE_WORM,        100, xi.craftRank.AMATEUR },
            [2] = { xi.item.ACORN,               50, xi.craftRank.AMATEUR },
            [3] = { xi.item.ARROWWOOD_LOG,      100, xi.craftRank.AMATEUR },
            [4] = { xi.item.WILLOW_LOG,          50, xi.craftRank.AMATEUR },
            [5] = { xi.item.MAPLE_LOG,           50, xi.craftRank.AMATEUR },
            [6] = { xi.item.HOLLY_LOG,           50, xi.craftRank.AMATEUR },
            [7] = { xi.item.SPRIG_OF_MISTLETOE,  10, xi.craftRank.AMATEUR },
            [8] = { xi.item.SCREAM_FUNGUS,       10, xi.craftRank.AMATEUR },
            [9] = { xi.item.KING_TRUFFLE,        10, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BORE] =
        {
            [1] = { xi.item.ARROWWOOD_LOG,           100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                  50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [4] = { xi.item.ELM_LOG,                  10, xi.craftRank.NOVICE     },
            [5] = { xi.item.MAHOGANY_LOG,             10, xi.craftRank.APPRENTICE },
            [6] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.EBONY_LOG,                10, xi.craftRank.CRAFTSMAN  },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,  10, xi.craftRank.ARTISAN    },
            [9] = { xi.item.LACQUER_TREE_LOG,         10, xi.craftRank.ADEPT      },
        },
    },

    [xi.zone.BIBIKI_BAY] = -- 4
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.BLACK_CHOCOBO_FEATHER,    100, xi.craftRank.AMATEUR },
            { xi.item.SEASHELL,                 100, xi.craftRank.AMATEUR },
            { xi.item.BIRD_FEATHER,              50, xi.craftRank.AMATEUR },
            { xi.item.BONE_CHIP,                 50, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_FISH_SCALES,    50, xi.craftRank.AMATEUR },
            { xi.item.GIANT_FEMUR,               50, xi.craftRank.AMATEUR },
            { xi.item.LUGWORM,                   50, xi.craftRank.AMATEUR },
            { xi.item.PHOENIX_FEATHER,           50, xi.craftRank.AMATEUR },
            { xi.item.CLUMP_OF_RED_MOKO_GRASS,   50, xi.craftRank.AMATEUR },
            { xi.item.SHALL_SHELL,               50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_TIN_ORE,          50, xi.craftRank.AMATEUR },
            { xi.item.TITANICTUS_SHELL,          50, xi.craftRank.AMATEUR },
            { xi.item.TURTLE_SHELL,              50, xi.craftRank.AMATEUR },
            { xi.item.DEMON_HORN,                10, xi.craftRank.AMATEUR },
            { xi.item.DEMON_SKULL,               10, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_DRAGON_SCALES,  10, xi.craftRank.AMATEUR },
            { xi.item.GIANT_BIRD_PLUME,          10, xi.craftRank.AMATEUR },
            { xi.item.HIGH_QUALITY_PUGIL_SCALE,  10, xi.craftRank.AMATEUR },
            { xi.item.SHELL_BUG,                 10, xi.craftRank.AMATEUR },
            { xi.item.SPIDER_WEB,                10, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_WYVERN_SCALES,  10, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_BIRTH,              5, xi.craftRank.AMATEUR },
            { xi.item.CORAL_FRAGMENT,             5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,       5, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_PLATINUM_ORE,      5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,             100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },
    [xi.zone.WAJAOM_WOODLANDS] = -- 51
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.FLINT_STONE,             240, xi.craftRank.AMATEUR },
            { xi.item.ARROWWOOD_LOG,           150, xi.craftRank.AMATEUR },
            { xi.item.CLUMP_OF_MOKO_GRASS,     100, xi.craftRank.AMATEUR },
            { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.AMATEUR },
            { xi.item.EBONY_LOG,                50, xi.craftRank.AMATEUR },
            { xi.item.ELM_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.OAK_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                   50, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_PINE_NUTS,     50, xi.craftRank.AMATEUR },
            { xi.item.YEW_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ADAMAN_ORE,      10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ALUMINUM_ORE,    10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_DARKSTEEL_ORE,   10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_GOLD_ORE,        10, xi.craftRank.AMATEUR },
            { xi.item.MAHOGANY_LOG,             10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ORICHALCUM_ORE,  10, xi.craftRank.AMATEUR },
            { xi.item.PEPHEDRO_HIVE_CHIP,       10, xi.craftRank.AMATEUR },
            { xi.item.SPIDER_WEB,               10, xi.craftRank.AMATEUR },
            { xi.item.ALEXANDRITE,               5, xi.craftRank.AMATEUR },
            { xi.item.PIECE_OF_ANCIENT_LUMBER,   5, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_KAOLIN,           5, xi.craftRank.AMATEUR },
            { xi.item.LACQUER_TREE_LOG,          5, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_PLATINUM_ORE,     5, xi.craftRank.AMATEUR },
            { xi.item.ROSEWOOD_LOG,              5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,            100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.BHAFLAU_THICKETS] = -- 52
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.FLINT_STONE,             240, xi.craftRank.AMATEUR },
            { xi.item.ARROWWOOD_LOG,           150, xi.craftRank.AMATEUR },
            { xi.item.COLIBRI_FEATHER,          50, xi.craftRank.AMATEUR },
            { xi.item.PINCH_OF_DRIED_MARJORAM,  50, xi.craftRank.AMATEUR },
            { xi.item.CLUMP_OF_MOKO_GRASS,      50, xi.craftRank.AMATEUR },
            { xi.item.OAK_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                   50, xi.craftRank.AMATEUR },
            { xi.item.PETRIFIED_LOG,            50, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_PINE_NUTS,     50, xi.craftRank.AMATEUR },
            { xi.item.YEW_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ALUMINUM_ORE,    10, xi.craftRank.AMATEUR },
            { xi.item.BLACK_CHOCOBO_FEATHER,    10, xi.craftRank.AMATEUR },
            { xi.item.EBONY_LOG,                10, xi.craftRank.AMATEUR },
            { xi.item.ELM_LOG,                  10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_GOLD_ORE,        10, xi.craftRank.AMATEUR },
            { xi.item.MAHOGANY_LOG,             10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ORICHALCUM_ORE,  10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_PLATINUM_ORE,    10, xi.craftRank.AMATEUR },
            { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.AMATEUR },
            { xi.item.ALEXANDRITE,               5, xi.craftRank.AMATEUR },
            { xi.item.PIECE_OF_ANCIENT_LUMBER,   5, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_DARKSTEEL_ORE,    5, xi.craftRank.AMATEUR },
            { xi.item.LACQUER_TREE_LOG,          5, xi.craftRank.AMATEUR },
            { xi.item.LESSER_CHIGOE,             5, xi.craftRank.AMATEUR },
            { xi.item.PEPHEDRO_HIVE_CHIP,        5, xi.craftRank.AMATEUR },
            { xi.item.SPIDER_WEB,                5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,            100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.WEST_RONFAURE] = -- 100
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR },
            { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR },
            { xi.item.GINGER_ROOT,             50, xi.craftRank.AMATEUR },
            { xi.item.ARROWWOOD_LOG,           50, xi.craftRank.AMATEUR },
            { xi.item.LITTLE_WORM,             50, xi.craftRank.AMATEUR },
            { xi.item.ASH_LOG,                 50, xi.craftRank.AMATEUR },
            { xi.item.ACORN,                   50, xi.craftRank.AMATEUR },
            { xi.item.CHOCOBO_FEATHER,         50, xi.craftRank.AMATEUR },
            { xi.item.CLUMP_OF_MOKO_GRASS,     50, xi.craftRank.AMATEUR },
            { xi.item.MAPLE_LOG,               50, xi.craftRank.AMATEUR },
            { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.AMATEUR },
            { xi.item.RONFAURE_CHESTNUT,       10, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_VEGETABLE_SEEDS,  10, xi.craftRank.AMATEUR },
            { xi.item.CHESTNUT_LOG,            10, xi.craftRank.AMATEUR },
            { xi.item.SPRIG_OF_MISTLETOE,      10, xi.craftRank.AMATEUR },
            { xi.item.KING_TRUFFLE,            10, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,     5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,           100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.EAST_RONFAURE] = -- 101
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR },
            { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR },
            { xi.item.GINGER_ROOT,             50, xi.craftRank.AMATEUR },
            { xi.item.ARROWWOOD_LOG,           50, xi.craftRank.AMATEUR },
            { xi.item.LITTLE_WORM,             50, xi.craftRank.AMATEUR },
            { xi.item.ASH_LOG,                 50, xi.craftRank.AMATEUR },
            { xi.item.ACORN,                   50, xi.craftRank.AMATEUR },
            { xi.item.CHOCOBO_FEATHER,         50, xi.craftRank.AMATEUR },
            { xi.item.CLUMP_OF_MOKO_GRASS,     50, xi.craftRank.AMATEUR },
            { xi.item.MAPLE_LOG,               50, xi.craftRank.AMATEUR },
            { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.AMATEUR },
            { xi.item.RONFAURE_CHESTNUT,       10, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_VEGETABLE_SEEDS,  10, xi.craftRank.AMATEUR },
            { xi.item.CHESTNUT_LOG,            10, xi.craftRank.AMATEUR },
            { xi.item.SPRIG_OF_MISTLETOE,      10, xi.craftRank.AMATEUR },
            { xi.item.KING_TRUFFLE,            10, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,     5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,           100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.LA_THEINE_PLATEAU] = -- 102
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.BUNCH_OF_GYSAHL_GREENS,  150, xi.craftRank.AMATEUR },
            { xi.item.PIECE_OF_YELLOW_YINSENG, 150, xi.craftRank.AMATEUR },
            { xi.item.CHAMOMILE,                50, xi.craftRank.AMATEUR },
            { xi.item.ARROWWOOD_LOG,            50, xi.craftRank.AMATEUR },
            { xi.item.CHOCOBO_FEATHER,          50, xi.craftRank.AMATEUR },
            { xi.item.GINGER_ROOT,              50, xi.craftRank.AMATEUR },
            { xi.item.LITTLE_WORM,              50, xi.craftRank.AMATEUR },
            { xi.item.HEAD_OF_NAPA,             50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                   50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_TIN_ORE,         50, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_TREE_CUTTINGS,     50, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.AMATEUR },
            { xi.item.YEW_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ZINC_ORE,        50, xi.craftRank.AMATEUR },
            { xi.item.CHESTNUT_LOG,             10, xi.craftRank.AMATEUR },
            { xi.item.PINCH_OF_DRIED_MARJORAM,  10, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_CACTUS_STEMS,      10, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_GLORY,             5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,      5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,            100, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_FIRE_ORE,        10, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.VALKURM_DUNES] = -- 103
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.SEASHELL,                 150, xi.craftRank.AMATEUR },
            { xi.item.BLACK_CHOCOBO_FEATHER,    100, xi.craftRank.AMATEUR },
            { xi.item.BONE_CHIP,                100, xi.craftRank.AMATEUR },
            { xi.item.PHOENIX_FEATHER,          100, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_FISH_SCALES,    50, xi.craftRank.AMATEUR },
            { xi.item.GIANT_FEMUR,               50, xi.craftRank.AMATEUR },
            { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, xi.craftRank.AMATEUR },
            { xi.item.LIZARD_MOLT,               50, xi.craftRank.AMATEUR },
            { xi.item.LUGWORM,                   50, xi.craftRank.AMATEUR },
            { xi.item.CLUMP_OF_RED_MOKO_GRASS,   50, xi.craftRank.AMATEUR },
            { xi.item.SHALL_SHELL,               50, xi.craftRank.AMATEUR },
            { xi.item.SHELL_BUG,                 50, xi.craftRank.AMATEUR },
            { xi.item.SPIDER_WEB,                50, xi.craftRank.AMATEUR },
            { xi.item.TITANICTUS_SHELL,          50, xi.craftRank.AMATEUR },
            { xi.item.TURTLE_SHELL,              50, xi.craftRank.AMATEUR },
            { xi.item.DEMON_HORN,                10, xi.craftRank.AMATEUR },
            { xi.item.DEMON_SKULL,               10, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_DRAGON_SCALES,  10, xi.craftRank.AMATEUR },
            { xi.item.GIANT_BIRD_PLUME,          10, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_WYVERN_SCALES,  10, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_DECAY,              5, xi.craftRank.AMATEUR },
            { xi.item.ORDELLE_BRONZEPIECE,        5, xi.craftRank.AMATEUR },
            { xi.item.TUKUKU_WHITESHELL,          5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,             100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.JUGNER_FOREST] = -- 104
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.ARROWWOOD_LOG,           150, xi.craftRank.AMATEUR },
            { xi.item.ACORN,                    50, xi.craftRank.AMATEUR },
            { xi.item.HOLLY_LOG,                50, xi.craftRank.AMATEUR },
            { xi.item.LITTLE_WORM,              50, xi.craftRank.AMATEUR },
            { xi.item.MAPLE_LOG,                50, xi.craftRank.AMATEUR },
            { xi.item.OAK_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.WILLOW_LOG,               50, xi.craftRank.AMATEUR },
            { xi.item.YEW_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.ELM_LOG,                  10, xi.craftRank.AMATEUR },
            { xi.item.LACQUER_TREE_LOG,         10, xi.craftRank.AMATEUR },
            { xi.item.MAHOGANY_LOG,             10, xi.craftRank.AMATEUR },
            { xi.item.SPRIG_OF_MISTLETOE,       10, xi.craftRank.AMATEUR },
            { xi.item.ROSEWOOD_LOG,              5, xi.craftRank.AMATEUR },
            { xi.item.PIECE_OF_ANCIENT_LUMBER,   5, xi.craftRank.AMATEUR },
            { xi.item.SCREAM_FUNGUS,             5, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_BIRTH,             5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,      5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,            100, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_FIRE_ORE,        10, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.BATALLIA_DOWNS] = -- 105
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.PIECE_OF_YELLOW_YINSENG, 150, xi.craftRank.AMATEUR },
            { xi.item.BEASTCOIN,               100, xi.craftRank.AMATEUR },
            { xi.item.SILVER_BEASTCOIN,        100, xi.craftRank.AMATEUR },
            { xi.item.BIRD_FEATHER,             50, xi.craftRank.AMATEUR },
            { xi.item.BONE_CHIP,                50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_COPPER_ORE,      50, xi.craftRank.AMATEUR },
            { xi.item.FLINT_STONE,              50, xi.craftRank.AMATEUR },
            { xi.item.GOLD_BEASTCOIN,           50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_IRON_ORE,        50, xi.craftRank.AMATEUR },
            { xi.item.MYTHRIL_BEASTCOIN,        50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                   50, xi.craftRank.AMATEUR },
            { xi.item.RED_JAR,                  50, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.AMATEUR },
            { xi.item.PLATINUM_BEASTCOIN,       10, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.AMATEUR },
            { xi.item.BLACK_CHOCOBO_FEATHER,     5, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_ADVANCEMENT,       5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,      5, xi.craftRank.AMATEUR },
            { xi.item.REISHI_MUSHROOM,           5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,            100, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_FIRE_ORE,        10, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.NORTH_GUSTABERG] = -- 106
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR },
            { xi.item.BIRD_FEATHER,            50, xi.craftRank.AMATEUR },
            { xi.item.BONE_CHIP,               50, xi.craftRank.AMATEUR },
            { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_FISH_SCALES,  50, xi.craftRank.AMATEUR },
            { xi.item.GINGER_ROOT,             50, xi.craftRank.AMATEUR },
            { xi.item.INSECT_WING,             50, xi.craftRank.AMATEUR },
            { xi.item.LITTLE_WORM,             50, xi.craftRank.AMATEUR },
            { xi.item.LIZARD_MOLT,             50, xi.craftRank.AMATEUR },
            { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                  50, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_CACTUS_STEMS,     10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_DARKSTEEL_ORE,  10, xi.craftRank.AMATEUR },
            { xi.item.MYTHRIL_BEASTCOIN,       10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_MYTHRIL_ORE,    10, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,     5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,           100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.SOUTH_GUSTABERG] = -- 107
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR },
            { xi.item.BIRD_FEATHER,            50, xi.craftRank.AMATEUR },
            { xi.item.BONE_CHIP,               50, xi.craftRank.AMATEUR },
            { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR },
            { xi.item.GINGER_ROOT,             50, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_GRAIN_SEEDS,      50, xi.craftRank.AMATEUR },
            { xi.item.INSECT_WING,             50, xi.craftRank.AMATEUR },
            { xi.item.LITTLE_WORM,             50, xi.craftRank.AMATEUR },
            { xi.item.LIZARD_MOLT,             50, xi.craftRank.AMATEUR },
            { xi.item.MYTHRIL_BEASTCOIN,       50, xi.craftRank.AMATEUR },
            { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                  50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ROCK_SALT,      50, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_DECAY,            5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,     5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,           100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.KONSCHTAT_HIGHLANDS] = -- 108
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.BLACK_CHOCOBO_FEATHER,   100, xi.craftRank.AMATEUR },
            { xi.item.PHOENIX_FEATHER,         100, xi.craftRank.AMATEUR },
            { xi.item.BONE_CHIP,                50, xi.craftRank.AMATEUR },
            { xi.item.ELM_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_FISH_SCALES,   50, xi.craftRank.AMATEUR },
            { xi.item.FLINT_STONE,              50, xi.craftRank.AMATEUR },
            { xi.item.LIZARD_MOLT,              50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                   50, xi.craftRank.AMATEUR },
            { xi.item.CLUMP_OF_RED_MOKO_GRASS,  50, xi.craftRank.AMATEUR },
            { xi.item.SPIDER_WEB,               50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ZINC_ORE,        50, xi.craftRank.AMATEUR },
            { xi.item.BIRD_FEATHER,             10, xi.craftRank.AMATEUR },
            { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_BIRTH,             5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,      5, xi.craftRank.AMATEUR },
            { xi.item.MYTHRIL_BEASTCOIN,         5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,            100, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_FIRE_ORE,        10, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.PASHHOW_MARSHLANDS] = -- 109
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.PIECE_OF_YELLOW_YINSENG, 150, xi.craftRank.AMATEUR },
            { xi.item.INSECT_WING,              50, xi.craftRank.AMATEUR },
            { xi.item.LIZARD_MOLT,              50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                   50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_SILVER_ORE,      50, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.AMATEUR },
            { xi.item.MYTHRIL_BEASTCOIN,        10, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.AMATEUR },
            { xi.item.TURTLE_SHELL,             10, xi.craftRank.AMATEUR },
            { xi.item.WILLOW_LOG,               10, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_ADVANCEMENT,       5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,      5, xi.craftRank.AMATEUR },
            { xi.item.PETRIFIED_LOG,             5, xi.craftRank.AMATEUR },
            { xi.item.PUFFBALL,                  5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,            100, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_FIRE_ORE,        10, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.ROLANBERRY_FIELDS] = -- 110
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.BEASTCOIN,               100, xi.craftRank.AMATEUR },
            { xi.item.SILVER_BEASTCOIN,        100, xi.craftRank.AMATEUR },
            { xi.item.FLINT_STONE,             100, xi.craftRank.AMATEUR },
            { xi.item.SLEEPSHROOM,             100, xi.craftRank.AMATEUR },
            { xi.item.WOOZYSHROOM,             100, xi.craftRank.AMATEUR },
            { xi.item.DANCESHROOM,              50, xi.craftRank.AMATEUR },
            { xi.item.GOLD_BEASTCOIN,           50, xi.craftRank.AMATEUR },
            { xi.item.INSECT_WING,              50, xi.craftRank.AMATEUR },
            { xi.item.LITTLE_WORM,              50, xi.craftRank.AMATEUR },
            { xi.item.MYTHRIL_BEASTCOIN,        50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                   50, xi.craftRank.AMATEUR },
            { xi.item.RED_JAR,                  50, xi.craftRank.AMATEUR },
            { xi.item.SPRIG_OF_SAGE,            50, xi.craftRank.AMATEUR },
            { xi.item.CORAL_FUNGUS,             10, xi.craftRank.AMATEUR },
            { xi.item.PUFFBALL,                 10, xi.craftRank.AMATEUR },
            { xi.item.REISHI_MUSHROOM,          10, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_GLORY,             5, xi.craftRank.AMATEUR },
            { xi.item.DEATHBALL,                 5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,      5, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ORICHALCUM_ORE,   5, xi.craftRank.AMATEUR },
            { xi.item.PLATINUM_BEASTCOIN,        5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,            100, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_FIRE_ORE,        10, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.EASTERN_ALTEPA_DESERT] = -- 114
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.FLINT_STONE,              240, xi.craftRank.AMATEUR },
            { xi.item.BONE_CHIP,                100, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_FRUIT_SEEDS,        50, xi.craftRank.AMATEUR },
            { xi.item.GIANT_FEMUR,               50, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_GRAIN_SEEDS,        50, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_HERB_SEEDS,         50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                    50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_SILVER_ORE,       50, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_VEGETABLE_SEEDS,    50, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_WILDGRASS_SEEDS,    50, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_WYVERN_SCALES,  50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ZINC_ORE,         50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ALUMINUM_ORE,     10, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_CACTUS_STEMS,       10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_MYTHRIL_ORE,      10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ORICHALCUM_ORE,   10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_PLATINUM_ORE,     10, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_TREE_CUTTINGS,      10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_GOLD_ORE,          5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,       5, xi.craftRank.AMATEUR },
            { xi.item.PHILOSOPHERS_STONE,         5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,             100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.WEST_SARUTABARUTA] = -- 115
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR },
            { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR },
            { xi.item.LAUAN_LOG,               50, xi.craftRank.AMATEUR },
            { xi.item.LITTLE_WORM,             50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                  50, xi.craftRank.AMATEUR },
            { xi.item.CLUMP_OF_MOKO_GRASS,     50, xi.craftRank.AMATEUR },
            { xi.item.GINGER_ROOT,             50, xi.craftRank.AMATEUR },
            { xi.item.INSECT_WING,             50, xi.craftRank.AMATEUR },
            { xi.item.YAGUDO_FEATHER,          50, xi.craftRank.AMATEUR },
            { xi.item.HEAD_OF_NAPA,            10, xi.craftRank.AMATEUR },
            { xi.item.BALL_OF_SARUTA_COTTON,   10, xi.craftRank.AMATEUR },
            { xi.item.BIRD_FEATHER,            10, xi.craftRank.AMATEUR },
            { xi.item.EBONY_LOG,               10, xi.craftRank.AMATEUR },
            { xi.item.BAG_OF_TREE_CUTTINGS,    10, xi.craftRank.AMATEUR },
            { xi.item.ROSEWOOD_LOG,             5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,     5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,           100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.EAST_SARUTABARUTA] = -- 116
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR },
            { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR },
            { xi.item.LAUAN_LOG,               50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                  50, xi.craftRank.AMATEUR },
            { xi.item.GINGER_ROOT,             50, xi.craftRank.AMATEUR },
            { xi.item.INSECT_WING,             50, xi.craftRank.AMATEUR },
            { xi.item.YAGUDO_FEATHER,          50, xi.craftRank.AMATEUR },
            { xi.item.BALL_OF_SARUTA_COTTON,   50, xi.craftRank.AMATEUR },
            { xi.item.PAPAKA_GRASS,            50, xi.craftRank.AMATEUR },
            { xi.item.HEAD_OF_NAPA,            10, xi.craftRank.AMATEUR },
            { xi.item.BIRD_FEATHER,            10, xi.craftRank.AMATEUR },
            { xi.item.EBONY_LOG,               10, xi.craftRank.AMATEUR },
            { xi.item.ROSEWOOD_LOG,             5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,     5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,           100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.TAHRONGI_CANYON] = -- 117
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.BEASTCOIN,                150, xi.craftRank.AMATEUR },
            { xi.item.BONE_CHIP,                100, xi.craftRank.AMATEUR },
            { xi.item.SEASHELL,                 100, xi.craftRank.AMATEUR },
            { xi.item.SILVER_BEASTCOIN,         100, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_FISH_SCALES,    50, xi.craftRank.AMATEUR },
            { xi.item.GOLD_BEASTCOIN,            50, xi.craftRank.AMATEUR },
            { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, xi.craftRank.AMATEUR },
            { xi.item.INSECT_WING,               50, xi.craftRank.AMATEUR },
            { xi.item.MYTHRIL_BEASTCOIN,         50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                    50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_TIN_ORE,          50, xi.craftRank.AMATEUR },
            { xi.item.TITANICTUS_SHELL,          50, xi.craftRank.AMATEUR },
            { xi.item.TURTLE_SHELL,              50, xi.craftRank.AMATEUR },
            { xi.item.YAGUDO_FEATHER,            50, xi.craftRank.AMATEUR },
            { xi.item.DEMON_HORN,                10, xi.craftRank.AMATEUR },
            { xi.item.DEMON_SKULL,               10, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_DRAGON_SCALES,  10, xi.craftRank.AMATEUR },
            { xi.item.GIANT_FEMUR,               10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_GOLD_ORE,         10, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_ADVANCEMENT,        5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,       5, xi.craftRank.AMATEUR },
            { xi.item.PLATINUM_BEASTCOIN,         5, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_WYVERN_SCALES,   5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,             100, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_FIRE_ORE,         10, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.BUBURIMU_PENINSULA] = -- 118
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.BLACK_CHOCOBO_FEATHER,    100, xi.craftRank.AMATEUR },
            { xi.item.PHOENIX_FEATHER,          100, xi.craftRank.AMATEUR },
            { xi.item.SEASHELL,                 100, xi.craftRank.AMATEUR },
            { xi.item.BIRD_FEATHER,              50, xi.craftRank.AMATEUR },
            { xi.item.BONE_CHIP,                 50, xi.craftRank.AMATEUR },
            { xi.item.DEMON_SKULL,               50, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_FISH_SCALES,    50, xi.craftRank.AMATEUR },
            { xi.item.GIANT_FEMUR,               50, xi.craftRank.AMATEUR },
            { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, xi.craftRank.AMATEUR },
            { xi.item.LUGWORM,                   50, xi.craftRank.AMATEUR },
            { xi.item.CLUMP_OF_RED_MOKO_GRASS,   50, xi.craftRank.AMATEUR },
            { xi.item.SHALL_SHELL,               50, xi.craftRank.AMATEUR },
            { xi.item.SHELL_BUG,                 50, xi.craftRank.AMATEUR },
            { xi.item.SPIDER_WEB,                50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_TIN_ORE,          50, xi.craftRank.AMATEUR },
            { xi.item.TITANICTUS_SHELL,          50, xi.craftRank.AMATEUR },
            { xi.item.TURTLE_SHELL,              50, xi.craftRank.AMATEUR },
            { xi.item.DEMON_HORN,                10, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_DRAGON_SCALES,  10, xi.craftRank.AMATEUR },
            { xi.item.GIANT_BIRD_PLUME,          10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_PLATINUM_ORE,     10, xi.craftRank.AMATEUR },
            { xi.item.ONE_BYNE_BILL,              5, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_BIRTH,              5, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_DECAY,              5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,       5, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_WYVERN_SCALES,   5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,             100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.MERIPHATAUD_MOUNTAINS] = -- 119
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.FLINT_STONE,               240, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_SILVER_ORE,       100, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_IRON_ORE,         100, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_KOPPARNICKEL_ORE, 100, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_COPPER_ORE,        50, xi.craftRank.AMATEUR },
            { xi.item.GIANT_FEMUR,                50, xi.craftRank.AMATEUR },
            { xi.item.INSECT_WING,                50, xi.craftRank.AMATEUR },
            { xi.item.LIZARD_MOLT,                50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_MYTHRIL_ORE,       50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                     50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_DARKSTEEL_ORE,     10, xi.craftRank.AMATEUR },
            { xi.item.GOLD_BEASTCOIN,             10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ADAMAN_ORE,         5, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ALUMINUM_ORE,       5, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_ADVANCEMENT,         5, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_GOLD_ORE,           5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,        5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,              100, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_FIRE_ORE,          10, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.SAUROMUGUE_CHAMPAIGN] = -- 120
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.BEASTCOIN,                100, xi.craftRank.AMATEUR },
            { xi.item.SILVER_BEASTCOIN,         100, xi.craftRank.AMATEUR },
            { xi.item.BONE_CHIP,                100, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_FISH_SCALES,    50, xi.craftRank.AMATEUR },
            { xi.item.FLINT_STONE,               50, xi.craftRank.AMATEUR },
            { xi.item.GOLD_BEASTCOIN,            50, xi.craftRank.AMATEUR },
            { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, xi.craftRank.AMATEUR },
            { xi.item.INSECT_WING,               50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_IRON_ORE,         50, xi.craftRank.AMATEUR },
            { xi.item.LIZARD_MOLT,               50, xi.craftRank.AMATEUR },
            { xi.item.MYTHRIL_BEASTCOIN,         50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                    50, xi.craftRank.AMATEUR },
            { xi.item.SEASHELL,                  50, xi.craftRank.AMATEUR },
            { xi.item.TURTLE_SHELL,              50, xi.craftRank.AMATEUR },
            { xi.item.BLACK_CHOCOBO_FEATHER,     10, xi.craftRank.AMATEUR },
            { xi.item.DEMON_HORN,                10, xi.craftRank.AMATEUR },
            { xi.item.DEMON_SKULL,               10, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_DRAGON_SCALES,  10, xi.craftRank.AMATEUR },
            { xi.item.RED_JAR,                   10, xi.craftRank.AMATEUR },
            { xi.item.TITANICTUS_SHELL,          10, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_WYVERN_SCALES,  10, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_GLORY,              5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,       5, xi.craftRank.AMATEUR },
            { xi.item.PLATINUM_BEASTCOIN,         5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,             100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.THE_SANCTUARY_OF_ZITAH] = -- 121
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.SILVER_BEASTCOIN,        150, xi.craftRank.AMATEUR },
            { xi.item.ARROWWOOD_LOG,           100, xi.craftRank.AMATEUR },
            { xi.item.BEASTCOIN,               100, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                  100, xi.craftRank.AMATEUR },
            { xi.item.YEW_LOG,                 100, xi.craftRank.AMATEUR },
            { xi.item.BONE_CHIP,                50, xi.craftRank.AMATEUR },
            { xi.item.ELM_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.CLUMP_OF_MOKO_GRASS,      50, xi.craftRank.AMATEUR },
            { xi.item.MYTHRIL_BEASTCOIN,        50, xi.craftRank.AMATEUR },
            { xi.item.OAK_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.EBONY_LOG,                10, xi.craftRank.AMATEUR },
            { xi.item.GOLD_BEASTCOIN,           10, xi.craftRank.AMATEUR },
            { xi.item.MAHOGANY_LOG,             10, xi.craftRank.AMATEUR },
            { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.AMATEUR },
            { xi.item.PIECE_OF_ANCIENT_LUMBER,   5, xi.craftRank.AMATEUR },
            { xi.item.COIN_OF_DECAY,             5, xi.craftRank.AMATEUR },
            { xi.item.LACQUER_TREE_LOG,          5, xi.craftRank.AMATEUR },
            { xi.item.PETRIFIED_LOG,             5, xi.craftRank.AMATEUR },
            { xi.item.PLATINUM_BEASTCOIN,        5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,            100, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_FIRE_ORE,        10, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.YUHTUNGA_JUNGLE] = -- 123
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.ARROWWOOD_LOG,           100, xi.craftRank.AMATEUR },
            { xi.item.BONE_CHIP,               100, xi.craftRank.AMATEUR },
            { xi.item.DANCESHROOM,             100, xi.craftRank.AMATEUR },
            { xi.item.WOOZYSHROOM,             100, xi.craftRank.AMATEUR },
            { xi.item.STICK_OF_CINNAMON,        50, xi.craftRank.AMATEUR },
            { xi.item.EBONY_LOG,                50, xi.craftRank.AMATEUR },
            { xi.item.ELM_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.PUFFBALL,                 50, xi.craftRank.AMATEUR },
            { xi.item.PIECE_OF_RATTAN_LUMBER,   50, xi.craftRank.AMATEUR },
            { xi.item.ROSEWOOD_LOG,             50, xi.craftRank.AMATEUR },
            { xi.item.SLEEPSHROOM,              50, xi.craftRank.AMATEUR },
            { xi.item.YEW_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.DEATHBALL,                10, xi.craftRank.AMATEUR },
            { xi.item.KING_TRUFFLE,             10, xi.craftRank.AMATEUR },
            { xi.item.OAK_LOG,                  10, xi.craftRank.AMATEUR },
            { xi.item.PETRIFIED_LOG,            10, xi.craftRank.AMATEUR },
            { xi.item.REISHI_MUSHROOM,          10, xi.craftRank.AMATEUR },
            { xi.item.PIECE_OF_ANCIENT_LUMBER,   5, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,      5, xi.craftRank.AMATEUR },
            { xi.item.LACQUER_TREE_LOG,          5, xi.craftRank.AMATEUR },
            { xi.item.MAHOGANY_LOG,              5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,            100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.YHOATOR_JUNGLE] = -- 124
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.ARROWWOOD_LOG,           100, xi.craftRank.AMATEUR },
            { xi.item.BONE_CHIP,               100, xi.craftRank.AMATEUR },
            { xi.item.DANCESHROOM,             100, xi.craftRank.AMATEUR },
            { xi.item.WOOZYSHROOM,             100, xi.craftRank.AMATEUR },
            { xi.item.DANCESHROOM,              50, xi.craftRank.AMATEUR },
            { xi.item.DRYAD_ROOT,               50, xi.craftRank.AMATEUR },
            { xi.item.EBONY_LOG,                50, xi.craftRank.AMATEUR },
            { xi.item.ELM_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.KAZHAM_PINEAPPLE,         50, xi.craftRank.AMATEUR },
            { xi.item.LAUAN_LOG,                50, xi.craftRank.AMATEUR },
            { xi.item.MAHOGANY_LOG,             50, xi.craftRank.AMATEUR },
            { xi.item.OAK_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.REISHI_MUSHROOM,          50, xi.craftRank.AMATEUR },
            { xi.item.ROSEWOOD_LOG,             50, xi.craftRank.AMATEUR },
            { xi.item.YEW_LOG,                  50, xi.craftRank.AMATEUR },
            { xi.item.CORAL_FUNGUS,             10, xi.craftRank.AMATEUR },
            { xi.item.PETRIFIED_LOG,            10, xi.craftRank.AMATEUR },
            { xi.item.PUFFBALL,                 10, xi.craftRank.AMATEUR },
            { xi.item.PIECE_OF_ANCIENT_LUMBER,   5, xi.craftRank.AMATEUR },
            { xi.item.DEATHBALL,                 5, xi.craftRank.AMATEUR },
            { xi.item.LACQUER_TREE_LOG,          5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,            100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },

    [xi.zone.WESTERN_ALTEPA_DESERT] = -- 125
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries
        },
        [diggingLayer.REGULAR] =
        {
            { xi.item.BONE_CHIP,                240, xi.craftRank.AMATEUR },
            { xi.item.BLACK_CHOCOBO_FEATHER,    100, xi.craftRank.AMATEUR },
            { xi.item.GIANT_FEMUR,              100, xi.craftRank.AMATEUR },
            { xi.item.PHOENIX_FEATHER,          100, xi.craftRank.AMATEUR },
            { xi.item.CORAL_FRAGMENT,            50, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_FISH_SCALES,    50, xi.craftRank.AMATEUR },
            { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_IRON_ORE,         50, xi.craftRank.AMATEUR },
            { xi.item.PEBBLE,                    50, xi.craftRank.AMATEUR },
            { xi.item.CLUMP_OF_RED_MOKO_GRASS,   50, xi.craftRank.AMATEUR },
            { xi.item.SEASHELL,                  50, xi.craftRank.AMATEUR },
            { xi.item.TURTLE_SHELL,              50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_ZINC_ORE,         50, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_DARKSTEEL_ORE,    10, xi.craftRank.AMATEUR },
            { xi.item.DEMON_HORN,                10, xi.craftRank.AMATEUR },
            { xi.item.DEMON_SKULL,               10, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_DRAGON_SCALES,  10, xi.craftRank.AMATEUR },
            { xi.item.GIANT_BIRD_PLUME,          10, xi.craftRank.AMATEUR },
            { xi.item.CHUNK_OF_GOLD_ORE,         10, xi.craftRank.AMATEUR },
            { xi.item.PHILOSOPHERS_STONE,        10, xi.craftRank.AMATEUR },
            { xi.item.SPIDER_WEB,                10, xi.craftRank.AMATEUR },
            { xi.item.TITANICTUS_SHELL,          10, xi.craftRank.AMATEUR },
            { xi.item.HANDFUL_OF_WYVERN_SCALES,  10, xi.craftRank.AMATEUR },
            { xi.item.PLATE_OF_HEAVY_METAL,       5, xi.craftRank.AMATEUR },
            { xi.item.FIRE_CRYSTAL,             100, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BURROW] =
        {
            -- No entries
        },
        [diggingLayer.BORE] =
        {
            -- No entries
        },
    },
}

-- This function handles zone and cooldown checks before digging can be attempted, before any animation is sent.
local function checkDiggingCooldowns(player)
    -- Check if current zone has digging enabled.
    local isAllowedZone = diggingZoneList[player:getZoneID()] or false

    if not isAllowedZone then
        player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0)

        return false
    end

    -- Check digging cooldowns.
    local currentTime  = os.time()
    local skillRank    = player:getSkillRank(xi.skill.DIG)
    local zoneCooldown = player:getLocalVar('ZoneInTime') + utils.clamp(60 - skillRank * 5, 10, 60)
    local digCooldown  = player:getLocalVar('[DIG]LastDigTime') + utils.clamp(15 - skillRank * 5, 3, 16)

    if
        currentTime < zoneCooldown or
        currentTime < digCooldown
    then
        player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0)

        return false
    end

    return true
end

local function calculateSkillUp(player)
    local skillRank = player:getSkillRank(xi.skill.DIG)
    local maxSkill  = utils.clamp((skillRank + 1) * 100, 0, 1000)
    local realSkill = player:getCharSkillLevel(xi.skill.DIG)
    local increment = 1

    -- this probably needs correcting
    local roll = math.random(1, 100)

    -- make sure our skill isn't capped
    if realSkill < maxSkill then
        -- can we skill up?
        if roll <= 15 then
            if (increment + realSkill) > maxSkill then
                increment = maxSkill - realSkill
            end

            -- skill up!
            player:setSkillLevel(xi.skill.DIG, realSkill + increment)

            -- update the skill rank
            -- Digging does not have test items, so increment rank once player hits 10.0, 20.0, .. 100.0
            if (realSkill + increment) >= (skillRank * 100) + 100 then
                player:setSkillRank(xi.skill.DIG, skillRank + 1)
            end
        end
    end
end

local function  handleDiggingLayer(player, zoneId, currentLayer)
    local digTable       = digInfo[zoneId][currentLayer]
    local dTableItemIds  = {}
    local rewardItem     = 0
    local rollMultiplier = 1 -- Determined by moon and certain gear. Higher = WORSE

    -- Determine moon multiplier.
    local moon = VanadielMoonPhase()

    if moon >= 40 and moon <= 60 then
        rollMultiplier = rollMultiplier * 2
    end

    -- TODO: Implement pants that lower common item chance and raise rare item chance.

    -- Add valid items to dynamic table
    if #digTable > 0 then
        local playerRank = player:getSkillRank(xi.skill.DIG)
        local itemEntry  = 0
        local randomRoll = 1000

        for i = 1, #digTable do
            randomRoll = utils.clamp(math.floor(math.random(1, 1000) * rollMultiplier), 1, 1000)

            if
                randomRoll <= digTable[i][2] and -- Roll check
                playerRank >= digTable[i][3]     -- Rank check
            then
                itemEntry = #dTableItemIds + 1 -- Calculate entry in dynamic table

                table.insert(dTableItemIds, itemEntry, digTable[i][1]) -- Insert item ID to table.
            end
        end
    end

    -- Add weather crystals and ores to regular layer only.
    if currentLayer == diggingLayer.REGULAR then
        -- local weather = player:getWeather()

        -- TODO: Add logic for Elemental Ores, Weather crystals and day geodes.
    end

    -- Choose a random entry from the valid item table.
    if #dTableItemIds > 0 then
        local chosenItem = math.random(1, #dTableItemIds)

        rewardItem = dTableItemIds[chosenItem]
    end

    return rewardItem
end

local function handleItemObtained(player, text, itemId)
    if itemId > 0 then
        -- Make sure we have enough room for the item.
        if player:addItem(itemId) then
            player:messageSpecial(text.ITEM_OBTAINED, itemId)
        else
            player:messageSpecial(text.DIG_THROW_AWAY, itemId)
        end
    end
end

xi.chocoboDig.start = function(player)
    local zoneId        = player:getZoneID()
    local text          = zones[zoneId].text
    local todayDigCount = player:getCharVar('[DIG]DigCount')
    local currentX      = player:getXPos()
    local currentZ      = player:getZPos()

    -----------------------------------
    -- Early returns and exceptions
    -----------------------------------

    -- Handle valid zones and digging cooldowns.
    if not checkDiggingCooldowns(player) then
        return false -- This means we do not send a digging animation.
    end

    -- Handle AMK mission 7 (index 6) exception.
    if
        xi.settings.main.ENABLE_AMK == 1 and
        player:getCurrentMission(xi.mission.log_id.AMK) == xi.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY and
        xi.amk.helpers.chocoboDig(player, zoneId, text)
    then
        -- Note: The helper function handles the messages.
        player:setLocalVar('[DIG]LastDigTime', os.time())

        return true
    end

    -- Handle auto-fail from fatigue.
    if
        xi.settings.main.DIG_FATIGUE > 0 and
        xi.settings.main.DIG_FATIGUE <= todayDigCount
    then
        player:messageText(player, text.FIND_NOTHING)
        player:setLocalVar('[DIG]LastDigTime', os.time())

        return true
    end

    -- Handle auto-fail from position.
    local lastX = player:getLocalVar('[DIG]LastXPos')
    local lastZ = player:getLocalVar('[DIG]LastZPos')

    if
        currentX >= lastX - 2 and currentX <= lastX + 2 and -- Check current X axis to see if you are too close to your last X.
        currentZ >= lastZ - 2 and currentZ <= lastZ + 2     -- Check current Z axis to see if you are too close to your last Z.
    then
        player:messageText(player, text.FIND_NOTHING)
        player:setLocalVar('[DIG]LastDigTime', os.time())

        return true
    end

    -----------------------------------
    -- Perform digging
    -----------------------------------

    -- Set player variables, no matter the result.
    player:setLocalVar('[DIG]LastXPos', currentX)
    player:setLocalVar('[DIG]LastZPos', currentZ)
    player:setLocalVar('[DIG]LastDigTime', os.time())
    player:setVar('[DIG]DigCount', todayDigCount + 1, NextJstDay())

    -- Handle trasure layer. Incompatible with the other 3 layers. "Early" return.
    local trasureItemId = handleDiggingLayer(player, zoneId, diggingLayer.TREASURE)

    if trasureItemId > 0 then
        handleItemObtained(player, text, trasureItemId)
        calculateSkillUp(player)
        player:triggerRoeEvent(xi.roeTrigger.CHOCOBO_DIG_SUCCESS)

        return true
    end

    -- Handle regular layer. This also contains, elemental ores, weather crystals and day-element geodes.
    local regularItemId = handleDiggingLayer(player, zoneId, diggingLayer.REGULAR)

    handleItemObtained(player, text, regularItemId)

    -- Handle Burrow layer. Requires Burrow skill.
    local burrowItemId = 0

    if xi.settings.main.DIG_GRANT_BURROW > 0 then -- TODO: Implement Chocobo Raising and Burrow chocobo skill. Good luck
        burrowItemId = handleDiggingLayer(player, zoneId, diggingLayer.BURROW)

        handleItemObtained(player, text, burrowItemId)
    end

    -- Handle Bore layer. Requires Bore skill.
    local boreItemId = 0

    if xi.settings.main.DIG_GRANT_BORE > 0 then -- TODO: Implement Chocobo Raising and Bore chocobo skill. Good luck
        boreItemId = handleDiggingLayer(player, zoneId, diggingLayer.BORE)

        handleItemObtained(player, text, boreItemId)
    end

    -- Handle skill-up
    calculateSkillUp(player)

    -- Handle no item OR record of eminence.
    if
        regularItemId == 0 and
        burrowItemId == 0 and
        boreItemId == 0
    then
        player:messageText(player, text.FIND_NOTHING)
    else
        player:triggerRoeEvent(xi.roeTrigger.CHOCOBO_DIG_SUCCESS)
    end

    -- Dig ended. Send digging animation to players.
    return true
end
