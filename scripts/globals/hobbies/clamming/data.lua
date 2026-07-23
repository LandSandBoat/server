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

-- Loot tables by clamming kit capacity. Weights total 1000 per tier.
xi.clamming.lootTable =
{
    [50] =
    {
        { xi.item.BIBIKI_SLUG,               426 },
        { xi.item.JACKNIFE,                  315 },
        { xi.item.PEBBLE,                    135 },
        { xi.item.IGNEOUS_ROCK,               32 },
        { xi.item.SHALL_SHELL,                25 },
        { xi.item.CLUMP_OF_PAMTAM_KELP,       20 },
        { xi.item.HANDFUL_OF_FISH_SCALES,     18 },
        { xi.item.CRAB_SHELL,                 15 },
        { xi.item.TROPICAL_CLAM,               4 },
        { xi.item.BIBIKI_URCHIN,               3 },
        { xi.item.CORAL_FRAGMENT,              2 },
        { xi.item.HIGH_QUALITY_CRAB_SHELL,     2 },
        { xi.item.HIGH_QUALITY_PUGIL_SCALES,   2 },
        { xi.item.TURTLE_SHELL,                1 },
    },

    [100] =
    {
        { xi.item.BIBIKI_SLUG,               325 },
        { xi.item.PEBBLE,                    228 },
        { xi.item.JACKNIFE,                  227 },
        { xi.item.IGNEOUS_ROCK,               55 },
        { xi.item.CHUNK_OF_ROCK_SALT,         20 },
        { xi.item.BROKEN_WILLOW_FISHING_ROD,  19 },
        { xi.item.ELSHIMO_COCONUT,            18 },
        { xi.item.NEBIMONITE,                 17 },
        { xi.item.LOAF_OF_HOBGOBLIN_BREAD,    15 },
        { xi.item.HOBGOBLIN_PIE,              14 },
        { xi.item.MAPLE_LOG,                  14 },
        { xi.item.HIGH_QUALITY_PUGIL_SCALES,   9 },
        { xi.item.GOBLIN_MAIL,                 7 },
        { xi.item.TROPICAL_CLAM,               6 },
        { xi.item.GOBLIN_ARMOR,                6 },
        { xi.item.CORAL_FRAGMENT,              6 },
        { xi.item.TITANICTUS_SHELL,            6 },
        { xi.item.ELM_LOG,                     4 },
        { xi.item.PETRIFIED_LOG,               4 },
    },

    [150] =
    {
        { xi.item.BIBIKI_SLUG,               203 },
        { xi.item.JACKNIFE,                  190 },
        { xi.item.IGNEOUS_ROCK,              157 },
        { xi.item.PEBBLE,                    120 },
        { xi.item.NEBIMONITE,                 35 },
        { xi.item.CHUNK_OF_ROCK_SALT,         31 },
        { xi.item.SEASHELL,                   30 },
        { xi.item.GOBLIN_ARMOR,               26 },
        { xi.item.GOBLIN_MAIL,                24 },
        { xi.item.BUNCH_OF_PAMAMAS,           23 },
        { xi.item.HIGH_QUALITY_PUGIL_SCALES,  22 },
        { xi.item.ELSHIMO_COCONUT,            22 },
        { xi.item.ELM_LOG,                    19 },
        { xi.item.PETRIFIED_LOG,              18 },
        { xi.item.TITANICTUS_SHELL,           13 },
        { xi.item.CORAL_FRAGMENT,             12 },
        { xi.item.HOBGOBLIN_PIE,              12 },
        { xi.item.LOAF_OF_HOBGOBLIN_BREAD,    12 },
        { xi.item.MAPLE_LOG,                  11 },
        { xi.item.TROPICAL_CLAM,               7 },
        { xi.item.BROKEN_WILLOW_FISHING_ROD,   5 },
        { xi.item.PIECE_OF_OXBLOOD,            4 },
        { xi.item.LACQUER_TREE_LOG,            4 },
    },

    [200] =
    {
        { xi.item.IGNEOUS_ROCK,              157 },
        { xi.item.GOBLIN_ARMOR,              101 },
        { xi.item.GOBLIN_MAIL,               101 },
        { xi.item.PETRIFIED_LOG,             100 },
        { xi.item.ELM_LOG,                    97 },
        { xi.item.BUNCH_OF_PAMAMAS,           85 },
        { xi.item.SEASHELL,                   64 },
        { xi.item.CORAL_FRAGMENT,             59 },
        { xi.item.BIBIKI_SLUG,                44 },
        { xi.item.JACKNIFE,                   44 },
        { xi.item.TITANICTUS_SHELL,           44 },
        { xi.item.HIGH_QUALITY_PUGIL_SCALES,  39 },
        { xi.item.LACQUER_TREE_LOG,           20 },
        { xi.item.PIECE_OF_OXBLOOD,           15 },
        { xi.item.TROPICAL_CLAM,              15 },
        { xi.item.CHUNK_OF_ROCK_SALT,         15 },
    },
}
