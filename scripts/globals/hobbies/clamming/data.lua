-----------------------------------
-- Clamming Data
-----------------------------------
xi = xi or {}
xi.clamming = xi.clamming or {}
-----------------------------------

-- Table with "Clamming Point" associated event ID.
xi.clamming.npcEvent =
{
    ['Clamming_Point_1'] = 20,
    ['Clamming_Point_2'] = 21,
    ['Clamming_Point_3'] = 22,
    ['Clamming_Point_4'] = 23,
    ['Clamming_Point_5'] = 24,
    ['Clamming_Point_6'] = 25,
    ['Clamming_Point_7'] = 26,
    ['Clamming_Point_8'] = 27,
}

-- Table with item weight and local var name.
xi.clamming.itemData =
{
    [xi.item.BIBIKI_SLUG              ] = {  3, '[Clam]BibikiSlug'   },
    [xi.item.JACKNIFE                 ] = { 11, '[Clam]Jacknife'     },
    [xi.item.PEBBLE                   ] = {  7, '[Clam]Peeble'       },
    [xi.item.IGNEOUS_ROCK             ] = { 35, '[Clam]IgneousRock'  },
    [xi.item.CLUMP_OF_PAMTAM_KELP     ] = {  6, '[Clam]PamtamKelp'   },
    [xi.item.SHALL_SHELL              ] = {  6, '[Clam]ShallShell'   },
    [xi.item.HANDFUL_OF_FISH_SCALES   ] = {  6, '[Clam]FishScales'   },
    [xi.item.NEBIMONITE               ] = {  6, '[Clam]Nebimonite'   },
    [xi.item.CHUNK_OF_ROCK_SALT       ] = {  6, '[Clam]RockSalt'     },
    [xi.item.HOBGOBLIN_PIE            ] = {  6, '[Clam]HobPie'       },
    [xi.item.CRAB_SHELL               ] = {  6, '[Clam]CrabShell'    },
    [xi.item.GOBLIN_MAIL              ] = {  6, '[Clam]GoblinMail'   },
    [xi.item.ELSHIMO_COCONUT          ] = {  6, '[Clam]Coconut'      },
    [xi.item.GOBLIN_ARMOR             ] = {  6, '[Clam]GoblinArmor'  },
    [xi.item.BROKEN_WILLOW_FISHING_ROD] = {  6, '[Clam]WillowRod'    },
    [xi.item.HIGH_QUALITY_PUGIL_SCALES] = {  6, '[Clam]HQPugilScale' },
    [xi.item.LOAF_OF_HOBGOBLIN_BREAD  ] = {  6, '[Clam]HobBread'     },
    [xi.item.SEASHELL                 ] = {  6, '[Clam]Seashell'     },
    [xi.item.BUNCH_OF_PAMAMAS         ] = {  6, '[Clam]Pamamas'      },
    [xi.item.MAPLE_LOG                ] = {  6, '[Clam]MapleLog'     },
    [xi.item.PETRIFIED_LOG            ] = {  6, '[Clam]PetrifiedLog' },
    [xi.item.CORAL_FRAGMENT           ] = {  6, '[Clam]CoralFrag'    },
    [xi.item.ELM_LOG                  ] = {  6, '[Clam]ElmLog'       },
    [xi.item.TROPICAL_CLAM            ] = { 20, '[Clam]TropicalClam' },
    [xi.item.TITANICTUS_SHELL         ] = {  6, '[Clam]TitanShell'   },
    [xi.item.BIBIKI_URCHIN            ] = {  6, '[Clam]BibikiUrchin' },
    [xi.item.LACQUER_TREE_LOG         ] = {  6, '[Clam]LacquerLog'   },
    [xi.item.HIGH_QUALITY_CRAB_SHELL  ] = {  6, '[Clam]HQCrabShell'  },
    [xi.item.TURTLE_SHELL             ] = {  6, '[Clam]TurtleShell'  },
    [xi.item.PIECE_OF_OXBLOOD         ] = {  6, '[Clam]Oxblood'      },
}

-- Loot tables by clamming kit capacity. Weights by tide with a total of 1000 per tier.
xi.clamming.lootTable =
{
    [50] =
    {
        { xi.item.JACKNIFE,                  338, 313 },
        { xi.item.BIBIKI_SLUG,               299, 437 },
        { xi.item.PEBBLE,                    172, 134 },
        { xi.item.SHALL_SHELL,                46,  23 },
        { xi.item.CLUMP_OF_PAMTAM_KELP,       37,  18 },
        { xi.item.HANDFUL_OF_FISH_SCALES,     31,  16 },
        { xi.item.IGNEOUS_ROCK,               29,  32 },
        { xi.item.CRAB_SHELL,                 27,  14 },
        { xi.item.BIBIKI_URCHIN,               5,   3 },
        { xi.item.TROPICAL_CLAM,               4,   4 },
        { xi.item.CORAL_FRAGMENT,              4,   2 },
        { xi.item.HIGH_QUALITY_CRAB_SHELL,     3,   2 },
        { xi.item.HIGH_QUALITY_PUGIL_SCALES,   3,   1 },
        { xi.item.TURTLE_SHELL,                2,   1 },
    },

    [100] =
    {
        { xi.item.JACKNIFE,                  302, 223 },
        { xi.item.BIBIKI_SLUG,               287, 329 },
        { xi.item.PEBBLE,                    133, 233 },
        { xi.item.IGNEOUS_ROCK,               63,  53 },
        { xi.item.BROKEN_WILLOW_FISHING_ROD,  26,  18 },
        { xi.item.CHUNK_OF_ROCK_SALT,         25,  18 },
        { xi.item.ELSHIMO_COCONUT,            25,  18 },
        { xi.item.NEBIMONITE,                 23,  18 },
        { xi.item.MAPLE_LOG,                  19,  15 },
        { xi.item.LOAF_OF_HOBGOBLIN_BREAD,    18,  15 },
        { xi.item.HOBGOBLIN_PIE,              18,  14 },
        { xi.item.HIGH_QUALITY_PUGIL_SCALES,  13,   9 },
        { xi.item.GOBLIN_MAIL,                 8,   6 },
        { xi.item.GOBLIN_ARMOR,                8,   6 },
        { xi.item.CORAL_FRAGMENT,              8,   6 },
        { xi.item.TROPICAL_CLAM,               7,   6 },
        { xi.item.TITANICTUS_SHELL,            7,   5 },
        { xi.item.PETRIFIED_LOG,               5,   4 },
        { xi.item.ELM_LOG,                     5,   4 },
    },

    [150] =
    {
        { xi.item.BIBIKI_SLUG,               257, 201 },
        { xi.item.IGNEOUS_ROCK,              162, 155 },
        { xi.item.PEBBLE,                    154, 120 },
        { xi.item.JACKNIFE,                   81, 194 },
        { xi.item.GOBLIN_MAIL,                32,  26 },
        { xi.item.NEBIMONITE,                 31,  36 },
        { xi.item.GOBLIN_ARMOR,               31,  25 },
        { xi.item.SEASHELL,                   28,  31 },
        { xi.item.CHUNK_OF_ROCK_SALT,         27,  32 },
        { xi.item.ELSHIMO_COCONUT,            27,  21 },
        { xi.item.ELM_LOG,                    23,  18 },
        { xi.item.PETRIFIED_LOG,              23,  18 },
        { xi.item.BUNCH_OF_PAMAMAS,           20,  21 },
        { xi.item.HIGH_QUALITY_PUGIL_SCALES,  19,  23 },
        { xi.item.MAPLE_LOG,                  14,  12 },
        { xi.item.LOAF_OF_HOBGOBLIN_BREAD,    14,  11 },
        { xi.item.HOBGOBLIN_PIE,              14,  11 },
        { xi.item.CORAL_FRAGMENT,             12,  13 },
        { xi.item.TITANICTUS_SHELL,           11,  13 },
        { xi.item.TROPICAL_CLAM,               7,   7 },
        { xi.item.LACQUER_TREE_LOG,            5,   4 },
        { xi.item.PIECE_OF_OXBLOOD,            4,   4 },
        { xi.item.BROKEN_WILLOW_FISHING_ROD,   4,   4 },
    },

    [200] =
    {
        { xi.item.IGNEOUS_ROCK,              188, 149 },
        { xi.item.BIBIKI_SLUG,               104,  48 },
        { xi.item.BUNCH_OF_PAMAMAS,           93,  76 },
        { xi.item.GOBLIN_ARMOR,               75,  94 },
        { xi.item.CORAL_FRAGMENT,             75,  66 },
        { xi.item.GOBLIN_MAIL,                73, 109 },
        { xi.item.SEASHELL,                   71,  65 },
        { xi.item.PETRIFIED_LOG,              70,  98 },
        { xi.item.ELM_LOG,                    65,  97 },
        { xi.item.TITANICTUS_SHELL,           46,  44 },
        { xi.item.HIGH_QUALITY_PUGIL_SCALES,  42,  40 },
        { xi.item.JACKNIFE,                   37,  46 },
        { xi.item.CHUNK_OF_ROCK_SALT,         21,  17 },
        { xi.item.PIECE_OF_OXBLOOD,           17,  14 },
        { xi.item.LACQUER_TREE_LOG,           14,  19 },
        { xi.item.TROPICAL_CLAM,               9,  18 },
    },
}
