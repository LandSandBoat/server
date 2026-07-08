-----------------------------------
-- Chocobo Digging Data
-----------------------------------
xi = xi or {}
xi.chocoboDig = xi.chocoboDig or {}

-----------------------------------
-- Table for common items without special conditions. [Zone ID] = { itemId, weight, dig requirement }
-- Data from BG wiki: https://www.bg-wiki.com/ffxi/Category:Chocobo_Digging
-----------------------------------
xi.chocoboDig.layer =
{
    TREASURE = 1, -- This layer takes precedence over all others AND no other layer will trigger if we manage to dig something from it.
    REGULAR  = 2, -- Regular layers. Crystals from weather and ores are applied here.
    BURROW   = 3, -- Special "Raised chocobo only" layer. Requires the mounted chocobo to have a concrete skill. It's an independent AND additional item dig.
    BORE     = 4, -- Special "Raised chocobo only" layer. Requires the mounted chocobo to have a concrete skill. It's an independent AND additional item dig.
}

xi.chocoboDig.digInfo =
{
    [xi.zone.CARPENTERS_LANDING] = -- 2
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.KING_TRUFFLE, 5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.LITTLE_WORM,        100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.ARROWWOOD_LOG,      100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ACORN,               50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.WILLOW_LOG,          50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.MAPLE_LOG,           50, xi.craftRank.INITIATE   },
            [6] = { xi.item.HOLLY_LOG,           50, xi.craftRank.INITIATE   },
            [7] = { xi.item.SPRIG_OF_MISTLETOE,  10, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.SCREAM_FUNGUS,       10, xi.craftRank.CRAFTSMAN  },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Crystals
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
        [xi.chocoboDig.layer.BORE] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.BIBIKI_BAY] = -- 4
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_BIRTH,        5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.CHUNK_OF_TIN_ORE,       50, xi.craftRank.AMATEUR  },
            [2] = { xi.item.LUGWORM,                50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.SHELL_BUG,              10, xi.craftRank.RECRUIT  },
            [4] = { xi.item.SEASHELL,              100, xi.craftRank.RECRUIT  },
            [5] = { xi.item.SHALL_SHELL,            50, xi.craftRank.INITIATE },
            [6] = { xi.item.BIRD_FEATHER,           50, xi.craftRank.INITIATE },
            [7] = { xi.item.GIANT_FEMUR,            50, xi.craftRank.INITIATE },
            [8] = { xi.item.CHUNK_OF_PLATINUM_ORE,   5, xi.craftRank.ARTISAN  },
            [9] = { xi.item.CORAL_FRAGMENT,          5, xi.craftRank.ARTISAN  },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Bones
        {
            [ 1] = { xi.item.BONE_CHIP,                 150, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.HANDFUL_OF_FISH_SCALES,    150, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.SEASHELL,                  150, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.HIGH_QUALITY_PUGIL_SCALES,  50, xi.craftRank.INITIATE   },
            [ 5] = { xi.item.TITANICTUS_SHELL,           50, xi.craftRank.APPRENTICE },
            [ 6] = { xi.item.DEMON_HORN,                 10, xi.craftRank.JOURNEYMAN },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,    5, xi.craftRank.CRAFTSMAN  },
            [ 8] = { xi.item.TURTLE_SHELL,                5, xi.craftRank.CRAFTSMAN  },
            [ 9] = { xi.item.DEMON_SKULL,                 1, xi.craftRank.ARTISAN    },
            [10] = { xi.item.HANDFUL_OF_DRAGON_SCALES,    1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.ULEGUERAND_RANGE] = -- 5
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Ores 4
        {
            [1] = { xi.item.CHUNK_OF_SILVER_ORE,       100, xi.craftRank.AMATEUR },
            [2] = { xi.item.CHUNK_OF_IRON_ORE,         100, xi.craftRank.RECRUIT },
            [3] = { xi.item.CHUNK_OF_KOPPARNICKEL_ORE, 100, xi.craftRank.RECRUIT },
            [4] = { xi.item.CHUNK_OF_MYTHRIL_ORE,      100, xi.craftRank.RECRUIT },
            [5] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,     10, xi.craftRank.NOVICE  },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
    },

    [xi.zone.ATTOHWA_CHASM] = -- 7
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Ores 4
        {
            [1] = { xi.item.CHUNK_OF_SILVER_ORE,       100, xi.craftRank.AMATEUR },
            [2] = { xi.item.CHUNK_OF_IRON_ORE,         100, xi.craftRank.RECRUIT },
            [3] = { xi.item.CHUNK_OF_KOPPARNICKEL_ORE, 100, xi.craftRank.RECRUIT },
            [4] = { xi.item.CHUNK_OF_MYTHRIL_ORE,      100, xi.craftRank.RECRUIT },
            [5] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,     10, xi.craftRank.NOVICE  },
        },
    },

    [xi.zone.LUFAISE_MEADOWS] = -- 24
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Crystals
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
    },

    [xi.zone.MISAREAUX_COAST] = -- 25
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
        [xi.chocoboDig.layer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.WAJAOM_WOODLANDS] = -- 51
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.ALEXANDRITE, 5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,                100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CLUMP_OF_MOKO_GRASS,   100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.HANDFUL_OF_PINE_NUTS,   50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.BLACK_CHOCOBO_FEATHER,  50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.EBONY_LOG,              50, xi.craftRank.INITIATE   },
            [6] = { xi.item.SPIDER_WEB,             10, xi.craftRank.NOVICE     },
            [7] = { xi.item.PEPHREDO_HIVE_CHIP,     10, xi.craftRank.APPRENTICE },
            [8] = { xi.item.CHUNK_OF_ADAMAN_ORE,    10, xi.craftRank.CRAFTSMAN  },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Logs 2
        {
            [ 1] = { xi.item.CLUMP_OF_MOKO_GRASS,     240, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.PEPHREDO_HIVE_CHIP,      150, xi.craftRank.AMATEUR    },
            [ 4] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [ 5] = { xi.item.BLACK_CHOCOBO_FEATHER,   100, xi.craftRank.RECRUIT    },
            [ 6] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [ 7] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [ 8] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [ 9] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [10] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [11] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [12] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Ores 2
        {
            [1] = { xi.item.FLINT_STONE,             240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,   100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,        50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,   10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_KAOLIN,          10, xi.craftRank.NOVICE     },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,     5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.BHAFLAU_THICKETS] = -- 52
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.ALEXANDRITE, 5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,                  100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.FLINT_STONE,             100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.HANDFUL_OF_PINE_NUTS,     50, xi.craftRank.AMATEUR    },
            [4] = { xi.item.PINCH_OF_DRIED_MARJORAM,  50, xi.craftRank.AMATEUR    },
            [6] = { xi.item.COLIBRI_FEATHER,          50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.LESSER_CHIGOE,            10, xi.craftRank.INITIATE   },
            [8] = { xi.item.PETRIFIED_LOG,            50, xi.craftRank.NOVICE     },
            [7] = { xi.item.SPIDER_WEB,               10, xi.craftRank.APPRENTICE },
            [9] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   5, xi.craftRank.ARTISAN    },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Logs 2
        {
            [ 1] = { xi.item.CLUMP_OF_MOKO_GRASS,     240, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.PEPHREDO_HIVE_CHIP,      150, xi.craftRank.AMATEUR    },
            [ 4] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [ 5] = { xi.item.BLACK_CHOCOBO_FEATHER,   100, xi.craftRank.RECRUIT    },
            [ 6] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [ 7] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [ 8] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [ 9] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [10] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [11] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [12] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Ores 2
        {
            [1] = { xi.item.FLINT_STONE,             240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,   100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,        50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,   10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_KAOLIN,          10, xi.craftRank.NOVICE     },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,     5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.CAEDARVA_MIRE] = -- 79
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Logs 3
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.DOGWOOD_LOG,             240, xi.craftRank.AMATEUR    },
            [3] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [4] = { xi.item.LANCEWOOD_LOG,           100, xi.craftRank.RECRUIT    },
            [5] = { xi.item.SPRIG_OF_MISTLETOE,       50, xi.craftRank.INITIATE   },
            [6] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Ores 2
        {
            [1] = { xi.item.FLINT_STONE,             240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,   100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,        50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,   10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_KAOLIN,          10, xi.craftRank.NOVICE     },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,     5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.EAST_RONFAURE_S] = -- 81
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Logs 4
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR   },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR   },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT   },
            [4] = { xi.item.FEYWEALD_LOG,             50, xi.craftRank.INITIATE  },
            [5] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE  },
            [6] = { xi.item.TEAK_LOG,                  1, xi.craftRank.CRAFTSMAN },
            [7] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN },
            [8] = { xi.item.JACARANDA_LOG,             1, xi.craftRank.ARTISAN   },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN   },
        },
    },

    [xi.zone.JUGNER_FOREST_S] = -- 82
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Shrooms
        {
            [1] = { xi.item.DEATHBALL,       100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SLEEPSHROOM,     100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CORAL_FUNGUS,     50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.WOOZYSHROOM,      10, xi.craftRank.INITIATE   },
            [5] = { xi.item.PUFFBALL,         10, xi.craftRank.NOVICE     },
            [6] = { xi.item.DANCESHROOM,       5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.REISHI_MUSHROOM,   1, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.KING_TRUFFLE,      1, xi.craftRank.CRAFTSMAN  },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Logs 4
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR   },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR   },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT   },
            [4] = { xi.item.FEYWEALD_LOG,             50, xi.craftRank.INITIATE  },
            [5] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE  },
            [6] = { xi.item.TEAK_LOG,                  1, xi.craftRank.CRAFTSMAN },
            [7] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN },
            [8] = { xi.item.JACARANDA_LOG,             1, xi.craftRank.ARTISAN   },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN   },
        },
    },

    [xi.zone.VUNKERL_INLET_S] = -- 83
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
    },

    [xi.zone.BATALLIA_DOWNS_S] = -- 84
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Ores 3
        {
            [1] = { xi.item.FLINT_STONE,               240, xi.craftRank.AMATEUR },
            [2] = { xi.item.CHUNK_OF_SILVER_ORE,       100, xi.craftRank.AMATEUR },
            [3] = { xi.item.CHUNK_OF_IRON_ORE,         100, xi.craftRank.RECRUIT },
            [4] = { xi.item.SHARD_OF_OBSIDIAN,         100, xi.craftRank.RECRUIT },
            [5] = { xi.item.CHUNK_OF_KOPPARNICKEL_ORE, 100, xi.craftRank.RECRUIT },
            [6] = { xi.item.CHUNK_OF_MYTHRIL_ORE,      100, xi.craftRank.RECRUIT },
            [7] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,     10, xi.craftRank.NOVICE  },
            [8] = { xi.item.CHUNK_OF_SWAMP_ORE,         10, xi.craftRank.NOVICE  },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
    },

    [xi.zone.NORTH_GUSTABERG_S] = -- 88
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Ores 3
        {
            [1] = { xi.item.FLINT_STONE,               240, xi.craftRank.AMATEUR },
            [2] = { xi.item.CHUNK_OF_SILVER_ORE,       100, xi.craftRank.AMATEUR },
            [3] = { xi.item.CHUNK_OF_IRON_ORE,         100, xi.craftRank.RECRUIT },
            [4] = { xi.item.SHARD_OF_OBSIDIAN,         100, xi.craftRank.RECRUIT },
            [5] = { xi.item.CHUNK_OF_KOPPARNICKEL_ORE, 100, xi.craftRank.RECRUIT },
            [6] = { xi.item.CHUNK_OF_MYTHRIL_ORE,      100, xi.craftRank.RECRUIT },
            [7] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,     10, xi.craftRank.NOVICE  },
            [8] = { xi.item.CHUNK_OF_SWAMP_ORE,         10, xi.craftRank.NOVICE  },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
    },

    [xi.zone.GRAUBERG_S] = -- 89
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Logs 4
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR   },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR   },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT   },
            [4] = { xi.item.FEYWEALD_LOG,             50, xi.craftRank.INITIATE  },
            [5] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE  },
            [6] = { xi.item.TEAK_LOG,                  1, xi.craftRank.CRAFTSMAN },
            [7] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN },
            [8] = { xi.item.JACARANDA_LOG,             1, xi.craftRank.ARTISAN   },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN   },
        },
    },

    [xi.zone.PASHHOW_MARSHLANDS_S] = -- 90
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Crystals
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
    },

    [xi.zone.ROLANBERRY_FIELDS_S] = -- 91
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set:Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Shrooms
        {
            [1] = { xi.item.DEATHBALL,       100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SLEEPSHROOM,     100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CORAL_FUNGUS,     50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.WOOZYSHROOM,      10, xi.craftRank.INITIATE   },
            [5] = { xi.item.PUFFBALL,         10, xi.craftRank.NOVICE     },
            [6] = { xi.item.DANCESHROOM,       5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.REISHI_MUSHROOM,   1, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.KING_TRUFFLE,      1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.WEST_SARUTABARUTA_S] = -- 95
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Crystals
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
    },

    [xi.zone.FORT_KARUGO_NARUGO_S] = -- 96
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Ores 1
        {
            [1] = { xi.item.FLINT_STONE,            240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,  100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,       50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,  10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_ADAMAN_ORE,      5, xi.craftRank.JOURNEYMAN },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,    5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,  1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.MERIPHATAUD_MOUNTAINS_S] = -- 97
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Bones
        {
            [ 1] = { xi.item.BONE_CHIP,                 150, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.HANDFUL_OF_FISH_SCALES,    150, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.SEASHELL,                  150, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.HIGH_QUALITY_PUGIL_SCALES,  50, xi.craftRank.INITIATE   },
            [ 5] = { xi.item.TITANICTUS_SHELL,           50, xi.craftRank.APPRENTICE },
            [ 6] = { xi.item.DEMON_HORN,                 10, xi.craftRank.JOURNEYMAN },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,    5, xi.craftRank.CRAFTSMAN  },
            [ 8] = { xi.item.TURTLE_SHELL,                5, xi.craftRank.CRAFTSMAN  },
            [ 9] = { xi.item.DEMON_SKULL,                 1, xi.craftRank.ARTISAN    },
            [10] = { xi.item.HANDFUL_OF_DRAGON_SCALES,    1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.SAUROMUGUE_CHAMPAIGN_S] = -- 98
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Logs 4
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR   },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR   },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT   },
            [4] = { xi.item.FEYWEALD_LOG,             50, xi.craftRank.INITIATE  },
            [5] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE  },
            [6] = { xi.item.TEAK_LOG,                  1, xi.craftRank.CRAFTSMAN },
            [7] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN },
            [8] = { xi.item.JACARANDA_LOG,             1, xi.craftRank.ARTISAN   },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN   },
        },
    },

    [xi.zone.WEST_RONFAURE] = -- 100
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [ 1] = { xi.item.LITTLE_WORM,            50, xi.craftRank.AMATEUR  },
            [ 2] = { xi.item.ACORN,                  50, xi.craftRank.AMATEUR  },
            [ 3] = { xi.item.CLUMP_OF_MOKO_GRASS,    50, xi.craftRank.RECRUIT  },
            [ 4] = { xi.item.ARROWWOOD_LOG,          50, xi.craftRank.AMATEUR  },
            [ 5] = { xi.item.MAPLE_LOG,              50, xi.craftRank.RECRUIT  },
            [ 6] = { xi.item.ASH_LOG,                50, xi.craftRank.RECRUIT  },
            [ 7] = { xi.item.CHESTNUT_LOG,           10, xi.craftRank.INITIATE },
            [ 8] = { xi.item.CHOCOBO_FEATHER,        50, xi.craftRank.INITIATE },
            [ 9] = { xi.item.BAG_OF_VEGETABLE_SEEDS, 10, xi.craftRank.NOVICE   },
            [10] = { xi.item.RONFAURE_CHESTNUT,      10, xi.craftRank.NOVICE   },
            [11] = { xi.item.SPRIG_OF_MISTLETOE,     10, xi.craftRank.NOVICE   },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Crystals
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
    },

    [xi.zone.EAST_RONFAURE] = -- 101
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [ 1] = { xi.item.LITTLE_WORM,        50, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.ACORN,              50, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.ARROWWOOD_LOG,      50, xi.craftRank.AMATEUR    },
            [ 4] = { xi.item.MAPLE_LOG,          50, xi.craftRank.RECRUIT    },
            [ 5] = { xi.item.ASH_LOG,            50, xi.craftRank.RECRUIT    },
            [ 6] = { xi.item.CHESTNUT_LOG,       10, xi.craftRank.INITIATE   },
            [ 7] = { xi.item.BAG_OF_FRUIT_SEEDS, 10, xi.craftRank.INITIATE   },
            [ 8] = { xi.item.RONFAURE_CHESTNUT,  10, xi.craftRank.NOVICE     },
            [ 9] = { xi.item.CHOCOBO_FEATHER,    50, xi.craftRank.NOVICE     },
            [10] = { xi.item.SPRIG_OF_MISTLETOE, 10, xi.craftRank.APPRENTICE },
            [11] = { xi.item.KING_TRUFFLE,       10, xi.craftRank.ARTISAN    },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Crystals
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
    },

    [xi.zone.LA_THEINE_PLATEAU] = -- 102
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_GLORY,        5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [ 1] = { xi.item.PEBBLE,                  50, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.LITTLE_WORM,             50, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.CHOCOBO_FEATHER,         50, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.CHUNK_OF_TIN_ORE,        50, xi.craftRank.AMATEUR    },
            [ 5] = { xi.item.CHUNK_OF_ZINC_ORE,       50, xi.craftRank.RECRUIT    },
            [ 6] = { xi.item.ARROWWOOD_LOG,           50, xi.craftRank.AMATEUR    },
            [ 7] = { xi.item.YEW_LOG,                 50, xi.craftRank.RECRUIT    },
            [ 8] = { xi.item.CHESTNUT_LOG,            10, xi.craftRank.INITIATE   },
            [ 9] = { xi.item.MAHOGANY_LOG,            10, xi.craftRank.NOVICE     },
            [10] = { xi.item.PINCH_OF_DRIED_MARJORAM, 10, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
    },

    [xi.zone.VALKURM_DUNES] = -- 103
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.COIN_OF_DECAY,       5, xi.craftRank.ADEPT },
            [2] = { xi.item.ORDELLE_BRONZEPIECE, 5, xi.craftRank.ADEPT },
            [3] = { xi.item.ONE_BYNE_BILL,       5, xi.craftRank.ADEPT },
            [4] = { xi.item.TUKUKU_WHITESHELL,   5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.LUGWORM,                 50, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BONE_CHIP,              100, xi.craftRank.AMATEUR   },
            [3] = { xi.item.HANDFUL_OF_FISH_SCALES,  50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.SEASHELL,               150, xi.craftRank.RECRUIT   },
            [5] = { xi.item.GIANT_FEMUR,             50, xi.craftRank.NOVICE    },
            [6] = { xi.item.SHELL_BUG,               50, xi.craftRank.INITIATE  },
            [7] = { xi.item.LIZARD_MOLT,             50, xi.craftRank.NOVICE    },
            [8] = { xi.item.SHALL_SHELL,             50, xi.craftRank.CRAFTSMAN },
            [9] = { xi.item.TURTLE_SHELL,            50, xi.craftRank.ARTISAN   },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Bones
        {
            [ 1] = { xi.item.BONE_CHIP,                 150, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.HANDFUL_OF_FISH_SCALES,    150, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.SEASHELL,                  150, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.HIGH_QUALITY_PUGIL_SCALES,  50, xi.craftRank.INITIATE   },
            [ 5] = { xi.item.TITANICTUS_SHELL,           50, xi.craftRank.APPRENTICE },
            [ 6] = { xi.item.DEMON_HORN,                 10, xi.craftRank.JOURNEYMAN },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,    5, xi.craftRank.CRAFTSMAN  },
            [ 8] = { xi.item.TURTLE_SHELL,                5, xi.craftRank.CRAFTSMAN  },
            [ 9] = { xi.item.DEMON_SKULL,                 1, xi.craftRank.ARTISAN    },
            [10] = { xi.item.HANDFUL_OF_DRAGON_SCALES,    1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.JUGNER_FOREST] = -- 104
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_BIRTH,        5, xi.craftRank.ADEPT },
            [3] = { xi.item.KING_TRUFFLE,         5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.LITTLE_WORM,        50, xi.craftRank.AMATEUR   },
            [2] = { xi.item.ACORN,              50, xi.craftRank.AMATEUR   },
            [3] = { xi.item.MAPLE_LOG,          50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.WILLOW_LOG,         50, xi.craftRank.RECRUIT   },
            [5] = { xi.item.HOLLY_LOG,          50, xi.craftRank.NOVICE    },
            [6] = { xi.item.OAK_LOG,            50, xi.craftRank.INITIATE  },
            [7] = { xi.item.SPRIG_OF_MISTLETOE, 10, xi.craftRank.NOVICE    },
            [8] = { xi.item.SCREAM_FUNGUS,       5, xi.craftRank.CRAFTSMAN },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Crystals
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
        [xi.chocoboDig.layer.BORE] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.BATALLIA_DOWNS] = -- 105
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_ADVANCEMENT,  5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,                50, xi.craftRank.AMATEUR    },
            [2] = { xi.item.FLINT_STONE,           50, xi.craftRank.AMATEUR    },
            [3] = { xi.item.BONE_CHIP,             50, xi.craftRank.AMATEUR    },
            [4] = { xi.item.CHUNK_OF_COPPER_ORE,   50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.BIRD_FEATHER,          50, xi.craftRank.RECRUIT    },
            [6] = { xi.item.CHUNK_OF_IRON_ORE,     50, xi.craftRank.INITIATE   },
            [7] = { xi.item.RED_JAR,               50, xi.craftRank.NOVICE     },
            [8] = { xi.item.BLACK_CHOCOBO_FEATHER,  5, xi.craftRank.APPRENTICE },
            [9] = { xi.item.REISHI_MUSHROOM,        5, xi.craftRank.JOURNEYMAN },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
    },

    [xi.zone.NORTH_GUSTABERG] = -- 106
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_GLORY,        5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [ 1] = { xi.item.PEBBLE,                 50, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.LITTLE_WORM,            50, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.BONE_CHIP,              50, xi.craftRank.AMATEUR    },
            [ 4] = { xi.item.BIRD_FEATHER,           50, xi.craftRank.AMATEUR    },
            [ 5] = { xi.item.HANDFUL_OF_FISH_SCALES, 50, xi.craftRank.AMATEUR    },
            [ 6] = { xi.item.INSECT_WING,            50, xi.craftRank.AMATEUR    },
            [ 7] = { xi.item.BAG_OF_CACTUS_STEMS,    10, xi.craftRank.RECRUIT    },
            [ 8] = { xi.item.LIZARD_MOLT,            50, xi.craftRank.RECRUIT    },
            [ 9] = { xi.item.MYTHRIL_BEASTCOIN,      10, xi.craftRank.APPRENTICE },
            [10] = { xi.item.CHUNK_OF_MYTHRIL_ORE,   10, xi.craftRank.APPRENTICE },
            [11] = { xi.item.CHUNK_OF_DARKSTEEL_ORE, 10, xi.craftRank.ARTISAN    },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Crystals
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
    },

    [xi.zone.SOUTH_GUSTABERG] = -- 107
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_DECAY,        5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [ 1] = { xi.item.PEBBLE,               50, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.LITTLE_WORM,          50, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.BONE_CHIP,            50, xi.craftRank.AMATEUR    },
            [ 4] = { xi.item.BIRD_FEATHER,         50, xi.craftRank.AMATEUR    },
            [ 5] = { xi.item.CHUNK_OF_ROCK_SALT,   50, xi.craftRank.AMATEUR    },
            [ 6] = { xi.item.INSECT_WING,          50, xi.craftRank.AMATEUR    },
            [ 7] = { xi.item.BAG_OF_GRAIN_SEEDS,   50, xi.craftRank.RECRUIT    },
            [ 8] = { xi.item.LIZARD_MOLT,          50, xi.craftRank.RECRUIT    },
            [ 9] = { xi.item.MYTHRIL_BEASTCOIN,    50, xi.craftRank.APPRENTICE },
            [10] = { xi.item.CHUNK_OF_MYTHRIL_ORE, 10, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Crystals
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
    },

    [xi.zone.KONSCHTAT_HIGHLANDS] = -- 108
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_BIRTH,        5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,                 50, xi.craftRank.AMATEUR    },
            [2] = { xi.item.FLINT_STONE,            50, xi.craftRank.AMATEUR    },
            [3] = { xi.item.BONE_CHIP,              50, xi.craftRank.AMATEUR    },
            [4] = { xi.item.HANDFUL_OF_FISH_SCALES, 50, xi.craftRank.AMATEUR    },
            [5] = { xi.item.CHUNK_OF_ZINC_ORE,      50, xi.craftRank.AMATEUR    },
            [6] = { xi.item.BIRD_FEATHER,           10, xi.craftRank.RECRUIT    },
            [7] = { xi.item.LIZARD_MOLT,            50, xi.craftRank.RECRUIT    },
            [8] = { xi.item.MYTHRIL_BEASTCOIN,       5, xi.craftRank.APPRENTICE },
            [9] = { xi.item.ELM_LOG,                 5, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Crystals
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
        [xi.chocoboDig.layer.BORE] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
    },

    [xi.zone.PASHHOW_MARSHLANDS] = -- 109
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_ADVANCEMENT,  5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,              50, xi.craftRank.AMATEUR    },
            [2] = { xi.item.INSECT_WING,         50, xi.craftRank.AMATEUR    },
            [3] = { xi.item.LIZARD_MOLT,         50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.CHUNK_OF_SILVER_ORE, 50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.MYTHRIL_BEASTCOIN,   10, xi.craftRank.INITIATE   },
            [6] = { xi.item.TURTLE_SHELL,        10, xi.craftRank.INITIATE   },
            [7] = { xi.item.WILLOW_LOG,          10, xi.craftRank.INITIATE   },
            [8] = { xi.item.PETRIFIED_LOG,        5, xi.craftRank.NOVICE     },
            [9] = { xi.item.PUFFBALL,             5, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Crystals
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
    },

    [xi.zone.ROLANBERRY_FIELDS] = -- 110
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_GLORY,        5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,                  100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.LITTLE_WORM,             100, xi.craftRank.AMATEUR   },
            [3] = { xi.item.FLINT_STONE,             100, xi.craftRank.AMATEUR   },
            [4] = { xi.item.INSECT_WING,              50, xi.craftRank.RECRUIT   },
            [5] = { xi.item.MYTHRIL_BEASTCOIN,        10, xi.craftRank.INITIATE  },
            [6] = { xi.item.SPRIG_OF_SAGE,            10, xi.craftRank.INITIATE  },
            [7] = { xi.item.RED_JAR,                  10, xi.craftRank.NOVICE    },
            [8] = { xi.item.GOLD_BEASTCOIN,            5, xi.craftRank.CRAFTSMAN },
            [9] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   5, xi.craftRank.CRAFTSMAN },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Shrooms
        {
            [1] = { xi.item.DEATHBALL,       100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SLEEPSHROOM,     100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CORAL_FUNGUS,     50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.WOOZYSHROOM,      10, xi.craftRank.INITIATE   },
            [5] = { xi.item.PUFFBALL,         10, xi.craftRank.NOVICE     },
            [6] = { xi.item.DANCESHROOM,       5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.REISHI_MUSHROOM,   1, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.KING_TRUFFLE,      1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.BEAUCEDINE_GLACIER] = -- 111
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.XARCABARD] = -- 112
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.CAPE_TERIGGAN] = -- 113
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.EASTERN_ALTEPA_DESERT] = -- 114
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [ 1] = { xi.item.FLINT_STONE,              240, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.BONE_CHIP,                100, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.PEBBLE,                    50, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.CHUNK_OF_ZINC_ORE,         50, xi.craftRank.RECRUIT    },
            [ 5] = { xi.item.CHUNK_OF_SILVER_ORE,       50, xi.craftRank.INITIATE   },
            [ 6] = { xi.item.GIANT_FEMUR,               50, xi.craftRank.NOVICE     },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,  50, xi.craftRank.APPRENTICE },
            [ 8] = { xi.item.CHUNK_OF_MYTHRIL_ORE,      10, xi.craftRank.JOURNEYMAN },
            [ 9] = { xi.item.CHUNK_OF_PLATINUM_ORE,     10, xi.craftRank.JOURNEYMAN },
            [10] = { xi.item.PHILOSOPHERS_STONE,         5, xi.craftRank.CRAFTSMAN  },
        },
        [xi.chocoboDig.layer.BURROW] =
        {
            [1] = { xi.item.BAG_OF_GRAIN_SEEDS,     50, xi.craftRank.AMATEUR    },
            [2] = { xi.item.BAG_OF_VEGETABLE_SEEDS, 50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.BAG_OF_HERB_SEEDS,      50, xi.craftRank.INITIATE   },
            [4] = { xi.item.BAG_OF_WILDGRASS_SEEDS, 50, xi.craftRank.NOVICE     },
            [5] = { xi.item.BAG_OF_FRUIT_SEEDS,     50, xi.craftRank.APPRENTICE },
            [6] = { xi.item.BAG_OF_TREE_CUTTINGS,   10, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.BAG_OF_CACTUS_STEMS,    10, xi.craftRank.CRAFTSMAN  },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Ores 1
        {
            [1] = { xi.item.FLINT_STONE,             240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,   100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,        50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,   10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_ADAMAN_ORE,       5, xi.craftRank.JOURNEYMAN },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,     5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.WEST_SARUTABARUTA] = -- 115
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_DECAY,        5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,                50, xi.craftRank.AMATEUR  },
            [2] = { xi.item.LITTLE_WORM,           50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.CLUMP_OF_MOKO_GRASS,   50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.LAUAN_LOG,             50, xi.craftRank.RECRUIT  },
            [5] = { xi.item.INSECT_WING,           50, xi.craftRank.RECRUIT  },
            [6] = { xi.item.YAGUDO_FEATHER,        50, xi.craftRank.INITIATE },
            [7] = { xi.item.BIRD_FEATHER,          10, xi.craftRank.INITIATE },
            [8] = { xi.item.BALL_OF_SARUTA_COTTON, 10, xi.craftRank.INITIATE },
            [9] = { xi.item.ROSEWOOD_LOG,           5, xi.craftRank.NOVICE   },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Crystals
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
    },

    [xi.zone.EAST_SARUTABARUTA] = -- 116
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [ 1] = { xi.item.PEBBLE,                50, xi.craftRank.AMATEUR  },
            [ 2] = { xi.item.PAPAKA_GRASS,          50, xi.craftRank.AMATEUR  },
            [ 3] = { xi.item.LAUAN_LOG,             50, xi.craftRank.AMATEUR  },
            [ 4] = { xi.item.INSECT_WING,           50, xi.craftRank.RECRUIT  },
            [ 5] = { xi.item.YAGUDO_FEATHER,        50, xi.craftRank.RECRUIT  },
            [ 6] = { xi.item.BALL_OF_SARUTA_COTTON, 50, xi.craftRank.RECRUIT  },
            [ 7] = { xi.item.BAG_OF_HERB_SEEDS,     50, xi.craftRank.INITIATE },
            [ 8] = { xi.item.BIRD_FEATHER,          10, xi.craftRank.INITIATE },
            [ 9] = { xi.item.EBONY_LOG,             10, xi.craftRank.INITIATE },
            [10] = { xi.item.ROSEWOOD_LOG,           5, xi.craftRank.NOVICE   },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Crystals
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
    },

    [xi.zone.TAHRONGI_CANYON] = -- 117
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_ADVANCEMENT,  5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,            50, xi.craftRank.AMATEUR    },
            [2] = { xi.item.BONE_CHIP,         50, xi.craftRank.AMATEUR    },
            [3] = { xi.item.SEASHELL,          50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.CHUNK_OF_TIN_ORE,  50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.GIANT_FEMUR,       50, xi.craftRank.INITIATE   },
            [6] = { xi.item.INSECT_WING,       50, xi.craftRank.INITIATE   },
            [7] = { xi.item.YAGUDO_FEATHER,    50, xi.craftRank.NOVICE     },
            [8] = { xi.item.GOLD_BEASTCOIN,    10, xi.craftRank.APPRENTICE },
            [9] = { xi.item.CHUNK_OF_GOLD_ORE, 10, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Bones
        {
            [ 1] = { xi.item.BONE_CHIP,                 150, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.HANDFUL_OF_FISH_SCALES,    150, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.SEASHELL,                  150, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.HIGH_QUALITY_PUGIL_SCALES,  50, xi.craftRank.INITIATE   },
            [ 5] = { xi.item.TITANICTUS_SHELL,           50, xi.craftRank.APPRENTICE },
            [ 6] = { xi.item.DEMON_HORN,                 10, xi.craftRank.JOURNEYMAN },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,    5, xi.craftRank.CRAFTSMAN  },
            [ 8] = { xi.item.TURTLE_SHELL,                5, xi.craftRank.CRAFTSMAN  },
            [ 9] = { xi.item.DEMON_SKULL,                 1, xi.craftRank.ARTISAN    },
            [10] = { xi.item.HANDFUL_OF_DRAGON_SCALES,    1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.BUBURIMU_PENINSULA] = -- 118
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_BIRTH,        5, xi.craftRank.ADEPT },
            [3] = { xi.item.ORDELLE_BRONZEPIECE,  5, xi.craftRank.ADEPT },
            [4] = { xi.item.ONE_BYNE_BILL,        5, xi.craftRank.ADEPT },
            [5] = { xi.item.TUKUKU_WHITESHELL,    5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.LUGWORM,               100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SHELL_BUG,             100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.SEASHELL,              100, xi.craftRank.AMATEUR    },
            [4] = { xi.item.SHALL_SHELL,            50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.BIRD_FEATHER,           50, xi.craftRank.RECRUIT    },
            [6] = { xi.item.CHUNK_OF_TIN_ORE,       10, xi.craftRank.INITIATE   },
            [7] = { xi.item.GIANT_FEMUR,            10, xi.craftRank.INITIATE   },
            [8] = { xi.item.CHUNK_OF_PLATINUM_ORE,   5, xi.craftRank.APPRENTICE },
            [9] = { xi.item.CORAL_FRAGMENT,          5, xi.craftRank.CRAFTSMAN  },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Bones
        {
            [ 1] = { xi.item.BONE_CHIP,                 150, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.HANDFUL_OF_FISH_SCALES,    150, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.SEASHELL,                  150, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.HIGH_QUALITY_PUGIL_SCALES,  50, xi.craftRank.INITIATE   },
            [ 5] = { xi.item.TITANICTUS_SHELL,           50, xi.craftRank.APPRENTICE },
            [ 6] = { xi.item.DEMON_HORN,                 10, xi.craftRank.JOURNEYMAN },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,    5, xi.craftRank.CRAFTSMAN  },
            [ 8] = { xi.item.TURTLE_SHELL,                5, xi.craftRank.CRAFTSMAN  },
            [ 9] = { xi.item.DEMON_SKULL,                 1, xi.craftRank.ARTISAN    },
            [10] = { xi.item.HANDFUL_OF_DRAGON_SCALES,    1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.MERIPHATAUD_MOUNTAINS] = -- 119
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_ADVANCEMENT,  5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.FLINT_STONE,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.PEBBLE,                100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CHUNK_OF_COPPER_ORE,    50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.GIANT_FEMUR,            50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.LIZARD_MOLT,            50, xi.craftRank.INITIATE   },
            [6] = { xi.item.BLACK_CHOCOBO_FEATHER,  10, xi.craftRank.NOVICE     },
            [7] = { xi.item.GOLD_BEASTCOIN,         10, xi.craftRank.APPRENTICE },
            [8] = { xi.item.CHUNK_OF_ADAMAN_ORE,     5, xi.craftRank.JOURNEYMAN },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Ores 4
        {
            [1] = { xi.item.CHUNK_OF_SILVER_ORE,       100, xi.craftRank.AMATEUR },
            [2] = { xi.item.CHUNK_OF_IRON_ORE,         100, xi.craftRank.RECRUIT },
            [3] = { xi.item.CHUNK_OF_KOPPARNICKEL_ORE, 100, xi.craftRank.RECRUIT },
            [4] = { xi.item.CHUNK_OF_MYTHRIL_ORE,      100, xi.craftRank.RECRUIT },
            [5] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,     10, xi.craftRank.NOVICE  },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Ores 1
        {
            [1] = { xi.item.FLINT_STONE,             240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,   100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,        50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,   10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_ADAMAN_ORE,       5, xi.craftRank.JOURNEYMAN },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,     5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.SAUROMUGUE_CHAMPAIGN] = -- 120
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_GLORY,        5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.FLINT_STONE,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.PEBBLE,                100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.BONE_CHIP,             100, xi.craftRank.AMATEUR    },
            [4] = { xi.item.INSECT_WING,            50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.LIZARD_MOLT,            50, xi.craftRank.RECRUIT    },
            [6] = { xi.item.CHUNK_OF_IRON_ORE,      50, xi.craftRank.INITIATE   },
            [7] = { xi.item.BLACK_CHOCOBO_FEATHER,  10, xi.craftRank.NOVICE     },
            [8] = { xi.item.RED_JAR,                10, xi.craftRank.NOVICE     },
            [9] = { xi.item.GOLD_BEASTCOIN,          5, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Bones
        {
            [ 1] = { xi.item.BONE_CHIP,                 150, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.HANDFUL_OF_FISH_SCALES,    150, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.SEASHELL,                  150, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.HIGH_QUALITY_PUGIL_SCALES,  50, xi.craftRank.INITIATE   },
            [ 5] = { xi.item.TITANICTUS_SHELL,           50, xi.craftRank.APPRENTICE },
            [ 6] = { xi.item.DEMON_HORN,                 10, xi.craftRank.JOURNEYMAN },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,    5, xi.craftRank.CRAFTSMAN  },
            [ 8] = { xi.item.TURTLE_SHELL,                5, xi.craftRank.CRAFTSMAN  },
            [ 9] = { xi.item.DEMON_SKULL,                 1, xi.craftRank.ARTISAN    },
            [10] = { xi.item.HANDFUL_OF_DRAGON_SCALES,    1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.THE_SANCTUARY_OF_ZITAH] = -- 121
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_DECAY,        5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,              100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CLUMP_OF_MOKO_GRASS, 100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.BONE_CHIP,           100, xi.craftRank.AMATEUR    },
            [4] = { xi.item.ARROWWOOD_LOG,        50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.YEW_LOG,              50, xi.craftRank.RECRUIT    },
            [6] = { xi.item.ELM_LOG,              50, xi.craftRank.INITIATE   },
            [7] = { xi.item.KING_TRUFFLE,          5, xi.craftRank.NOVICE     },
            [8] = { xi.item.PETRIFIED_LOG,         5, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.YUHTUNGA_JUNGLE] = -- 123
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.BONE_CHIP,              100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.DANCESHROOM,            100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.STICK_OF_CINNAMON,       50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.PIECE_OF_RATTAN_LUMBER,  50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.ROSEWOOD_LOG,            50, xi.craftRank.INITIATE   },
            [6] = { xi.item.PUFFBALL,                50, xi.craftRank.INITIATE   },
            [7] = { xi.item.PETRIFIED_LOG,           10, xi.craftRank.NOVICE     },
            [8] = { xi.item.KING_TRUFFLE,            10, xi.craftRank.NOVICE     },
            [9] = { xi.item.EBONY_LOG,                5, xi.craftRank.JOURNEYMAN },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Shrooms
        {
            [1] = { xi.item.DEATHBALL,       100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SLEEPSHROOM,     100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CORAL_FUNGUS,     50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.WOOZYSHROOM,      10, xi.craftRank.INITIATE   },
            [5] = { xi.item.PUFFBALL,         10, xi.craftRank.NOVICE     },
            [6] = { xi.item.DANCESHROOM,       5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.REISHI_MUSHROOM,   1, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.KING_TRUFFLE,      1, xi.craftRank.CRAFTSMAN  },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.YHOATOR_JUNGLE] = -- 124
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.BONE_CHIP,        100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.KAZHAM_PINEAPPLE,  50, xi.craftRank.AMATEUR    },
            [3] = { xi.item.LAUAN_LOG,         50, xi.craftRank.AMATEUR    },
            [4] = { xi.item.MAHOGANY_LOG,      50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.DRYAD_ROOT,        50, xi.craftRank.RECRUIT    },
            [6] = { xi.item.REISHI_MUSHROOM,   10, xi.craftRank.RECRUIT    },
            [7] = { xi.item.CORAL_FUNGUS,      10, xi.craftRank.NOVICE     },
            [8] = { xi.item.EBONY_LOG,          5, xi.craftRank.JOURNEYMAN },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Shrooms
        {
            [1] = { xi.item.DEATHBALL,       100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SLEEPSHROOM,     100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CORAL_FUNGUS,     50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.WOOZYSHROOM,      10, xi.craftRank.INITIATE   },
            [5] = { xi.item.PUFFBALL,         10, xi.craftRank.NOVICE     },
            [6] = { xi.item.DANCESHROOM,       5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.REISHI_MUSHROOM,   1, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.KING_TRUFFLE,      1, xi.craftRank.CRAFTSMAN  },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.WESTERN_ALTEPA_DESERT] = -- 125
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            [1] = { xi.item.BONE_CHIP,              240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.PEBBLE,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CHUNK_OF_ZINC_ORE,      100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.GIANT_FEMUR,            100, xi.craftRank.RECRUIT    },
            [5] = { xi.item.CHUNK_OF_IRON_ORE,       50, xi.craftRank.INITIATE   },
            [6] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,  10, xi.craftRank.NOVICE     },
            [7] = { xi.item.CHUNK_OF_GOLD_ORE,       10, xi.craftRank.NOVICE     },
            [8] = { xi.item.CORAL_FRAGMENT,           5, xi.craftRank.APPRENTICE },
            [9] = { xi.item.PHILOSOPHERS_STONE,       5, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Bones
        {
            [ 1] = { xi.item.BONE_CHIP,                 150, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.HANDFUL_OF_FISH_SCALES,    150, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.SEASHELL,                  150, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.HIGH_QUALITY_PUGIL_SCALES,  50, xi.craftRank.INITIATE   },
            [ 5] = { xi.item.TITANICTUS_SHELL,           50, xi.craftRank.APPRENTICE },
            [ 6] = { xi.item.DEMON_HORN,                 10, xi.craftRank.JOURNEYMAN },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,    5, xi.craftRank.CRAFTSMAN  },
            [ 8] = { xi.item.TURTLE_SHELL,                5, xi.craftRank.CRAFTSMAN  },
            [ 9] = { xi.item.DEMON_SKULL,                 1, xi.craftRank.ARTISAN    },
            [10] = { xi.item.HANDFUL_OF_DRAGON_SCALES,    1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.QUFIM_ISLAND] = -- 126
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Crystals
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
    },

    [xi.zone.BEHEMOTHS_DOMINION] = -- 127
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Ores 1
        {
            [1] = { xi.item.FLINT_STONE,             240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,   100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,        50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,   10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_ADAMAN_ORE,       5, xi.craftRank.JOURNEYMAN },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,     5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.VALLEY_OF_SORROWS] = -- 128
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [xi.chocoboDig.layer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.BEAUCEDINE_GLACIER_S] = -- 136
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set Ores 3
        {
            [1] = { xi.item.FLINT_STONE,               240, xi.craftRank.AMATEUR },
            [2] = { xi.item.CHUNK_OF_SILVER_ORE,       100, xi.craftRank.AMATEUR },
            [3] = { xi.item.CHUNK_OF_IRON_ORE,         100, xi.craftRank.RECRUIT },
            [4] = { xi.item.SHARD_OF_OBSIDIAN,         100, xi.craftRank.RECRUIT },
            [5] = { xi.item.CHUNK_OF_KOPPARNICKEL_ORE, 100, xi.craftRank.RECRUIT },
            [6] = { xi.item.CHUNK_OF_MYTHRIL_ORE,      100, xi.craftRank.RECRUIT },
            [7] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,     10, xi.craftRank.NOVICE  },
            [8] = { xi.item.CHUNK_OF_SWAMP_ORE,         10, xi.craftRank.NOVICE  },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Crystals
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
    },

    [xi.zone.XARCABARD_S] = -- 137
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Logs 4
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR   },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR   },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT   },
            [4] = { xi.item.FEYWEALD_LOG,             50, xi.craftRank.INITIATE  },
            [5] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE  },
            [6] = { xi.item.TEAK_LOG,                  1, xi.craftRank.CRAFTSMAN },
            [7] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN },
            [8] = { xi.item.JACARANDA_LOG,             1, xi.craftRank.ARTISAN   },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN   },
        },
    },

    [xi.zone.YAHSE_HUNTING_GROUNDS] = -- 260
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.CEIZAK_BATTLEGROUNDS] = -- 261
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.FORET_DE_HENNETIEL] = -- 262
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Shrooms
        {
            [1] = { xi.item.DEATHBALL,       100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SLEEPSHROOM,     100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CORAL_FUNGUS,     50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.WOOZYSHROOM,      10, xi.craftRank.INITIATE   },
            [5] = { xi.item.PUFFBALL,         10, xi.craftRank.NOVICE     },
            [6] = { xi.item.DANCESHROOM,       5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.REISHI_MUSHROOM,   1, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.KING_TRUFFLE,      1, xi.craftRank.CRAFTSMAN  },
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Ores 1
        {
            [1] = { xi.item.FLINT_STONE,            240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,  100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,       50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,  10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_ADAMAN_ORE,      5, xi.craftRank.JOURNEYMAN },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,    5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,  1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.YORCIA_WEALD] = -- 263
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BORE] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
    },

    [xi.zone.MORIMAR_BASALT_FIELDS] = -- 265
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
        [xi.chocoboDig.layer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.MARJAMI_RAVINE] = -- 266
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.KAMIHR_DRIFTS] = -- 267
    {
        [xi.chocoboDig.layer.TREASURE] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.REGULAR] =
        {
            -- No entries.
        },
        [xi.chocoboDig.layer.BURROW] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
        [xi.chocoboDig.layer.BORE] =
        {
            -- No entries.
        },
    },
}
