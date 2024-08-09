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

local digReq =
{
    NO_REQS = 0,
    BURROW  = 1,
    BORE    = 2,
}

local crystalMap =
{
    -- Single weather by elemental order.
    [xi.weather.HOT_SPELL    ] = xi.item.FIRE_CRYSTAL,
    [xi.weather.SNOW         ] = xi.item.ICE_CRYSTAL,
    [xi.weather.WIND         ] = xi.item.WIND_CRYSTAL,
    [xi.weather.DUST_STORM   ] = xi.item.EARTH_CRYSTAL,
    [xi.weather.THUNDER      ] = xi.item.LIGHTNING_CRYSTAL,
    [xi.weather.RAIN         ] = xi.item.WATER_CRYSTAL,
    [xi.weather.AURORAS      ] = xi.item.LIGHT_CRYSTAL,
    [xi.weather.GLOOM        ] = xi.item.DARK_CRYSTAL,

    -- Double weather by elemental order.
    [xi.weather.HEAT_WAVE    ] = xi.item.FIRE_CLUSTER,
    [xi.weather.BLIZZARDS    ] = xi.item.ICE_CLUSTER,
    [xi.weather.GALES        ] = xi.item.WIND_CLUSTER,
    [xi.weather.SAND_STORM   ] = xi.item.EARTH_CLUSTER,
    [xi.weather.THUNDERSTORMS] = xi.item.LIGHTNING_CLUSTER,
    [xi.weather.SQUALL       ] = xi.item.WATER_CLUSTER,
    [xi.weather.STELLAR_GLARE] = xi.item.LIGHT_CLUSTER,
    [xi.weather.DARKNESS     ] = xi.item.DARK_CLUSTER,
}

local oreMap =
{
    [xi.day.FIRESDAY    ] = xi.item.CHUNK_OF_FIRE_ORE,
    [xi.day.ICEDAY      ] = xi.item.CHUNK_OF_ICE_ORE,
    [xi.day.WINDSDAY    ] = xi.item.CHUNK_OF_WIND_ORE,
    [xi.day.EARTHSDAY   ] = xi.item.CHUNK_OF_EARTH_ORE,
    [xi.day.LIGHTNINGDAY] = xi.item.CHUNK_OF_LIGHTNING_ORE,
    [xi.day.WATERSDAY   ] = xi.item.CHUNK_OF_WATER_ORE,
    [xi.day.LIGHTSDAY   ] = xi.item.CHUNK_OF_LIGHT_ORE,
    [xi.day.DARKSDAY    ] = xi.item.CHUNK_OF_DARK_ORE,
}

-----------------------------------
-- Table for common items without special conditions. [Zone ID] = { itemId, weight, dig requirement }
-- Data from BG wiki: https://www.bg-wiki.com/ffxi/Category:Chocobo_Digging
-----------------------------------
local digInfo =
{
    [xi.zone.CARPENTERS_LANDING] = -- 2
    {
        { xi.item.ARROWWOOD_LOG,           100, digReq.NO_REQS },
        { xi.item.LITTLE_WORM,             100, digReq.NO_REQS },
        { xi.item.ACORN,                    50, digReq.NO_REQS },
        { xi.item.HOLLY_LOG,                50, digReq.NO_REQS },
        { xi.item.MAPLE_LOG,                50, digReq.NO_REQS },
        { xi.item.OAK_LOG,                  50, digReq.NO_REQS },
        { xi.item.WILLOW_LOG,               50, digReq.NO_REQS },
        { xi.item.YEW_LOG,                  50, digReq.BORE    },
        { xi.item.PIECE_OF_ANCIENT_LUMBER,  10, digReq.NO_REQS },
        { xi.item.EBONY_LOG,                10, digReq.NO_REQS },
        { xi.item.ELM_LOG,                  10, digReq.BORE    },
        { xi.item.SPRIG_OF_MISTLETOE,       10, digReq.NO_REQS },
        { xi.item.ROSEWOOD_LOG,             10, digReq.BORE    },
        { xi.item.SCREAM_FUNGUS,            10, digReq.NO_REQS },
        { xi.item.KING_TRUFFLE,             10, digReq.NO_REQS },
        { xi.item.LACQUER_TREE_LOG,         10, digReq.BORE    },
        { xi.item.MAHOGANY_LOG,             10, digReq.BORE    },
        { xi.item.FIRE_CRYSTAL,            100, digReq.NO_REQS },
        { xi.item.CHUNK_OF_FIRE_ORE,        10, digReq.NO_REQS },
    },
    [xi.zone.BIBIKI_BAY] = -- 4
    {
        { xi.item.BLACK_CHOCOBO_FEATHER,    100, digReq.BURROW  },
        { xi.item.SEASHELL,                 100, digReq.NO_REQS },
        { xi.item.BIRD_FEATHER,              50, digReq.NO_REQS },
        { xi.item.BONE_CHIP,                 50, digReq.BORE    },
        { xi.item.HANDFUL_OF_FISH_SCALES,    50, digReq.BORE    },
        { xi.item.GIANT_FEMUR,               50, digReq.NO_REQS },
        { xi.item.LUGWORM,                   50, digReq.NO_REQS },
        { xi.item.PHOENIX_FEATHER,           50, digReq.BURROW  },
        { xi.item.CLUMP_OF_RED_MOKO_GRASS,   50, digReq.BURROW  },
        { xi.item.SHALL_SHELL,               50, digReq.NO_REQS },
        { xi.item.CHUNK_OF_TIN_ORE,          50, digReq.NO_REQS },
        { xi.item.TITANICTUS_SHELL,          50, digReq.BORE    },
        { xi.item.TURTLE_SHELL,              50, digReq.NO_REQS },
        { xi.item.DEMON_HORN,                10, digReq.BORE    },
        { xi.item.DEMON_SKULL,               10, digReq.BORE    },
        { xi.item.HANDFUL_OF_DRAGON_SCALES,  10, digReq.BORE    },
        { xi.item.GIANT_BIRD_PLUME,          10, digReq.BURROW  },
        { xi.item.HIGH_QUALITY_PUGIL_SCALE,  10, digReq.BORE    },
        { xi.item.SHELL_BUG,                 10, digReq.NO_REQS },
        { xi.item.SPIDER_WEB,                10, digReq.BURROW  },
        { xi.item.HANDFUL_OF_WYVERN_SCALES,  10, digReq.BORE    },
        { xi.item.COIN_OF_BIRTH,              5, digReq.NO_REQS },
        { xi.item.CORAL_FRAGMENT,             5, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,       5, digReq.NO_REQS },
        { xi.item.CHUNK_OF_PLATINUM_ORE,      5, digReq.BORE    },
        { xi.item.FIRE_CRYSTAL,             100, digReq.NO_REQS },
    },
    [xi.zone.WAJAOM_WOODLANDS] = -- 51
    {
        { xi.item.FLINT_STONE,             240, digReq.NO_REQS },
        { xi.item.ARROWWOOD_LOG,           150, digReq.NO_REQS },
        { xi.item.CLUMP_OF_MOKO_GRASS,     100, digReq.NO_REQS },
        { xi.item.BLACK_CHOCOBO_FEATHER,    50, digReq.BURROW  },
        { xi.item.EBONY_LOG,                50, digReq.BURROW  },
        { xi.item.ELM_LOG,                  50, digReq.BURROW  },
        { xi.item.OAK_LOG,                  50, digReq.BURROW  },
        { xi.item.PEBBLE,                   50, digReq.NO_REQS },
        { xi.item.HANDFUL_OF_PINE_NUTS,     50, digReq.NO_REQS },
        { xi.item.YEW_LOG,                  50, digReq.BURROW  },
        { xi.item.CHUNK_OF_ADAMAN_ORE,      10, digReq.BORE    },
        { xi.item.CHUNK_OF_ALUMINUM_ORE,    10, digReq.BORE    },
        { xi.item.CHUNK_OF_DARKSTEEL_ORE,   10, digReq.BORE    },
        { xi.item.CHUNK_OF_GOLD_ORE,        10, digReq.BORE    },
        { xi.item.MAHOGANY_LOG,             10, digReq.BURROW  },
        { xi.item.CHUNK_OF_ORICHALCUM_ORE,  10, digReq.BORE    },
        { xi.item.PEPHEDRO_HIVE_CHIP,       10, digReq.NO_REQS },
        { xi.item.SPIDER_WEB,               10, digReq.BURROW  },
        { xi.item.ALEXANDRITE,               5, digReq.NO_REQS },
        { xi.item.PIECE_OF_ANCIENT_LUMBER,   5, digReq.BURROW  },
        { xi.item.CHUNK_OF_KAOLIN,           5, digReq.BORE    },
        { xi.item.LACQUER_TREE_LOG,          5, digReq.BURROW  },
        { xi.item.CHUNK_OF_PLATINUM_ORE,     5, digReq.BORE    },
        { xi.item.ROSEWOOD_LOG,              5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,            100, digReq.NO_REQS },
    },
    [xi.zone.BHAFLAU_THICKETS] = -- 52
    {
        { xi.item.FLINT_STONE,             240, digReq.BORE    },
        { xi.item.ARROWWOOD_LOG,           150, digReq.BURROW  },
        { xi.item.COLIBRI_FEATHER,          50, digReq.NO_REQS },
        { xi.item.PINCH_OF_DRIED_MARJORAM,  50, digReq.NO_REQS },
        { xi.item.CLUMP_OF_MOKO_GRASS,      50, digReq.NO_REQS },
        { xi.item.OAK_LOG,                  50, digReq.BURROW  },
        { xi.item.PEBBLE,                   50, digReq.NO_REQS },
        { xi.item.PETRIFIED_LOG,            50, digReq.BURROW  },
        { xi.item.HANDFUL_OF_PINE_NUTS,     50, digReq.NO_REQS },
        { xi.item.YEW_LOG,                  50, digReq.BURROW  },
        { xi.item.CHUNK_OF_ALUMINUM_ORE,    10, digReq.BORE    },
        { xi.item.BLACK_CHOCOBO_FEATHER,    10, digReq.BURROW  },
        { xi.item.EBONY_LOG,                10, digReq.BURROW  },
        { xi.item.ELM_LOG,                  10, digReq.BURROW  },
        { xi.item.CHUNK_OF_GOLD_ORE,        10, digReq.BORE    },
        { xi.item.MAHOGANY_LOG,             10, digReq.BURROW  },
        { xi.item.CHUNK_OF_ORICHALCUM_ORE,  10, digReq.BORE    },
        { xi.item.CHUNK_OF_PLATINUM_ORE,    10, digReq.BORE    },
        { xi.item.ROSEWOOD_LOG,             10, digReq.BURROW  },
        { xi.item.ALEXANDRITE,               5, digReq.NO_REQS },
        { xi.item.PIECE_OF_ANCIENT_LUMBER,   5, digReq.BURROW  },
        { xi.item.CHUNK_OF_DARKSTEEL_ORE,    5, digReq.BORE    },
        { xi.item.LACQUER_TREE_LOG,          5, digReq.BURROW  },
        { xi.item.LESSER_CHIGOE,             5, digReq.NO_REQS },
        { xi.item.PEPHEDRO_HIVE_CHIP,        5, digReq.NO_REQS },
        { xi.item.SPIDER_WEB,                5, digReq.BURROW  },
        { xi.item.FIRE_CRYSTAL,            100, digReq.NO_REQS },
    },
    [xi.zone.WEST_RONFAURE] = -- 100
    {
        { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, digReq.BURROW  },
        { xi.item.CHAMOMILE,               50, digReq.BURROW  },
        { xi.item.GINGER_ROOT,             50, digReq.BORE    },
        { xi.item.ARROWWOOD_LOG,           50, digReq.NO_REQS },
        { xi.item.LITTLE_WORM,             50, digReq.NO_REQS },
        { xi.item.ASH_LOG,                 50, digReq.NO_REQS },
        { xi.item.ACORN,                   50, digReq.NO_REQS },
        { xi.item.CHOCOBO_FEATHER,         50, digReq.NO_REQS },
        { xi.item.CLUMP_OF_MOKO_GRASS,     50, digReq.NO_REQS },
        { xi.item.MAPLE_LOG,               50, digReq.NO_REQS },
        { xi.item.HEAD_OF_NAPA,            50, digReq.NO_REQS },
        { xi.item.RONFAURE_CHESTNUT,       10, digReq.NO_REQS },
        { xi.item.BAG_OF_VEGETABLE_SEEDS,  10, digReq.NO_REQS },
        { xi.item.CHESTNUT_LOG,            10, digReq.NO_REQS },
        { xi.item.SPRIG_OF_MISTLETOE,      10, digReq.NO_REQS },
        { xi.item.KING_TRUFFLE,            10, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,     5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,           100, digReq.NO_REQS },
    },
    [xi.zone.EAST_RONFAURE] = -- 101
    {
        { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, digReq.BURROW  },
        { xi.item.CHAMOMILE,               50, digReq.BURROW  },
        { xi.item.GINGER_ROOT,             50, digReq.BORE    },
        { xi.item.ARROWWOOD_LOG,           50, digReq.NO_REQS },
        { xi.item.LITTLE_WORM,             50, digReq.NO_REQS },
        { xi.item.ASH_LOG,                 50, digReq.NO_REQS },
        { xi.item.ACORN,                   50, digReq.NO_REQS },
        { xi.item.CHOCOBO_FEATHER,         50, digReq.NO_REQS },
        { xi.item.CLUMP_OF_MOKO_GRASS,     50, digReq.NO_REQS },
        { xi.item.MAPLE_LOG,               50, digReq.NO_REQS },
        { xi.item.HEAD_OF_NAPA,            50, digReq.NO_REQS },
        { xi.item.RONFAURE_CHESTNUT,       10, digReq.NO_REQS },
        { xi.item.BAG_OF_VEGETABLE_SEEDS,  10, digReq.NO_REQS },
        { xi.item.CHESTNUT_LOG,            10, digReq.NO_REQS },
        { xi.item.SPRIG_OF_MISTLETOE,      10, digReq.NO_REQS },
        { xi.item.KING_TRUFFLE,            10, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,     5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,           100, digReq.NO_REQS },
    },
    [xi.zone.LA_THEINE_PLATEAU] = -- 102
    {
        { xi.item.BUNCH_OF_GYSAHL_GREENS,  150, digReq.BURROW  },
        { xi.item.PIECE_OF_YELLOW_YINSENG, 150, digReq.BORE    },
        { xi.item.CHAMOMILE,                50, digReq.BURROW  },
        { xi.item.ARROWWOOD_LOG,            50, digReq.NO_REQS },
        { xi.item.CHOCOBO_FEATHER,          50, digReq.NO_REQS },
        { xi.item.GINGER_ROOT,              50, digReq.BURROW  },
        { xi.item.LITTLE_WORM,              50, digReq.NO_REQS },
        { xi.item.HEAD_OF_NAPA,             50, digReq.BURROW  },
        { xi.item.PEBBLE,                   50, digReq.NO_REQS },
        { xi.item.CHUNK_OF_TIN_ORE,         50, digReq.NO_REQS },
        { xi.item.BAG_OF_TREE_CUTTINGS,     50, digReq.BORE    },
        { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, digReq.BORE    },
        { xi.item.YEW_LOG,                  50, digReq.NO_REQS },
        { xi.item.CHUNK_OF_ZINC_ORE,        50, digReq.NO_REQS },
        { xi.item.CHESTNUT_LOG,             10, digReq.NO_REQS },
        { xi.item.PINCH_OF_DRIED_MARJORAM,  10, digReq.NO_REQS },
        { xi.item.BAG_OF_CACTUS_STEMS,      10, digReq.NO_REQS },
        { xi.item.COIN_OF_GLORY,             5, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,      5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,            100, digReq.NO_REQS },
        { xi.item.CHUNK_OF_FIRE_ORE,        10, digReq.NO_REQS },
    },
    [xi.zone.VALKURM_DUNES] = -- 103
    {
        { xi.item.SEASHELL,                 150, digReq.NO_REQS },
        { xi.item.BLACK_CHOCOBO_FEATHER,    100, digReq.BURROW  },
        { xi.item.BONE_CHIP,                100, digReq.NO_REQS },
        { xi.item.PHOENIX_FEATHER,          100, digReq.BURROW  },
        { xi.item.HANDFUL_OF_FISH_SCALES,    50, digReq.NO_REQS },
        { xi.item.GIANT_FEMUR,               50, digReq.NO_REQS },
        { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, digReq.BORE    },
        { xi.item.LIZARD_MOLT,               50, digReq.NO_REQS },
        { xi.item.LUGWORM,                   50, digReq.NO_REQS },
        { xi.item.CLUMP_OF_RED_MOKO_GRASS,   50, digReq.BURROW  },
        { xi.item.SHALL_SHELL,               50, digReq.NO_REQS },
        { xi.item.SHELL_BUG,                 50, digReq.NO_REQS },
        { xi.item.SPIDER_WEB,                50, digReq.BURROW  },
        { xi.item.TITANICTUS_SHELL,          50, digReq.BORE    },
        { xi.item.TURTLE_SHELL,              50, digReq.NO_REQS },
        { xi.item.DEMON_HORN,                10, digReq.BORE    },
        { xi.item.DEMON_SKULL,               10, digReq.BORE    },
        { xi.item.HANDFUL_OF_DRAGON_SCALES,  10, digReq.BORE    },
        { xi.item.GIANT_BIRD_PLUME,          10, digReq.BURROW  },
        { xi.item.HANDFUL_OF_WYVERN_SCALES,  10, digReq.BORE    },
        { xi.item.COIN_OF_DECAY,              5, digReq.NO_REQS },
        { xi.item.ORDELLE_BRONZEPIECE,        5, digReq.NO_REQS },
        { xi.item.TUKUKU_WHITESHELL,          5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,             100, digReq.NO_REQS },
    },
    [xi.zone.JUGNER_FOREST] = -- 104
    {
        { xi.item.ARROWWOOD_LOG,           150, digReq.NO_REQS },
        { xi.item.ACORN,                    50, digReq.NO_REQS },
        { xi.item.HOLLY_LOG,                50, digReq.NO_REQS },
        { xi.item.LITTLE_WORM,              50, digReq.NO_REQS },
        { xi.item.MAPLE_LOG,                50, digReq.NO_REQS },
        { xi.item.OAK_LOG,                  50, digReq.NO_REQS },
        { xi.item.WILLOW_LOG,               50, digReq.NO_REQS },
        { xi.item.YEW_LOG,                  50, digReq.BORE    },
        { xi.item.ELM_LOG,                  10, digReq.BORE    },
        { xi.item.LACQUER_TREE_LOG,         10, digReq.BORE    },
        { xi.item.MAHOGANY_LOG,             10, digReq.BORE    },
        { xi.item.SPRIG_OF_MISTLETOE,       10, digReq.NO_REQS },
        { xi.item.ROSEWOOD_LOG,              5, digReq.BORE    },
        { xi.item.PIECE_OF_ANCIENT_LUMBER,   5, digReq.BORE    },
        { xi.item.SCREAM_FUNGUS,             5, digReq.NO_REQS },
        { xi.item.COIN_OF_BIRTH,             5, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,      5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,            100, digReq.NO_REQS },
        { xi.item.CHUNK_OF_FIRE_ORE,        10, digReq.NO_REQS },
    },
    [xi.zone.BATALLIA_DOWNS] = -- 105
    {
        { xi.item.PIECE_OF_YELLOW_YINSENG, 150, digReq.BORE    },
        { xi.item.BEASTCOIN,               100, digReq.BURROW  },
        { xi.item.SILVER_BEASTCOIN,        100, digReq.BURROW  },
        { xi.item.BIRD_FEATHER,             50, digReq.NO_REQS },
        { xi.item.BONE_CHIP,                50, digReq.NO_REQS },
        { xi.item.CHUNK_OF_COPPER_ORE,      50, digReq.NO_REQS },
        { xi.item.FLINT_STONE,              50, digReq.NO_REQS },
        { xi.item.GOLD_BEASTCOIN,           50, digReq.BURROW  },
        { xi.item.CHUNK_OF_IRON_ORE,        50, digReq.NO_REQS },
        { xi.item.MYTHRIL_BEASTCOIN,        50, digReq.BURROW  },
        { xi.item.PEBBLE,                   50, digReq.NO_REQS },
        { xi.item.RED_JAR,                  50, digReq.NO_REQS },
        { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, digReq.BORE    },
        { xi.item.PLATINUM_BEASTCOIN,       10, digReq.BURROW  },
        { xi.item.BAG_OF_TREE_CUTTINGS,     10, digReq.BORE    },
        { xi.item.BLACK_CHOCOBO_FEATHER,     5, digReq.BORE    },
        { xi.item.BAG_OF_CACTUS_STEMS,       5, digReq.NO_REQS },
        { xi.item.COIN_OF_ADVANCEMENT,       5, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,      5, digReq.NO_REQS },
        { xi.item.REISHI_MUSHROOM,           5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,            100, digReq.NO_REQS },
        { xi.item.CHUNK_OF_FIRE_ORE,        10, digReq.NO_REQS },
    },
    [xi.zone.NORTH_GUSTABERG] = -- 106
    {
        { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, digReq.BURROW  },
        { xi.item.BIRD_FEATHER,            50, digReq.NO_REQS },
        { xi.item.BONE_CHIP,               50, digReq.NO_REQS },
        { xi.item.CHAMOMILE,               50, digReq.BURROW  },
        { xi.item.HANDFUL_OF_FISH_SCALES,  50, digReq.NO_REQS },
        { xi.item.GINGER_ROOT,             50, digReq.BORE    },
        { xi.item.INSECT_WING,             50, digReq.NO_REQS },
        { xi.item.LITTLE_WORM,             50, digReq.NO_REQS },
        { xi.item.LIZARD_MOLT,             50, digReq.NO_REQS },
        { xi.item.HEAD_OF_NAPA,            50, digReq.NO_REQS },
        { xi.item.PEBBLE,                  50, digReq.NO_REQS },
        { xi.item.BAG_OF_CACTUS_STEMS,     10, digReq.NO_REQS },
        { xi.item.CHUNK_OF_DARKSTEEL_ORE,  10, digReq.BORE    },
        { xi.item.MYTHRIL_BEASTCOIN,       10, digReq.BURROW  },
        { xi.item.CHUNK_OF_MYTHRIL_ORE,    10, digReq.BORE    },
        { xi.item.PLATE_OF_HEAVY_METAL,     5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,           100, digReq.NO_REQS },
    },
    [xi.zone.SOUTH_GUSTABERG] = -- 107
    {
        { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, digReq.BURROW  },
        { xi.item.BIRD_FEATHER,            50, digReq.NO_REQS },
        { xi.item.BONE_CHIP,               50, digReq.NO_REQS },
        { xi.item.CHAMOMILE,               50, digReq.BURROW  },
        { xi.item.GINGER_ROOT,             50, digReq.BORE    },
        { xi.item.BAG_OF_GRAIN_SEEDS,      50, digReq.NO_REQS },
        { xi.item.INSECT_WING,             50, digReq.NO_REQS },
        { xi.item.LITTLE_WORM,             50, digReq.NO_REQS },
        { xi.item.LIZARD_MOLT,             50, digReq.NO_REQS },
        { xi.item.MYTHRIL_BEASTCOIN,       50, digReq.BURROW  },
        { xi.item.HEAD_OF_NAPA,            50, digReq.NO_REQS },
        { xi.item.PEBBLE,                  50, digReq.NO_REQS },
        { xi.item.CHUNK_OF_ROCK_SALT,      50, digReq.NO_REQS },
        { xi.item.COIN_OF_DECAY,            5, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,     5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,           100, digReq.NO_REQS },
    },
    [xi.zone.KONSCHTAT_HIGHLANDS] = -- 108
    {
        { xi.item.BLACK_CHOCOBO_FEATHER,   100, digReq.BURROW  },
        { xi.item.PHOENIX_FEATHER,         100, digReq.BURROW  },
        { xi.item.BONE_CHIP,                50, digReq.NO_REQS },
        { xi.item.ELM_LOG,                  50, digReq.NO_REQS },
        { xi.item.HANDFUL_OF_FISH_SCALES,   50, digReq.NO_REQS },
        { xi.item.FLINT_STONE,              50, digReq.NO_REQS },
        { xi.item.LIZARD_MOLT,              50, digReq.NO_REQS },
        { xi.item.PEBBLE,                   50, digReq.NO_REQS },
        { xi.item.CLUMP_OF_RED_MOKO_GRASS,  50, digReq.BURROW  },
        { xi.item.SPIDER_WEB,               50, digReq.BURROW  },
        { xi.item.CHUNK_OF_ZINC_ORE,        50, digReq.NO_REQS },
        { xi.item.BIRD_FEATHER,             10, digReq.NO_REQS },
        { xi.item.GIANT_BIRD_PLUME,         10, digReq.BURROW  },
        { xi.item.COIN_OF_BIRTH,             5, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,      5, digReq.NO_REQS },
        { xi.item.MYTHRIL_BEASTCOIN,         5, digReq.BURROW  },
        { xi.item.FIRE_CRYSTAL,            100, digReq.NO_REQS },
        { xi.item.CHUNK_OF_FIRE_ORE,        10, digReq.NO_REQS },
    },
    [xi.zone.PASHHOW_MARSHLANDS] = -- 109
    {
        { xi.item.PIECE_OF_YELLOW_YINSENG, 150, digReq.BURROW  },
        { xi.item.INSECT_WING,              50, digReq.NO_REQS },
        { xi.item.LIZARD_MOLT,              50, digReq.NO_REQS },
        { xi.item.PEBBLE,                   50, digReq.NO_REQS },
        { xi.item.CHUNK_OF_SILVER_ORE,      50, digReq.NO_REQS },
        { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, digReq.NO_REQS },
        { xi.item.MYTHRIL_BEASTCOIN,        10, digReq.BURROW  },
        { xi.item.BAG_OF_TREE_CUTTINGS,     10, digReq.BURROW  },
        { xi.item.TURTLE_SHELL,             10, digReq.NO_REQS },
        { xi.item.WILLOW_LOG,               10, digReq.NO_REQS },
        { xi.item.BAG_OF_CACTUS_STEMS,       5, digReq.BURROW  },
        { xi.item.COIN_OF_ADVANCEMENT,       5, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,      5, digReq.NO_REQS },
        { xi.item.PETRIFIED_LOG,             5, digReq.NO_REQS },
        { xi.item.PUFFBALL,                  5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,            100, digReq.NO_REQS },
        { xi.item.CHUNK_OF_FIRE_ORE,        10, digReq.NO_REQS },
    },
    [xi.zone.ROLANBERRY_FIELDS] = -- 110
    {
        { xi.item.BEASTCOIN,               100, digReq.BURROW  },
        { xi.item.SILVER_BEASTCOIN,        100, digReq.BURROW  },
        { xi.item.FLINT_STONE,             100, digReq.NO_REQS },
        { xi.item.SLEEPSHROOM,             100, digReq.BORE    },
        { xi.item.WOOZYSHROOM,             100, digReq.BORE    },
        { xi.item.DANCESHROOM,              50, digReq.BORE    },
        { xi.item.GOLD_BEASTCOIN,           50, digReq.BURROW  },
        { xi.item.INSECT_WING,              50, digReq.NO_REQS },
        { xi.item.LITTLE_WORM,              50, digReq.NO_REQS },
        { xi.item.MYTHRIL_BEASTCOIN,        50, digReq.BURROW  },
        { xi.item.PEBBLE,                   50, digReq.NO_REQS },
        { xi.item.RED_JAR,                  50, digReq.NO_REQS },
        { xi.item.SPRIG_OF_SAGE,            50, digReq.NO_REQS },
        { xi.item.CORAL_FUNGUS,             10, digReq.NO_REQS },
        { xi.item.PUFFBALL,                 10, digReq.NO_REQS },
        { xi.item.REISHI_MUSHROOM,          10, digReq.BORE    },
        { xi.item.COIN_OF_GLORY,             5, digReq.NO_REQS },
        { xi.item.DEATHBALL,                 5, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,      5, digReq.NO_REQS },
        { xi.item.CHUNK_OF_ORICHALCUM_ORE,   5, digReq.BORE    },
        { xi.item.PLATINUM_BEASTCOIN,        5, digReq.BURROW  },
        { xi.item.FIRE_CRYSTAL,            100, digReq.NO_REQS },
        { xi.item.CHUNK_OF_FIRE_ORE,        10, digReq.NO_REQS },
    },
    [xi.zone.EASTERN_ALTEPA_DESERT] = -- 114
    {
        { xi.item.FLINT_STONE,              240, digReq.BORE    },
        { xi.item.BONE_CHIP,                100, digReq.NO_REQS },
        { xi.item.BAG_OF_FRUIT_SEEDS,        50, digReq.BURROW  },
        { xi.item.GIANT_FEMUR,               50, digReq.NO_REQS },
        { xi.item.BAG_OF_GRAIN_SEEDS,        50, digReq.BURROW  },
        { xi.item.BAG_OF_HERB_SEEDS,         50, digReq.BURROW  },
        { xi.item.PEBBLE,                    50, digReq.NO_REQS },
        { xi.item.CHUNK_OF_SILVER_ORE,       50, digReq.BORE    },
        { xi.item.BAG_OF_VEGETABLE_SEEDS,    50, digReq.BURROW  },
        { xi.item.BAG_OF_WILDGRASS_SEEDS,    50, digReq.BURROW  },
        { xi.item.HANDFUL_OF_WYVERN_SCALES,  50, digReq.NO_REQS },
        { xi.item.CHUNK_OF_ZINC_ORE,         50, digReq.NO_REQS },
        { xi.item.CHUNK_OF_ALUMINUM_ORE,     10, digReq.BORE    },
        { xi.item.BAG_OF_CACTUS_STEMS,       10, digReq.NO_REQS },
        { xi.item.CHUNK_OF_MYTHRIL_ORE,      10, digReq.NO_REQS },
        { xi.item.CHUNK_OF_ORICHALCUM_ORE,   10, digReq.BORE    },
        { xi.item.CHUNK_OF_PLATINUM_ORE,     10, digReq.BORE    },
        { xi.item.BAG_OF_TREE_CUTTINGS,      10, digReq.BURROW  },
        { xi.item.CHUNK_OF_GOLD_ORE,          5, digReq.BORE    },
        { xi.item.PLATE_OF_HEAVY_METAL,       5, digReq.NO_REQS },
        { xi.item.PHILOSOPHERS_STONE,         5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,             100, digReq.NO_REQS },
    },
    [xi.zone.WEST_SARUTABARUTA] = -- 115
    {
        { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, digReq.BURROW  },
        { xi.item.CHAMOMILE,               50, digReq.BURROW  },
        { xi.item.LAUAN_LOG,               50, digReq.NO_REQS },
        { xi.item.LITTLE_WORM,             50, digReq.NO_REQS },
        { xi.item.PEBBLE,                  50, digReq.NO_REQS },
        { xi.item.CLUMP_OF_MOKO_GRASS,     50, digReq.NO_REQS },
        { xi.item.GINGER_ROOT,             50, digReq.BORE    },
        { xi.item.INSECT_WING,             50, digReq.NO_REQS },
        { xi.item.YAGUDO_FEATHER,          50, digReq.NO_REQS },
        { xi.item.HEAD_OF_NAPA,            10, digReq.BURROW  },
        { xi.item.BALL_OF_SARUTA_COTTON,   10, digReq.NO_REQS },
        { xi.item.BIRD_FEATHER,            10, digReq.NO_REQS },
        { xi.item.EBONY_LOG,               10, digReq.NO_REQS },
        { xi.item.BAG_OF_TREE_CUTTINGS,    10, digReq.BORE    },
        { xi.item.ROSEWOOD_LOG,             5, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,     5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,           100, digReq.NO_REQS },
    },
    [xi.zone.EAST_SARUTABARUTA] = -- 116
    {
        { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, digReq.BURROW  },
        { xi.item.CHAMOMILE,               50, digReq.BURROW  },
        { xi.item.LAUAN_LOG,               50, digReq.NO_REQS },
        { xi.item.PEBBLE,                  50, digReq.NO_REQS },
        { xi.item.GINGER_ROOT,             50, digReq.BORE    },
        { xi.item.INSECT_WING,             50, digReq.NO_REQS },
        { xi.item.YAGUDO_FEATHER,          50, digReq.NO_REQS },
        { xi.item.BALL_OF_SARUTA_COTTON,   50, digReq.NO_REQS },
        { xi.item.PAPAKA_GRASS,            50, digReq.NO_REQS },
        { xi.item.HEAD_OF_NAPA,            10, digReq.BURROW  },
        { xi.item.BIRD_FEATHER,            10, digReq.NO_REQS },
        { xi.item.EBONY_LOG,               10, digReq.NO_REQS },
        { xi.item.ROSEWOOD_LOG,             5, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,     5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,           100, digReq.NO_REQS },
    },
    [xi.zone.TAHRONGI_CANYON] = -- 117
    {
        { xi.item.BEASTCOIN,                150, digReq.BURROW  },
        { xi.item.BONE_CHIP,                100, digReq.NO_REQS },
        { xi.item.SEASHELL,                 100, digReq.NO_REQS },
        { xi.item.SILVER_BEASTCOIN,         100, digReq.BURROW  },
        { xi.item.HANDFUL_OF_FISH_SCALES,    50, digReq.BORE    },
        { xi.item.GOLD_BEASTCOIN,            50, digReq.BURROW  },
        { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, digReq.BORE    },
        { xi.item.INSECT_WING,               50, digReq.NO_REQS },
        { xi.item.MYTHRIL_BEASTCOIN,         50, digReq.BURROW  },
        { xi.item.PEBBLE,                    50, digReq.NO_REQS },
        { xi.item.CHUNK_OF_TIN_ORE,          50, digReq.NO_REQS },
        { xi.item.TITANICTUS_SHELL,          50, digReq.BORE    },
        { xi.item.TURTLE_SHELL,              50, digReq.BORE    },
        { xi.item.YAGUDO_FEATHER,            50, digReq.NO_REQS },
        { xi.item.DEMON_HORN,                10, digReq.BORE    },
        { xi.item.DEMON_SKULL,               10, digReq.BORE    },
        { xi.item.HANDFUL_OF_DRAGON_SCALES,  10, digReq.BORE    },
        { xi.item.GIANT_FEMUR,               10, digReq.NO_REQS },
        { xi.item.CHUNK_OF_GOLD_ORE,         10, digReq.NO_REQS },
        { xi.item.COIN_OF_ADVANCEMENT,        5, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,       5, digReq.NO_REQS },
        { xi.item.PLATINUM_BEASTCOIN,         5, digReq.BURROW  },
        { xi.item.HANDFUL_OF_WYVERN_SCALES,   5, digReq.BORE    },
        { xi.item.FIRE_CRYSTAL,             100, digReq.NO_REQS },
        { xi.item.CHUNK_OF_FIRE_ORE,         10, digReq.NO_REQS },
    },
    [xi.zone.BUBURIMU_PENINSULA] = -- 118
    {
        { xi.item.BLACK_CHOCOBO_FEATHER,    100, digReq.BURROW  },
        { xi.item.PHOENIX_FEATHER,          100, digReq.BURROW  },
        { xi.item.SEASHELL,                 100, digReq.NO_REQS },
        { xi.item.BIRD_FEATHER,              50, digReq.NO_REQS },
        { xi.item.BONE_CHIP,                 50, digReq.BORE    },
        { xi.item.DEMON_SKULL,               50, digReq.BORE    },
        { xi.item.HANDFUL_OF_FISH_SCALES,    50, digReq.BORE    },
        { xi.item.GIANT_FEMUR,               50, digReq.NO_REQS },
        { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, digReq.BORE    },
        { xi.item.LUGWORM,                   50, digReq.NO_REQS },
        { xi.item.CLUMP_OF_RED_MOKO_GRASS,   50, digReq.BURROW  },
        { xi.item.SHALL_SHELL,               50, digReq.NO_REQS },
        { xi.item.SHELL_BUG,                 50, digReq.NO_REQS },
        { xi.item.SPIDER_WEB,                50, digReq.BURROW  },
        { xi.item.CHUNK_OF_TIN_ORE,          50, digReq.NO_REQS },
        { xi.item.TITANICTUS_SHELL,          50, digReq.BORE    },
        { xi.item.TURTLE_SHELL,              50, digReq.NO_REQS },
        { xi.item.DEMON_HORN,                10, digReq.BORE    },
        { xi.item.HANDFUL_OF_DRAGON_SCALES,  10, digReq.BORE    },
        { xi.item.GIANT_BIRD_PLUME,          10, digReq.BURROW  },
        { xi.item.CHUNK_OF_PLATINUM_ORE,     10, digReq.BORE    },
        { xi.item.ONE_BYNE_BILL,              5, digReq.NO_REQS },
        { xi.item.COIN_OF_BIRTH,              5, digReq.NO_REQS },
        { xi.item.COIN_OF_DECAY,              5, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,       5, digReq.NO_REQS },
        { xi.item.HANDFUL_OF_WYVERN_SCALES,   5, digReq.BORE    },
        { xi.item.FIRE_CRYSTAL,             100, digReq.NO_REQS },
    },
    [xi.zone.MERIPHATAUD_MOUNTAINS] = -- 119
    {
        { xi.item.FLINT_STONE,               240, digReq.NO_REQS },
        { xi.item.CHUNK_OF_SILVER_ORE,       100, digReq.BORE    },
        { xi.item.CHUNK_OF_IRON_ORE,         100, digReq.NO_REQS },
        { xi.item.CHUNK_OF_KOPPARNICKEL_ORE, 100, digReq.BORE    },
        { xi.item.CHUNK_OF_COPPER_ORE,        50, digReq.NO_REQS },
        { xi.item.GIANT_FEMUR,                50, digReq.NO_REQS },
        { xi.item.INSECT_WING,                50, digReq.NO_REQS },
        { xi.item.LIZARD_MOLT,                50, digReq.NO_REQS },
        { xi.item.CHUNK_OF_MYTHRIL_ORE,       50, digReq.BORE    },
        { xi.item.PEBBLE,                     50, digReq.NO_REQS },
        { xi.item.CHUNK_OF_DARKSTEEL_ORE,     10, digReq.BORE    },
        { xi.item.GOLD_BEASTCOIN,             10, digReq.BURROW  },
        { xi.item.CHUNK_OF_ADAMAN_ORE,         5, digReq.BORE    },
        { xi.item.CHUNK_OF_ALUMINUM_ORE,       5, digReq.BORE    },
        { xi.item.COIN_OF_ADVANCEMENT,         5, digReq.NO_REQS },
        { xi.item.CHUNK_OF_GOLD_ORE,           5, digReq.BORE    },
        { xi.item.PLATE_OF_HEAVY_METAL,        5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,              100, digReq.NO_REQS },
        { xi.item.CHUNK_OF_FIRE_ORE,          10, digReq.NO_REQS },
    },
    [xi.zone.SAUROMUGUE_CHAMPAIGN] = -- 120
    {
        { xi.item.BEASTCOIN,                100, digReq.BURROW  },
        { xi.item.SILVER_BEASTCOIN,         100, digReq.BURROW  },
        { xi.item.BONE_CHIP,                100, digReq.NO_REQS },
        { xi.item.HANDFUL_OF_FISH_SCALES,    50, digReq.BORE    },
        { xi.item.FLINT_STONE,               50, digReq.NO_REQS },
        { xi.item.GOLD_BEASTCOIN,            50, digReq.BURROW  },
        { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, digReq.BORE    },
        { xi.item.INSECT_WING,               50, digReq.NO_REQS },
        { xi.item.CHUNK_OF_IRON_ORE,         50, digReq.NO_REQS },
        { xi.item.LIZARD_MOLT,               50, digReq.NO_REQS },
        { xi.item.MYTHRIL_BEASTCOIN,         50, digReq.BURROW  },
        { xi.item.PEBBLE,                    50, digReq.NO_REQS },
        { xi.item.SEASHELL,                  50, digReq.NO_REQS },
        { xi.item.TURTLE_SHELL,              50, digReq.BORE    },
        { xi.item.BLACK_CHOCOBO_FEATHER,     10, digReq.BURROW  },
        { xi.item.DEMON_HORN,                10, digReq.BORE    },
        { xi.item.DEMON_SKULL,               10, digReq.BORE    },
        { xi.item.HANDFUL_OF_DRAGON_SCALES,  10, digReq.BORE    },
        { xi.item.RED_JAR,                   10, digReq.NO_REQS },
        { xi.item.TITANICTUS_SHELL,          10, digReq.BORE    },
        { xi.item.HANDFUL_OF_WYVERN_SCALES,  10, digReq.BORE    },
        { xi.item.COIN_OF_GLORY,              5, digReq.NO_REQS },
        { xi.item.PLATE_OF_HEAVY_METAL,       5, digReq.NO_REQS },
        { xi.item.PLATINUM_BEASTCOIN,         5, digReq.BURROW  },
        { xi.item.FIRE_CRYSTAL,             100, digReq.NO_REQS },
    },
    [xi.zone.THE_SANCTUARY_OF_ZITAH] = -- 121
    {
        { xi.item.SILVER_BEASTCOIN,        150, digReq.BURROW  },
        { xi.item.ARROWWOOD_LOG,           100, digReq.NO_REQS },
        { xi.item.BEASTCOIN,               100, digReq.BURROW  },
        { xi.item.PEBBLE,                  100, digReq.NO_REQS },
        { xi.item.YEW_LOG,                 100, digReq.NO_REQS },
        { xi.item.BONE_CHIP,                50, digReq.NO_REQS },
        { xi.item.ELM_LOG,                  50, digReq.NO_REQS },
        { xi.item.CLUMP_OF_MOKO_GRASS,      50, digReq.NO_REQS },
        { xi.item.MYTHRIL_BEASTCOIN,        50, digReq.BURROW  },
        { xi.item.OAK_LOG,                  50, digReq.BORE    },
        { xi.item.EBONY_LOG,                10, digReq.NO_REQS },
        { xi.item.GOLD_BEASTCOIN,           10, digReq.BURROW  },
        { xi.item.MAHOGANY_LOG,             10, digReq.NO_REQS },
        { xi.item.ROSEWOOD_LOG,             10, digReq.NO_REQS },
        { xi.item.PIECE_OF_ANCIENT_LUMBER,   5, digReq.BORE    },
        { xi.item.COIN_OF_DECAY,             5, digReq.NO_REQS },
        { xi.item.LACQUER_TREE_LOG,          5, digReq.NO_REQS },
        { xi.item.PETRIFIED_LOG,             5, digReq.NO_REQS },
        { xi.item.PLATINUM_BEASTCOIN,        5, digReq.BURROW  },
        { xi.item.FIRE_CRYSTAL,            100, digReq.NO_REQS },
        { xi.item.CHUNK_OF_FIRE_ORE,        10, 0              },
    },
    [xi.zone.YUHTUNGA_JUNGLE] = -- 123
    {
        { xi.item.ARROWWOOD_LOG,           100, digReq.BORE    },
        { xi.item.BONE_CHIP,               100, digReq.NO_REQS },
        { xi.item.DANCESHROOM,             100, digReq.BURROW  },
        { xi.item.WOOZYSHROOM,             100, digReq.BURROW  },
        { xi.item.STICK_OF_CINNAMON,        50, digReq.NO_REQS },
        { xi.item.EBONY_LOG,                50, digReq.BORE    },
        { xi.item.ELM_LOG,                  50, digReq.BORE    },
        { xi.item.PUFFBALL,                 50, digReq.NO_REQS },
        { xi.item.PIECE_OF_RATTAN_LUMBER,   50, digReq.NO_REQS },
        { xi.item.ROSEWOOD_LOG,             50, digReq.BORE    },
        { xi.item.SLEEPSHROOM,              50, digReq.BURROW  },
        { xi.item.YEW_LOG,                  50, digReq.BORE    },
        { xi.item.DEATHBALL,                10, digReq.BURROW  },
        { xi.item.KING_TRUFFLE,             10, digReq.NO_REQS },
        { xi.item.OAK_LOG,                  10, digReq.BORE    },
        { xi.item.PETRIFIED_LOG,            10, digReq.NO_REQS },
        { xi.item.REISHI_MUSHROOM,          10, digReq.BURROW  },
        { xi.item.PIECE_OF_ANCIENT_LUMBER,   5, digReq.BORE    },
        { xi.item.PLATE_OF_HEAVY_METAL,      5, digReq.NO_REQS },
        { xi.item.LACQUER_TREE_LOG,          5, digReq.BORE    },
        { xi.item.MAHOGANY_LOG,              5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,            100, digReq.NO_REQS },
    },
    [xi.zone.YHOATOR_JUNGLE] = -- 124
    {
        { xi.item.ARROWWOOD_LOG,           100, digReq.BORE    },
        { xi.item.BONE_CHIP,               100, digReq.NO_REQS },
        { xi.item.DANCESHROOM,             100, digReq.BURROW  },
        { xi.item.WOOZYSHROOM,             100, digReq.BURROW  },
        { xi.item.DANCESHROOM,              50, digReq.BURROW  },
        { xi.item.DRYAD_ROOT,               50, digReq.NO_REQS },
        { xi.item.EBONY_LOG,                50, digReq.BORE    },
        { xi.item.ELM_LOG,                  50, digReq.BORE    },
        { xi.item.KAZHAM_PINEAPPLE,         50, digReq.NO_REQS },
        { xi.item.LAUAN_LOG,                50, digReq.NO_REQS },
        { xi.item.MAHOGANY_LOG,             50, digReq.NO_REQS },
        { xi.item.OAK_LOG,                  50, digReq.BORE    },
        { xi.item.REISHI_MUSHROOM,          50, digReq.BURROW  },
        { xi.item.ROSEWOOD_LOG,             50, digReq.BORE    },
        { xi.item.YEW_LOG,                  50, digReq.BORE    },
        { xi.item.CORAL_FUNGUS,             10, digReq.NO_REQS },
        { xi.item.PETRIFIED_LOG,            10, digReq.NO_REQS },
        { xi.item.PUFFBALL,                 10, digReq.NO_REQS },
        { xi.item.PIECE_OF_ANCIENT_LUMBER,   5, digReq.BORE    },
        { xi.item.DEATHBALL,                 5, digReq.BURROW  },
        { xi.item.LACQUER_TREE_LOG,          5, digReq.BORE    },
        { xi.item.FIRE_CRYSTAL,            100, digReq.NO_REQS },
    },
    [xi.zone.WESTERN_ALTEPA_DESERT] = -- 125
    {
        { xi.item.BONE_CHIP,                240, digReq.NO_REQS },
        { xi.item.BLACK_CHOCOBO_FEATHER,    100, digReq.BURROW  },
        { xi.item.GIANT_FEMUR,              100, digReq.NO_REQS },
        { xi.item.PHOENIX_FEATHER,          100, digReq.BURROW  },
        { xi.item.CORAL_FRAGMENT,            50, digReq.NO_REQS },
        { xi.item.HANDFUL_OF_FISH_SCALES,    50, digReq.NO_REQS },
        { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, digReq.BORE    },
        { xi.item.CHUNK_OF_IRON_ORE,         50, digReq.NO_REQS },
        { xi.item.PEBBLE,                    50, digReq.NO_REQS },
        { xi.item.CLUMP_OF_RED_MOKO_GRASS,   50, digReq.BURROW  },
        { xi.item.SEASHELL,                  50, digReq.BORE    },
        { xi.item.TURTLE_SHELL,              50, digReq.BORE    },
        { xi.item.CHUNK_OF_ZINC_ORE,         50, digReq.NO_REQS },
        { xi.item.CHUNK_OF_DARKSTEEL_ORE,    10, digReq.BORE    },
        { xi.item.DEMON_HORN,                10, digReq.BORE    },
        { xi.item.DEMON_SKULL,               10, digReq.BORE    },
        { xi.item.HANDFUL_OF_DRAGON_SCALES,  10, digReq.BORE    },
        { xi.item.GIANT_BIRD_PLUME,          10, digReq.NO_REQS },
        { xi.item.CHUNK_OF_GOLD_ORE,         10, digReq.NO_REQS },
        { xi.item.PHILOSOPHERS_STONE,        10, digReq.NO_REQS },
        { xi.item.SPIDER_WEB,                10, digReq.BURROW  },
        { xi.item.TITANICTUS_SHELL,          10, digReq.BORE    },
        { xi.item.HANDFUL_OF_WYVERN_SCALES,  10, digReq.BORE    },
        { xi.item.PLATE_OF_HEAVY_METAL,       5, digReq.NO_REQS },
        { xi.item.FIRE_CRYSTAL,             100, digReq.NO_REQS },
    },
}

local function updatePlayerDigCount(player, increment)
    if increment == 0 then
        player:setVar('[DIG]DigCount', 0)
    else
        player:setVar('[DIG]DigCount', player:getCharVar('[DIG]DigCount') + increment, NextJstDay())
    end

    player:setLocalVar('[DIG]LastDigTime', os.time())
end

--[[ Not Implemented
local function updateZoneDigCount(zoneId, increment)
    local serverVar = '[DIG]ZONE' .. zoneId .. '_ITEMS'

    -- 0 means we wanna wipe (probably only gonna happen onGameDay or something)
    if increment == 0 then
        SetServerVariable(serverVar, 0)
    else
        SetServerVariable(serverVar, GetServerVariable(serverVar) + increment)
    end
end
]]--

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
    local roll = math.random(0, 100)

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

local function getChocoboDiggingItem(player)
    local allItems      = digInfo[player:getZoneID()]
    local burrowAbility = (xi.settings.main.DIG_GRANT_BURROW == 1) and 1 or 0
    local boreAbility   = (xi.settings.main.DIG_GRANT_BORE == 1) and 1 or 0
    local weather       = player:getWeather()
    local moon          = VanadielMoonPhase()

    -- filter allItems to possibleItems and sum weights
    local possibleItems = {}
    local sum           = 0

    for i = 1, #allItems do
        local item = allItems[i]
        local itemReq = item[3]
        if
            (itemReq == digReq.NO_REQS) or
            (itemReq == digReq.BURROW and burrowAbility == 1) or
            (itemReq == digReq.BORE and boreAbility == 1)
        then
            sum = sum + item[2]
            table.insert(possibleItems, item)
        end
    end

    -- pick weighted result
    local itemId = 0
    local pick   = math.random(sum)
    sum          = 0

    for i = 1, #possibleItems do
        sum = sum + possibleItems[i][2]
        if sum >= pick then
            itemId = possibleItems[i][1]
            break
        end
    end

    -- item is a crystal or ore
    if itemId == xi.item.FIRE_CRYSTAL then
        if weather >= xi.weather.HOT_SPELL then
            itemId = crystalMap[weather]
        else
            itemId = 0
        end
    elseif itemId == xi.item.CHUNK_OF_FIRE_ORE then
        if
            weather >= xi.weather.CLOUDS and
            moon >= 10 and
            moon <= 40 and
            player:getSkillRank(xi.skill.DIG) >= 7
        then
            itemId = oreMap[VanadielDayOfTheWeek()]
        else
            itemId = 0
        end
    end

    return itemId
end

xi.chocoboDig.start = function(player)
    -- Handle digging cooldowns.
    if not checkDiggingCooldowns(player) then
        return false -- This means we do not send a digging animation.
    end

    -- Handle AMK mission 7 (index 6) exception.
    local zoneId = player:getZoneID()
    local text   = zones[zoneId].text

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
    local todayDigCount = player:getCharVar('[DIG]DigCount')

    if
        xi.settings.main.DIG_FATIGUE > 0 and
        xi.settings.main.DIG_FATIGUE <= todayDigCount
    then
        player:messageText(player, text.FIND_NOTHING)
        player:setLocalVar('[DIG]LastDigTime', os.time())

        return true
    end

    -- Handle auto-fail from position.
    local currentX = player:getXPos()
    local currentZ = player:getZPos()
    local lastX    = player:getLocalVar('[DIG]LastXPos')
    local lastZ    = player:getLocalVar('[DIG]LastZPos')

    if
        currentX >= lastX - 2 and currentX <= lastX + 2 and -- Check current X axis to see if you are too close to your last X.
        currentZ >= lastZ - 2 and currentZ <= lastZ + 2     -- Check current Z axis to see if you are too close to your last Z.
    then
        player:messageText(player, text.FIND_NOTHING)
        player:setLocalVar('[DIG]LastDigTime', os.time())

        return true
    end

    player:setLocalVar('[DIG]LastXPos', currentX)
    player:setLocalVar('[DIG]LastZPos', currentZ)

    -- Handel actual digging.
    local roll = math.random(0, 100)
    local moon = VanadielMoonPhase()

    -- 40-60% moon phase results in a much lower dig chance than the rest of the phases
    if moon >= 40 and moon <= 60 then
        roll = roll / 2
    end

    -- dig chance failure
    if roll > xi.settings.main.DIGGING_RATE then
        player:messageText(player, text.FIND_NOTHING)
        player:setLocalVar('[DIG]LastDigTime', os.time())

        return true
    end

    -- dig chance success
    local itemId = getChocoboDiggingItem(player)

    -- success!
    if itemId ~= 0 then
        -- make sure we have enough room for the item
        if player:addItem(itemId) then
            player:messageSpecial(text.ITEM_OBTAINED, itemId)
        else
            player:messageSpecial(text.DIG_THROW_AWAY, itemId)
        end

        player:triggerRoeEvent(xi.roeTrigger.CHOCOBO_DIG_SUCCESS)

    -- got a crystal ore, but lacked weather or skill to dig it up
    else
        player:messageText(player, text.FIND_NOTHING, false)
    end

    updatePlayerDigCount(player, 1)
    -- updateZoneDigCount(zoneId, 1) -- TODO: implement mechanic for resetting zone dig count. until then, leave this commented out
    -- TODO: learn abilities from chocobo raising

    calculateSkillUp(player)

    return true
end
