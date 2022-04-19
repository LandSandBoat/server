xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.parameters = xi.spells.parameters or {}
-----------------------------------

-- Table with spell parameters. Data taken from JP-Wiki and BG wiki when not available. Preference in that precise orther when a missmatch happens.
-- Single target "Spirit Magic"
-- Tier 1 spells: https://nw6yx36onohv5j6wmzoba3nllq-ac4c6men2g7xr2a-wiki-ffo-jp.translate.goog/html/3655.html
-- Tier 2 spells: https://nw6yx36onohv5j6wmzoba3nllq-ac4c6men2g7xr2a-wiki-ffo-jp.translate.goog/html/3657.html
-- Tier 3 spells: https://nw6yx36onohv5j6wmzoba3nllq-ac4c6men2g7xr2a-wiki-ffo-jp.translate.goog/html/3659.html
-- Tier 4 spells: https://nw6yx36onohv5j6wmzoba3nllq-ac4c6men2g7xr2a-wiki-ffo-jp.translate.goog/html/2229.html
-- Tier 5 spells: https://nw6yx36onohv5j6wmzoba3nllq-ac4c6men2g7xr2a-wiki-ffo-jp.translate.goog/html/3663.html
-- Tier 6 spells: https://nw6yx36onohv5j6wmzoba3nllq-ac4c6men2g7xr2a-wiki-ffo-jp.translate.goog/html/32808.html

xi.spells.parameters.damage =
{
-- Single target black magic spells:
-- Structure:           [spellId] = {  Stat used, vNPC, mNPC,  vPC,   I,   M0,  M50,  M100, M200, M300, M400, M500 },
    [xi.magic.spell.AERO        ] = { xi.mod.INT,   25,    1,   40,  35,  1.6,    1,     0,    0,    0,    0,    0 },
    [xi.magic.spell.AERO_II     ] = { xi.mod.INT,  113,    1,  140, 133,  2.6,  1.8,     1,    0,    0,    0,    0 },
    [xi.magic.spell.AERO_III    ] = { xi.mod.INT,  265,  1.5,  260, 295,  3.4,  2.8,   1.9,    1,    0,    0,    0 },
    [xi.magic.spell.AERO_IV     ] = { xi.mod.INT,  440,    2,  480, 472,  4.4,  3.8,   2.9, 1.98,    1,    0,    0 },
    [xi.magic.spell.AERO_V      ] = { xi.mod.INT,  738,  2.3,  750, 550,  5.2,  4.5,   3.9, 2.98, 1.98,    1,    0 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.AERO_VI     ] = { xi.mod.INT, 1070,  2,5, 1070, 600,    6,  5.8,   4.8,  3.8,  2.9, 1.98,    1 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.TORNADO     ] = { xi.mod.INT,  552,    2,  700, 577,    2,    2,     2,    2,    2,    2,    2 },
    [xi.magic.spell.TORNADO_II  ] = { xi.mod.INT,  710,    2,  800, 780,    2,    2,     2,    2,    2,    2,    2 },
    [xi.magic.spell.BLIZZARD    ] = { xi.mod.INT,   46,    1,   70,  60,  1.2,    1,    0,     0,    0,    0,    0 },
    [xi.magic.spell.BLIZZARD_II ] = { xi.mod.INT,  155,    1,  180, 178,  2.2,  1.6,    1,     0,    0,    0,    0 },
    [xi.magic.spell.BLIZZARD_III] = { xi.mod.INT,  320,  1.5,  320, 345,  2.8,  2.6,  1.8,     1,    0,    0,    0 },
    [xi.magic.spell.BLIZZARD_IV ] = { xi.mod.INT,  506,    2,  560, 541,  3.9,  3.6,  2.8,  1.96,    1,    0,    0 },
    [xi.magic.spell.BLIZZARD_V  ] = { xi.mod.INT,  829,  2.3,  850, 600,  4.4,    4,  3.8,  2.96, 1.96,    1,    0 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.BLIZZARD_VI ] = { xi.mod.INT, 1190,  2.5, 1190, 650,    5,  5.6,  4.6,   3.6,  2.8, 1.96,    1 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.FREEZE      ] = { xi.mod.INT,  552,    2,  700, 552,    2,    2,     2,    2,    2,    2,    2 },
    [xi.magic.spell.FREEZE_II   ] = { xi.mod.INT,  710,    2,  800, 780,    2,    2,     2,    2,    2,    2,    2 },
    [xi.magic.spell.FIRE        ] = { xi.mod.INT,   35,    1,   55,  46,  1.4,    1,    0,     0,    0,    0,    0 },
    [xi.magic.spell.FIRE_II     ] = { xi.mod.INT,  133,    1,  160, 155,  2.4,  1.7,    1,     0,    0,    0,    0 },
    [xi.magic.spell.FIRE_III    ] = { xi.mod.INT,  295,  1.5,  290, 320,  3.1,  2.7, 1.85,     1,    0,    0,    0 },
    [xi.magic.spell.FIRE_IV     ] = { xi.mod.INT,  472,    2,  520, 506,  4.2,  3.7, 2.85,  1.97,    1,    0,    0 },
    [xi.magic.spell.FIRE_V      ] = { xi.mod.INT,  785,  2.3,  800, 550,  4.8, 4.24, 3.85,  2.97, 1.97,    1,    0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.FIRE_VI     ] = { xi.mod.INT, 1130,  2.5, 1130, 600,  5.5,  5.7,  4.7,   3.7, 2.85, 1.97,    1 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.FLARE       ] = { xi.mod.INT,  552,    2,  700, 684,    2,    2,    2,     2,    2,    2,    2 },
    [xi.magic.spell.FLARE_II    ] = { xi.mod.INT,  710,    2,  800, 780,    2,    2,    2,     2,    2,    2,    2 },
    [xi.magic.spell.STONE       ] = { xi.mod.INT,   10,    1,   10,  16,    2,    1,    0,     0,    0,    0,    0 },
    [xi.magic.spell.STONE_II    ] = { xi.mod.INT,   78,    1,  100,  95,    3,    2,    1,     0,    0,    0,    0 },
    [xi.magic.spell.STONE_III   ] = { xi.mod.INT,  210,  1.5,  200, 236,    4,    3,    2,     1,    0,    0,    0 },
    [xi.magic.spell.STONE_IV    ] = { xi.mod.INT,  381,    2,  400, 410,    5,    4,    3,     2,    1,    0,    0 },
    [xi.magic.spell.STONE_V     ] = { xi.mod.INT,  626,  2.3,  650, 500,    6,    5,    4,     3,    2,    1,    0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.STONE_VI    ] = { xi.mod.INT,  950,  2.5,  950, 550,    7,    6,    5,     4,    3,    2,    1 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.QUAKE       ] = { xi.mod.INT,  552,    2,  700, 603,    2,    2,    2,     2,    2,    2,    2 },
    [xi.magic.spell.QUAKE_II    ] = { xi.mod.INT,  710,    2,  800, 780,    2,    2,    2,     2,    2,    2,    2 },
    [xi.magic.spell.THUNDER     ] = { xi.mod.INT,   60,    1,   85,  78,    1,    1,    0,     0,    0,    0,    0 },
    [xi.magic.spell.THUNDER_II  ] = { xi.mod.INT,  178,    1,  200, 210,    2,  1.5,    1,     0,    0,    0,    0 },
    [xi.magic.spell.THUNDER_III ] = { xi.mod.INT,  345,  1.5,  350, 381,  2.5,  2.5, 1.75,     1,    0,    0,    0 },
    [xi.magic.spell.THUNDER_IV  ] = { xi.mod.INT,  541,    2,  600, 626,  3.6,  3.5, 2.75,  1.95,    1,    0,    0 },
    [xi.magic.spell.THUNDER_V   ] = { xi.mod.INT,  874,  2.3,  900, 700,    4, 3.74, 3.75,  2.95, 1.95,    1,    0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.THUNDER_VI  ] = { xi.mod.INT, 1250,  2.5, 1250, 750,  4.5,  5.5,  4.5,   3.5, 2.75, 1.95,    1 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.BURST       ] = { xi.mod.INT,  552,    2,  700, 630,    2,    2,    2,     2,    2,    2,    2 },
    [xi.magic.spell.BURST_II    ] = { xi.mod.INT,  710,    2,  800, 780,    2,    2,    2,     2,    2,    2,    2 },
    [xi.magic.spell.WATER       ] = { xi.mod.INT,   16,    1,   25,  25,  1.8,    1,    0,     0,    0,    0,    0 },
    [xi.magic.spell.WATER_II    ] = { xi.mod.INT,   95,    1,  120, 113,  2.8,  1.9,    1,     0,    0,    0,    0 },
    [xi.magic.spell.WATER_III   ] = { xi.mod.INT,  236,  1.5,  230, 265,  3.7,  2.9, 1.95,     1,    0,    0,    0 },
    [xi.magic.spell.WATER_IV    ] = { xi.mod.INT,  410,    2,  440, 440,  4.7,  3.9, 2.95,  1.99,    1,    0,    0 },
    [xi.magic.spell.WATER_V     ] = { xi.mod.INT,  680,  2.3,  700, 500,  5.6, 4.74, 3.95,  2.99, 1.99,    1,    0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.WATER_VI    ] = { xi.mod.INT, 1010,  1.5, 1010, 550,  6.5,  5.9,  4.9,   3.9, 2.95, 1.99,    1 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.FLOOD       ] = { xi.mod.INT,  552,    2,  700, 657,    2,    2,    2,     2,    2,    2,    2 },
    [xi.magic.spell.FLOOD_II    ] = { xi.mod.INT,  710,    2,  800, 780,    2,    2,    2,     2,    2,    2,    2 },
    [xi.magic.spell.COMET       ] = { xi.mod.INT,  964,  2.3, 1000, 850,    4, 3.75,  3.5,     3,    2,    1,    1 }, -- I value unknown. Guesstimate used.

-- Multiple target spells:
-- Structure:           [spellId] = {  Stat used, vNPC, mNPC,  vPC,   I,   M0,  M50,  M100, M200, M300, M400, M500 },
    [xi.magic.spell.AEROGA      ] = { xi.mod.INT,   93,    1,  100, 120,  2.6,  1.8,     1,    0,    0,    0,    0 },
    [xi.magic.spell.AEROGA_II   ] = { xi.mod.INT,  266,    1,  310, 312,  3.4,  2.8,   1.9,    1,    0,    0,    0 },
    [xi.magic.spell.AEROGA_III  ] = { xi.mod.INT,  527,  1.5,  580, 642,  4.4,  3.8,   2.9, 1.98,    1,    0,    0 },
    [xi.magic.spell.AEROGA_IV   ] = { xi.mod.INT,  738,    2,    0, 700,    1,    1,     1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Aero V.
    [xi.magic.spell.AEROGA_V    ] = { xi.mod.INT, 1070,  2.3,    0, 750,    1,    1,     1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Aero VI.
    [xi.magic.spell.AERA        ] = { xi.mod.INT,  210,    1,  210, 250,  2.6,  1.8,     1,    0,    0,    0,    0 },
    [xi.magic.spell.AERA_II     ] = { xi.mod.INT,  430,    1,  430, 600,  3.4,  2.8,   1.9,    1,    0,    0,    0 },
    [xi.magic.spell.AERA_III    ] = { xi.mod.INT,  710,  1.5,  710, 700,  4.4,  3.8,   2.9, 1.98,    1,    0,    0 }, -- No info found. Since Aera I and II N Values coincided with Aeroga 1 and II, used Values of Aeroga III.
    [xi.magic.spell.AEROJA      ] = { xi.mod.INT,  844,  2.3,  850, 800,  5.2,  4.5,   3.9,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.BLIZZAGA    ] = { xi.mod.INT,  145,    1,  160, 172,  2.2,  1.6,     1,    0,    0,    0,    0 },
    [xi.magic.spell.BLIZZAGA_II ] = { xi.mod.INT,  350,    1,  370, 392,  2.8,  2.6,   1.8,    1,    0,    0,    0 },
    [xi.magic.spell.BLIZZAGA_III] = { xi.mod.INT,  642,  1.5,  660, 697,  3.9,  3.6,   2.8, 1.96,    1,    0,    0 },
    [xi.magic.spell.BLIZZAGA_IV ] = { xi.mod.INT,  829,    2,    0, 800,    1,    1,     1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Blizzard V.
    [xi.magic.spell.BLIZZAGA_V  ] = { xi.mod.INT, 1190,  2.3,    0, 950,    1,    1,     1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Blizzard VI.
    [xi.magic.spell.BLIZZARA    ] = { xi.mod.INT,  270,    1,  270, 300,  2.2,  1.6,     1,    0,    0,    0,    0 },
    [xi.magic.spell.BLIZZARA_II ] = { xi.mod.INT,  510,    1,  510, 550,  2.8,  2.6,   1.8,    1,    0,    0,    0 },
    [xi.magic.spell.BLIZZARA_III] = { xi.mod.INT,  830,  1.5,  830, 850,  3.9,  3.6,   2.8, 1.96,    1,    0,    0 }, -- No info found. Since Blizzara I and II N Values coincided with Blizzaga 1 and II, used Values of Blizzaga III.
    [xi.magic.spell.BLIZZAJA    ] = { xi.mod.INT,  953,  2.3,  950, 950,  4.4,    4,   3.8,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.FIRAGA      ] = { xi.mod.INT,  120,    1,  120, 145,  2.4,  1.7,     1,    0,    0,    0,    0 },
    [xi.magic.spell.FIRAGA_II   ] = { xi.mod.INT,  312,    1,  340, 350,  3.1,  2.7,  1.85,    1,    0,    0,    0 },
    [xi.magic.spell.FIRAGA_III  ] = { xi.mod.INT,  589,  1.5,  620, 642,  4.2,  3.7,  2.85, 1.97,    1,    0,    0 },
    [xi.magic.spell.FIRAGA_IV   ] = { xi.mod.INT,  785,    2,    0, 700,    1,    1,     1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Fire V.
    [xi.magic.spell.FIRAGA_V    ] = { xi.mod.INT, 1130,  2.3,    0, 800,    1,    1,     1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Fire VI.
    [xi.magic.spell.FIRA        ] = { xi.mod.INT,  240,    1,  240, 250,  2.4,  1.7,     1,    0,    0,    0,    0 },
    [xi.magic.spell.FIRA_II     ] = { xi.mod.INT,  470,    1,  470, 500,  3.1,  2.7,  1.85,    1,    0,    0,    0 },
    [xi.magic.spell.FIRA_III    ] = { xi.mod.INT,  760,  1.5,  760, 800,  4.2,  3.7,  2.85, 1.97,    1,    0,    0 }, -- No info found. Since Fira I and II N Values coincided with Firaga 1 and II, used Values of Firaga III.
    [xi.magic.spell.FIRAJA      ] = { xi.mod.INT,  902,  2.3,  900, 950,  4.8, 4.25,  3.85,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.STONEGA     ] = { xi.mod.INT,   56,    1,   60,  74,    3,    2,     1,    0,    0,    0,    0 },
    [xi.magic.spell.STONEGA_II  ] = { xi.mod.INT,  201,    1,  250, 232,    4,    3,     2,    1,    0,    0,    0 },
    [xi.magic.spell.STONEGA_III ] = { xi.mod.INT,  434,  1.5,  500, 480,    5,    4,     3,    2,    1,    0,    0 },
    [xi.magic.spell.STONEGA_IV  ] = { xi.mod.INT,  626,    2,    0, 650,    1,    1,     1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Stone V.
    [xi.magic.spell.STONEGA_V   ] = { xi.mod.INT,  950,  2.3,    0, 950,    1,    1,     1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Stone VI.
    [xi.magic.spell.STONERA     ] = { xi.mod.INT,  150,    1,  150, 150,    3,    2,     1,    0,    0,    0,    0 },
    [xi.magic.spell.STONERA_II  ] = { xi.mod.INT,  350,    1,  350, 350,    4,    3,     2,    1,    0,    0,    0 },
    [xi.magic.spell.STONERA_III ] = { xi.mod.INT,  650,  1.5,  650, 650,    5,    4,     3,    2,    1,    0,    0 }, -- No info found. Since Stonera I and II N Values coincided with Stonega 1 and II, used Values of Stonega III.
    [xi.magic.spell.STONEJA     ] = { xi.mod.INT,  719,  2.3,  750, 750,    6,    5,     4,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.THUNDAGA    ] = { xi.mod.INT,  172,    1,  200, 201,    2,  1.5,     1,    0,    0,    0,    0 },
    [xi.magic.spell.THUNDAGA_II ] = { xi.mod.INT,  392,    1,  400, 434,  2.5,  2.5,  1.75,    1,    0,    0,    0 },
    [xi.magic.spell.THUNDAGA_III] = { xi.mod.INT,  697,  1.5,  700, 719,  3.6,  3.5,  2.75, 1.95,    1,    0,    0 },
    [xi.magic.spell.THUNDAGA_IV ] = { xi.mod.INT,  874,    2,    0, 900,    1,    1,     1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Thunder V.
    [xi.magic.spell.THUNDAGA_V  ] = { xi.mod.INT, 1250,  2.3,    0, 999,    1,    1,     1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Thunder VI.
    [xi.magic.spell.THUNDARA    ] = { xi.mod.INT,  300,    1,  300, 300,    2,  1.5,     1,    0,    0,    0,    0 },
    [xi.magic.spell.THUNDARA_II ] = { xi.mod.INT,  550,    1,  550, 550,  2.5,  2.5,  1.75,    1,    0,    0,    0 },
    [xi.magic.spell.THUNDARA_III] = { xi.mod.INT,  900,  1.5,  900, 900,  3.6,  3.5,  2.75, 1.95,    1,    0,    0 }, -- No info found. Since Thundara I and II N Values coincided with Thundaga 1 and II, used Values of Thundaga III.
    [xi.magic.spell.THUNDAJA    ] = { xi.mod.INT, 1005,  2.3, 1000, 999,    4, 3.75,  3.75,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.WATERGA     ] = { xi.mod.INT,   74,    1,   80,  96,  2.8,  1.9,     1,    0,    0,    0,    0 },
    [xi.magic.spell.WATERGA_II  ] = { xi.mod.INT,  232,    1,  280, 266,  3.7,  2.9,  1.95,    1,    0,    0,    0 },
    [xi.magic.spell.WATERGA_III ] = { xi.mod.INT,  480,  1.5,  540, 527,  4.7,  3.9,  2.95, 1.99,    1,    0,    0 },
    [xi.magic.spell.WATERGA_IV  ] = { xi.mod.INT,  680,    2,    0, 700,    1,    1,     1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Water V.
    [xi.magic.spell.WATERGA_V   ] = { xi.mod.INT, 1010,  2.3,    0, 900,    1,    1,     1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Water VI.
    [xi.magic.spell.WATERA      ] = { xi.mod.INT,  180,    1,  180, 200,  2.8,  1.9,     1,    0,    0,    0,    0 },
    [xi.magic.spell.WATERA_II   ] = { xi.mod.INT,  390,    1,  390, 400,  3.7,  2.9,  1.95,    1,    0,    0,    0 },
    [xi.magic.spell.WATERA_III  ] = { xi.mod.INT,  660,  1.5,  660, 700,  4.7,  3.9,  2.95, 1.99,    1,    0,    0 }, -- No info found. Since Watera I and II N Values coincided with Waterga 1 and II, used Values of Waterga III.
    [xi.magic.spell.WATERJA     ] = { xi.mod.INT,  782,  2.3,  800, 900,  5.6, 4.75,  3.95,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.

-- Ninjutsu spells:
-- Structure:           [spellId] = {  Stat used, vNPC,    M,  vPC,   I }, -- Inflexion point unknown and not used ATM. Set to 100, 250 and 400, for now.
    [xi.magic.spell.DOTON_ICHI  ] = { xi.mod.INT,   28,  0.5,   28, 100 },
    [xi.magic.spell.DOTON_NI    ] = { xi.mod.INT,   68,    1,   68, 250 },
    [xi.magic.spell.DOTON_SAN   ] = { xi.mod.INT,  134,  1.5,  134, 400 },
    [xi.magic.spell.HUTON_ICHI  ] = { xi.mod.INT,   28,  0.5,   28, 100 },
    [xi.magic.spell.HUTON_NI    ] = { xi.mod.INT,   68,    1,   68, 250 },
    [xi.magic.spell.HUTON_SAN   ] = { xi.mod.INT,  134,  1.5,  134, 400 },
    [xi.magic.spell.HYOTON_ICHI ] = { xi.mod.INT,   28,  0.5,   28, 100 },
    [xi.magic.spell.HYOTON_NI   ] = { xi.mod.INT,   68,    1,   68, 250 },
    [xi.magic.spell.HYOTON_SAN  ] = { xi.mod.INT,  134,  1.5,  134, 400 },
    [xi.magic.spell.KATON_ICHI  ] = { xi.mod.INT,   28,  0.5,   28, 100 },
    [xi.magic.spell.KATON_NI    ] = { xi.mod.INT,   68,    1,   68, 250 },
    [xi.magic.spell.KATON_SAN   ] = { xi.mod.INT,  134,  1.5,  134, 400 },
    [xi.magic.spell.RAITON_ICHI ] = { xi.mod.INT,   28,  0.5,   28, 100 },
    [xi.magic.spell.RAITON_NI   ] = { xi.mod.INT,   68,    1,   68, 250 },
    [xi.magic.spell.RAITON_SAN  ] = { xi.mod.INT,  134,  1.5,  134, 400 },
    [xi.magic.spell.SUITON_ICHI ] = { xi.mod.INT,   28,  0.5,   28, 100 },
    [xi.magic.spell.SUITON_NI   ] = { xi.mod.INT,   68,    1,   68, 250 },
    [xi.magic.spell.SUITON_SAN  ] = { xi.mod.INT,  134,  1.5,  134, 400 },

-- Divine spells: https://nw6yx36onohv5j6wmzoba3nllq-ac4c6men2g7xr2a-wiki-ffo-jp.translate.goog/html/1963.html
-- Structure:           [spellId] = {  Stat used, vNPC,    M,  vPC,   I },
    [xi.magic.spell.BANISH      ] = { xi.mod.MND,  14,     1,   14,  25 },
    [xi.magic.spell.BANISH_II   ] = { xi.mod.MND,  85,     1,   85, 113 },
    [xi.magic.spell.BANISH_III  ] = { xi.mod.MND, 198,   1.5,  198, 250 },
    [xi.magic.spell.BANISH_IV   ] = { xi.mod.MND, 420,   1.5,  420, 400 }, -- Enemy only. Stats unknown/unchecked.
    [xi.magic.spell.BANISHGA    ] = { xi.mod.MND,  50,     1,   50,  46 },
    [xi.magic.spell.BANISHGA_II ] = { xi.mod.MND, 180,     1,  180, 133 },
    [xi.magic.spell.BANISHGA_III] = { xi.mod.MND, 480,   1.5,  480, 450 }, -- Enemy only. Stats unknown.
    [xi.magic.spell.BANISHGA_IV ] = { xi.mod.MND, 600,   1.5,  600, 600 }, -- Enemy only. Stats unknown.
    [xi.magic.spell.HOLY        ] = { xi.mod.MND, 125,     1,  125, 150 },
    [xi.magic.spell.HOLY_II     ] = { xi.mod.MND, 250,     2,  250, 300 },
}

xi.spells.parameters.enhancingSpell =
{
--                                     1     2            3            4           5              6          7
-- Structure:            [spellId] = { Tier, Main_Effect, Spell_Level, Base_Power, Base_Duration, Composure, Always_Overwrite },

    -- Aquaveil
    [xi.magic.spell.AQUAVEIL     ] = { 1, xi.effect.AQUAVEIL,       1,    1,  600, true,  true  },

    -- Bar-Element
    [xi.magic.spell.BARAERO      ] = { 1, xi.effect.BARAERO,        1,    0,  480, true,  true  },
    [xi.magic.spell.BARBLIZZARD  ] = { 1, xi.effect.BARBLIZZARD,    1,    0,  480, true,  true  },
    [xi.magic.spell.BARFIRE      ] = { 1, xi.effect.BARFIRE,        1,    0,  480, true,  true  },
    [xi.magic.spell.BARSTONE     ] = { 1, xi.effect.BARSTONE,       1,    0,  480, true,  true  },
    [xi.magic.spell.BARTHUNDER   ] = { 1, xi.effect.BARTHUNDER,     1,    0,  480, true,  true  },
    [xi.magic.spell.BARWATER     ] = { 1, xi.effect.BARWATER,       1,    0,  480, true,  true  },
    [xi.magic.spell.BARAERA      ] = { 2, xi.effect.BARAERO,        1,    0,  480, true,  true  },
    [xi.magic.spell.BARBLIZZARA  ] = { 2, xi.effect.BARBLIZZARD,    1,    0,  480, true,  true  },
    [xi.magic.spell.BARFIRA      ] = { 2, xi.effect.BARFIRE,        1,    0,  480, true,  true  },
    [xi.magic.spell.BARSTONRA    ] = { 2, xi.effect.BARSTONE,       1,    0,  480, true,  true  },
    [xi.magic.spell.BARTHUNDRA   ] = { 2, xi.effect.BARTHUNDER,     1,    0,  480, true,  true  },
    [xi.magic.spell.BARWATERA    ] = { 2, xi.effect.BARWATER,       1,    0,  480, true,  true  },

    -- Bar-Element
    [xi.magic.spell.BARAMNESIA   ] = { 1, xi.effect.BARAMNESIA,     1,    1,  480, true,  true  },
    [xi.magic.spell.BARBLIND     ] = { 1, xi.effect.BARBLIND,       1,    1,  480, true,  true  },
    [xi.magic.spell.BARPARALYZE  ] = { 1, xi.effect.BARPARALYZE,    1,    1,  480, true,  true  },
    [xi.magic.spell.BARPETRIFY   ] = { 1, xi.effect.BARPETRIFY,     1,    1,  480, true,  true  },
    [xi.magic.spell.BARPOISON    ] = { 1, xi.effect.BARPOISON,      1,    1,  480, true,  true  },
    [xi.magic.spell.BARSILENCE   ] = { 1, xi.effect.BARSILENCE,     1,    1,  480, true,  true  },
    [xi.magic.spell.BARSLEEP     ] = { 1, xi.effect.BARSLEEP,       1,    1,  480, true,  true  },
    [xi.magic.spell.BARVIRUS     ] = { 1, xi.effect.BARVIRUS,       1,    1,  480, true,  true  },
    [xi.magic.spell.BARAMNESRA   ] = { 2, xi.effect.BARAMNESIA,     1,    1,  480, true,  true  },
    [xi.magic.spell.BARBLINDRA   ] = { 2, xi.effect.BARBLIND,       1,    1,  480, true,  true  },
    [xi.magic.spell.BARPARALYZRA ] = { 2, xi.effect.BARPARALYZE,    1,    1,  480, true,  true  },
    [xi.magic.spell.BARPETRA     ] = { 2, xi.effect.BARPETRIFY,     1,    1,  480, true,  true  },
    [xi.magic.spell.BARPOISONRA  ] = { 2, xi.effect.BARPOISON,      1,    1,  480, true,  true  },
    [xi.magic.spell.BARSILENCERA ] = { 2, xi.effect.BARSILENCE,     1,    1,  480, true,  true  },
    [xi.magic.spell.BARSLEEPRA   ] = { 2, xi.effect.BARSLEEP,       1,    1,  480, true,  true  },
    [xi.magic.spell.BARVIRA      ] = { 2, xi.effect.BARVIRUS,       1,    1,  480, true,  true  },

    -- Blink
    [xi.magic.spell.BLINK        ] = { 1, xi.effect.BLINK,          1,    2,  300, true,  false },

    -- Boost-Stat
    [xi.magic.spell.BOOST_STR    ] = { 1, xi.effect.STR_BOOST,      1,    5,  300, true,  false },
    [xi.magic.spell.BOOST_DEX    ] = { 1, xi.effect.DEX_BOOST,      1,    5,  300, true,  false },
    [xi.magic.spell.BOOST_VIT    ] = { 1, xi.effect.VIT_BOOST,      1,    5,  300, true,  false },
    [xi.magic.spell.BOOST_AGI    ] = { 1, xi.effect.AGI_BOOST,      1,    5,  300, true,  false },
    [xi.magic.spell.BOOST_INT    ] = { 1, xi.effect.INT_BOOST,      1,    5,  300, true,  false },
    [xi.magic.spell.BOOST_MND    ] = { 1, xi.effect.MND_BOOST,      1,    5,  300, true,  false },
    [xi.magic.spell.BOOST_CHR    ] = { 1, xi.effect.CHR_BOOST,      1,    5,  300, true,  false },

    -- Deodorize / Invisible / Sneak
    [xi.magic.spell.DEODORIZE    ] = { 1, xi.effect.DEODORIZE,     15,    0,  420, true,  false },
    [xi.magic.spell.INVISIBLE    ] = { 1, xi.effect.INVISIBLE,     20,    0,  420, true,  false },
    [xi.magic.spell.SNEAK        ] = { 1, xi.effect.SNEAK,         20,    0,  420, true,  false },

    -- Embrava
    [xi.magic.spell.EMBRAVA      ] = { 1, xi.effect.EMBRAVA,        5,    0,   90, true,  true  },

    -- En-Spell
    [xi.magic.spell.ENAERO       ] = { 1, xi.effect.ENAERO,        20,    0,  180, true,  false },
    [xi.magic.spell.ENBLIZZARD   ] = { 1, xi.effect.ENBLIZZARD,    22,    0,  180, true,  false },
    [xi.magic.spell.ENFIRE       ] = { 1, xi.effect.ENFIRE,        24,    0,  180, true,  false },
    [xi.magic.spell.ENSTONE      ] = { 1, xi.effect.ENSTONE,       18,    0,  180, true,  false },
    [xi.magic.spell.ENTHUNDER    ] = { 1, xi.effect.ENTHUNDER,     16,    0,  180, true,  false },
    [xi.magic.spell.ENWATER      ] = { 1, xi.effect.ENWATER,       27,    0,  180, true,  false },
    [xi.magic.spell.ENAERO_II    ] = { 2, xi.effect.ENAERO_II,     54,    0,  180, true,  false },
    [xi.magic.spell.ENBLIZZARD_II] = { 2, xi.effect.ENBLIZZARD_II, 56,    0,  180, true,  false },
    [xi.magic.spell.ENFIRE_II    ] = { 2, xi.effect.ENFIRE_II,     58,    0,  180, true,  false },
    [xi.magic.spell.ENSTONE_II   ] = { 2, xi.effect.ENSTONE_II,    52,    0,  180, true,  false },
    [xi.magic.spell.ENTHUNDER_II ] = { 2, xi.effect.ENTHUNDER_II,  50,    0,  180, true,  false },
    [xi.magic.spell.ENWATER_II   ] = { 2, xi.effect.ENWATER_II,    60,    0,  180, true,  false },

    -- Flurry
    [xi.magic.spell.FLURRY       ] = { 1, xi.effect.FLURRY,        48,   15,  180, true,  false },
    [xi.magic.spell.FLURRY_II    ] = { 2, xi.effect.FLURRY_II,     96,   30,  180, true,  false },

    -- Gain-Stat
    [xi.magic.spell.GAIN_STR     ] = { 1, xi.effect.STR_BOOST,      1,    5,  300, true,  false },
    [xi.magic.spell.GAIN_DEX     ] = { 1, xi.effect.DEX_BOOST,      1,    5,  300, true,  false },
    [xi.magic.spell.GAIN_VIT     ] = { 1, xi.effect.VIT_BOOST,      1,    5,  300, true,  false },
    [xi.magic.spell.GAIN_AGI     ] = { 1, xi.effect.AGI_BOOST,      1,    5,  300, true,  false },
    [xi.magic.spell.GAIN_INT     ] = { 1, xi.effect.INT_BOOST,      1,    5,  300, true,  false },
    [xi.magic.spell.GAIN_MND     ] = { 1, xi.effect.MND_BOOST,      1,    5,  300, true,  false },
    [xi.magic.spell.GAIN_CHR     ] = { 1, xi.effect.CHR_BOOST,      1,    5,  300, true,  false },

    -- Haste
    [xi.magic.spell.HASTE        ] = { 1, xi.effect.HASTE,         48, 1465,  180, true,  false },
    [xi.magic.spell.HASTE_II     ] = { 2, xi.effect.HASTE,         96, 2998,  180, true,  false },
    [xi.magic.spell.HASTEGA      ] = { 1, xi.effect.HASTE,         48, 1494,  180, false, false },
    -- [xi.magic.spell.HASTEGA_II   ] = { 2, xi.effect.HASTE,         99, 2998,  180, false, false },

    -- Phalanx
    [xi.magic.spell.PHALANX      ] = { 1, xi.effect.PHALANX,       33,    0,  180, true,  false },
    [xi.magic.spell.PHALANX_II   ] = { 2, xi.effect.PHALANX,       75,    0,  240, true,  false },

    -- Protect / Protectra
    [xi.magic.spell.PROTECT      ] = { 1, xi.effect.PROTECT,        7,   20, 1800, false, false },
    [xi.magic.spell.PROTECT_II   ] = { 2, xi.effect.PROTECT,       27,   50, 1800, false, false },
    [xi.magic.spell.PROTECT_III  ] = { 3, xi.effect.PROTECT,       47,   90, 1800, false, false },
    [xi.magic.spell.PROTECT_IV   ] = { 4, xi.effect.PROTECT,       63,  140, 1800, false, false },
    [xi.magic.spell.PROTECT_V    ] = { 5, xi.effect.PROTECT,       76,  220, 1800, false, false },
    [xi.magic.spell.PROTECTRA    ] = { 1, xi.effect.PROTECT,        7,   20, 1800, false, false },
    [xi.magic.spell.PROTECTRA_II ] = { 2, xi.effect.PROTECT,       27,   50, 1800, false, false },
    [xi.magic.spell.PROTECTRA_III] = { 3, xi.effect.PROTECT,       47,   90, 1800, false, false },
    [xi.magic.spell.PROTECTRA_IV ] = { 4, xi.effect.PROTECT,       63,  140, 1800, false, false },
    [xi.magic.spell.PROTECTRA_V  ] = { 5, xi.effect.PROTECT,       75,  220, 1800, false, false },

    -- Refresh
    [xi.magic.spell.REFRESH      ] = { 1, xi.effect.REFRESH,       41,    3,  150, true,  true  },
    [xi.magic.spell.REFRESH_II   ] = { 2, xi.effect.REFRESH,       82,    6,  150, true,  true  },
    [xi.magic.spell.REFRESH_III  ] = { 3, xi.effect.REFRESH,       99,    9,  150, true,  true  },

    -- Regen
    [xi.magic.spell.REGEN        ] = { 1, xi.effect.REGEN,         21,    5,   75, true,  false },
    [xi.magic.spell.REGEN_II     ] = { 2, xi.effect.REGEN,         44,   12,   60, true,  false },
    [xi.magic.spell.REGEN_III    ] = { 3, xi.effect.REGEN,         66,   20,   60, true,  false },
    [xi.magic.spell.REGEN_IV     ] = { 4, xi.effect.REGEN,         86,   30,   60, true,  false },
    [xi.magic.spell.REGEN_V      ] = { 5, xi.effect.REGEN,         99,   40,   60, true,  false },

    -- Shell / Shellra
    [xi.magic.spell.SHELL        ] = { 1, xi.effect.SHELL,         18, 1055, 1800, false, false },
    [xi.magic.spell.SHELL_II     ] = { 2, xi.effect.SHELL,         37, 1641, 1800, false, false },
    [xi.magic.spell.SHELL_III    ] = { 3, xi.effect.SHELL,         57, 2188, 1800, false, false },
    [xi.magic.spell.SHELL_IV     ] = { 4, xi.effect.SHELL,         68, 2617, 1800, false, false },
    [xi.magic.spell.SHELL_V      ] = { 5, xi.effect.SHELL,         76, 2930, 1800, false, false },
    [xi.magic.spell.SHELLRA      ] = { 1, xi.effect.SHELL,         18, 1055, 1800, false, false },
    [xi.magic.spell.SHELLRA_II   ] = { 2, xi.effect.SHELL,         37, 1641, 1800, false, false },
    [xi.magic.spell.SHELLRA_III  ] = { 3, xi.effect.SHELL,         57, 2188, 1800, false, false },
    [xi.magic.spell.SHELLRA_IV   ] = { 4, xi.effect.SHELL,         68, 2617, 1800, false, false },
    [xi.magic.spell.SHELLRA_V    ] = { 5, xi.effect.SHELL,         75, 2930, 1800, false, false },

    -- -Spikes
    [xi.magic.spell.BLAZE_SPIKES ] = { 1, xi.effect.BLAZE_SPIKES,   1,    0,  180, true,  false },
    [xi.magic.spell.ICE_SPIKES   ] = { 1, xi.effect.ICE_SPIKES,     1,    0,  180, true,  false },
    [xi.magic.spell.SHOCK_SPIKES ] = { 1, xi.effect.SHOCK_SPIKES,   1,    0,  180, true,  false },

    -- -storm
    [xi.magic.spell.AURORASTORM  ] = { 1, xi.effect.AURORASTORM,   48,    2,  180, true,  true  },
    [xi.magic.spell.FIRESTORM    ] = { 1, xi.effect.FIRESTORM,     44,    2,  180, true,  true  },
    [xi.magic.spell.HAILSTORM    ] = { 1, xi.effect.HAILSTORM,     45,    2,  180, true,  true  },
    [xi.magic.spell.RAINSTORM    ] = { 1, xi.effect.RAINSTORM,     42,    2,  180, true,  true  },
    [xi.magic.spell.SANDSTORM    ] = { 1, xi.effect.SANDSTORM,     41,    2,  180, true,  true  },
    [xi.magic.spell.THUNDERSTORM ] = { 1, xi.effect.THUNDERSTORM,  46,    2,  180, true,  true  },
    [xi.magic.spell.VOIDSTORM    ] = { 1, xi.effect.VOIDSTORM,     47,    2,  180, true,  true  },
    [xi.magic.spell.WINDSTORM    ] = { 1, xi.effect.WINDSTORM,     43,    2,  180, true,  true  },

    -- Temper
    [xi.magic.spell.TEMPER       ] = { 1, xi.effect.MULTI_STRIKES, 95,    5,  180, true,  false },
    -- [xi.magic.spell.TEMPER_II    ] = { 2, 0                      , 99,    5,  180, true,  false },
}

xi.spells.parameters.enhancingNinjutsu =
{
-- Structure:            [spellId] = { Tier, Main_Effect, Power, Duration, Always_Overwrite },
    [xi.magic.spell.GEKKA_ICHI   ] = { 1, xi.effect.ENMITY_BOOST,     30, 300, true  },
    [xi.magic.spell.KAKKA_ICHI   ] = { 1, xi.effect.STORE_TP,         10, 180, true  },
    [xi.magic.spell.MIGAWARI_ICHI] = { 1, xi.effect.MIGAWARI,          0,  60, true  },
    [xi.magic.spell.MONOMI_ICHI  ] = { 1, xi.effect.SNEAK,             0, 120, false },
    [xi.magic.spell.MYOSHU_ICHI  ] = { 1, xi.effect.SUBTLE_BLOW_PLUS, 10, 180, true  },
    [xi.magic.spell.TONKO_ICHI   ] = { 1, xi.effect.INVISIBLE,         0, 180, false },
    [xi.magic.spell.TONKO_NI     ] = { 2, xi.effect.INVISIBLE,         0, 300, false },
    [xi.magic.spell.UTSUSEMI_ICHI] = { 1, xi.effect.COPY_IMAGE,        3,   0, false },
    [xi.magic.spell.UTSUSEMI_NI  ] = { 1, xi.effect.COPY_IMAGE,        4,   0, false },
    [xi.magic.spell.UTSUSEMI_SAN ] = { 1, xi.effect.COPY_IMAGE,        5,   0, false },
    [xi.magic.spell.YAIN_ICHI    ] = { 1, xi.effect.PAX,              15, 300, true  },
}

xi.spells.parameters.enhancingSong =
{
--                                          1     2                  3                       4                       5                         6                     7     8    9    10   11  12
-- Structure:                 [spellId] = { Tier, Main Effect,       subEffect,              Main Modifier,          Merit Effect,             Job-Point Effect,     power Scap Pcap Mult Div SVP },
    -- Ballad
    [xi.magic.spell.MAGES_BALLAD      ] = { 1, xi.effect.BALLAD,    xi.mod.AUGMENT_SONG_STAT, xi.mod.BALLAD_EFFECT,   0,                        0,                    1,   0,   1,   1,  0, true  },
    [xi.magic.spell.MAGES_BALLAD_II   ] = { 2, xi.effect.BALLAD,    xi.mod.AUGMENT_SONG_STAT, xi.mod.BALLAD_EFFECT,   0,                        0,                    2,   0,   2,   1,  0, true  },
    [xi.magic.spell.MAGES_BALLAD_III  ] = { 3, xi.effect.BALLAD,    xi.mod.AUGMENT_SONG_STAT, xi.mod.BALLAD_EFFECT,   0,                        0,                    3,   0,   3,   1,  0, true  },
    -- Carol - NOTE: CAROL II Gives a fixed elemental evasion. However, it also gives a Elemental Nullification effect, that follows regular song rules concerning power.
    [xi.magic.spell.FIRE_CAROL        ] = { 1, xi.effect.CAROL,     xi.magic.ele.FIRE,        xi.mod.ETUDE_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.ICE_CAROL         ] = { 1, xi.effect.CAROL,     xi.magic.ele.ICE,         xi.mod.ETUDE_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.WIND_CAROL        ] = { 1, xi.effect.CAROL,     xi.magic.ele.WIND,        xi.mod.ETUDE_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.EARTH_CAROL       ] = { 1, xi.effect.CAROL,     xi.magic.ele.EARTH,       xi.mod.ETUDE_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.LIGHTNING_CAROL   ] = { 1, xi.effect.CAROL,     xi.magic.ele.LIGHTNING,   xi.mod.ETUDE_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.WATER_CAROL       ] = { 1, xi.effect.CAROL,     xi.magic.ele.WATER,       xi.mod.ETUDE_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.LIGHT_CAROL       ] = { 1, xi.effect.CAROL,     xi.magic.ele.LIGHT,       xi.mod.ETUDE_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.DARK_CAROL        ] = { 1, xi.effect.CAROL,     xi.magic.ele.DARK,        xi.mod.ETUDE_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    -- [xi.magic.spell.FIRE_CAROL_II     ] = { 2, xi.effect.CAROL_II,  xi.magic.ele.FIRE,        xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- [xi.magic.spell.ICE_CAROL_II      ] = { 2, xi.effect.CAROL_II,  xi.magic.ele.ICE,         xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- [xi.magic.spell.WIND_CAROL_II     ] = { 2, xi.effect.CAROL_II,  xi.magic.ele.WIND,        xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- [xi.magic.spell.EARTH_CAROL_II    ] = { 2, xi.effect.CAROL_II,  xi.magic.ele.EARTH,       xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- [xi.magic.spell.LIGHTNING_CAROL_II] = { 2, xi.effect.CAROL_II,  xi.magic.ele.LIGHTNING,   xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- [xi.magic.spell.WATER_CAROL_II    ] = { 2, xi.effect.CAROL_II,  xi.magic.ele.WATER,       xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- [xi.magic.spell.LIGHT_CAROL_II    ] = { 2, xi.effect.CAROL_II,  xi.magic.ele.LIGHT,       xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- [xi.magic.spell.DARK_CAROL_II     ] = { 2, xi.effect.CAROL_II,  xi.magic.ele.DARK,        xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- Etude
    [xi.magic.spell.SINEWY_ETUDE      ] = { 1, xi.effect.ETUDE,     xi.mod.STR,               xi.mod.ETUDE_EFFECT,    0,                        0,                    3,   0,   9,   1,  0, true  },
    [xi.magic.spell.DEXTROUS_ETUDE    ] = { 1, xi.effect.ETUDE,     xi.mod.DEX,               xi.mod.ETUDE_EFFECT,    0,                        0,                    3,   0,   9,   1,  0, true  },
    [xi.magic.spell.VIVACIOUS_ETUDE   ] = { 1, xi.effect.ETUDE,     xi.mod.VIT,               xi.mod.ETUDE_EFFECT,    0,                        0,                    3,   0,   9,   1,  0, true  },
    [xi.magic.spell.QUICK_ETUDE       ] = { 1, xi.effect.ETUDE,     xi.mod.AGI,               xi.mod.ETUDE_EFFECT,    0,                        0,                    3,   0,   9,   1,  0, true  },
    [xi.magic.spell.LEARNED_ETUDE     ] = { 1, xi.effect.ETUDE,     xi.mod.INT,               xi.mod.ETUDE_EFFECT,    0,                        0,                    3,   0,   9,   1,  0, true  },
    [xi.magic.spell.SPIRITED_ETUDE    ] = { 1, xi.effect.ETUDE,     xi.mod.MND,               xi.mod.ETUDE_EFFECT,    0,                        0,                    3,   0,   9,   1,  0, true  },
    [xi.magic.spell.ENCHANTING_ETUDE  ] = { 1, xi.effect.ETUDE,     xi.mod.CHR,               xi.mod.ETUDE_EFFECT,    0,                        0,                    3,   0,   9,   1,  0, true  },
    [xi.magic.spell.HERCULEAN_ETUDE   ] = { 2, xi.effect.ETUDE,     xi.mod.STR,               xi.mod.ETUDE_EFFECT,    0,                        0,                   12,   0,  15,   1,  0, true  },
    [xi.magic.spell.UNCANNY_ETUDE     ] = { 2, xi.effect.ETUDE,     xi.mod.DEX,               xi.mod.ETUDE_EFFECT,    0,                        0,                   12,   0,  15,   1,  0, true  },
    [xi.magic.spell.VITAL_ETUDE       ] = { 2, xi.effect.ETUDE,     xi.mod.VIT,               xi.mod.ETUDE_EFFECT,    0,                        0,                   12,   0,  15,   1,  0, true  },
    [xi.magic.spell.SWIFT_ETUDE       ] = { 2, xi.effect.ETUDE,     xi.mod.AGI,               xi.mod.ETUDE_EFFECT,    0,                        0,                   12,   0,  15,   1,  0, true  },
    [xi.magic.spell.SAGE_ETUDE        ] = { 2, xi.effect.ETUDE,     xi.mod.INT,               xi.mod.ETUDE_EFFECT,    0,                        0,                   12,   0,  15,   1,  0, true  },
    [xi.magic.spell.LOGICAL_ETUDE     ] = { 2, xi.effect.ETUDE,     xi.mod.MND,               xi.mod.ETUDE_EFFECT,    0,                        0,                   12,   0,  15,   1,  0, true  },
    [xi.magic.spell.BEWITCHING_ETUDE  ] = { 2, xi.effect.ETUDE,     xi.mod.CHR,               xi.mod.ETUDE_EFFECT,    0,                        0,                   12,   0,  15,   1,  0, true  },
    -- Madrigal: ADMITEDLY MADE UP IN ORIGINAL SCRIPT
    [xi.magic.spell.SWORD_MADRIGAL    ] = { 1, xi.effect.MADRIGAL,  xi.mod.AUGMENT_SONG_STAT, xi.mod.MADRIGAL_EFFECT, xi.merit.MADRIGAL_EFFECT, 0,                    5,  85,  45, 4.5, 18, true  },
    [xi.magic.spell.BLADE_MADRIGAL    ] = { 2, xi.effect.MADRIGAL,  xi.mod.AUGMENT_SONG_STAT, xi.mod.MADRIGAL_EFFECT, xi.merit.MADRIGAL_EFFECT, 0,                    9, 130,  60,   6, 18, true  },
    -- Mambo: ADMITEDLY MADE UP IN ORIGINAL SCRIPT
    [xi.magic.spell.SHEEPFOE_MAMBO    ] = { 1, xi.effect.MAMBO,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MAMBO_EFFECT,    0,                        0,                    5,  85,  48,   5, 18, true  },
    [xi.magic.spell.DRAGONFOE_MAMBO   ] = { 2, xi.effect.MAMBO,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MAMBO_EFFECT,    0,                        0,                    9, 130,  48,   7, 18, true  },
    -- March
    [xi.magic.spell.ADVANCING_MARCH   ] = { 1, xi.effect.MARCH,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MARCH_EFFECT,    0,                        0,                   35, 200, 108,  11,  7, true  },
    [xi.magic.spell.VICTORY_MARCH     ] = { 2, xi.effect.MARCH,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MARCH_EFFECT,    0,                        0,                   43, 300, 163,  16,  7, true  },
    [xi.magic.spell.HONOR_MARCH       ] = { 3, xi.effect.MARCH,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MARCH_EFFECT,    0,                        0,                   24, 400, 126,  12,  7, true  }, -- Not an error. It is weaker.
    -- Minne: Skill Caps unknown?
    [xi.magic.spell.KNIGHTS_MINNE     ] = { 1, xi.effect.MINNE,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    xi.merit.MINNE_EFFECT,    xi.jp.MINNE_EFFECT,   8,   0,  30,   3, 10, true  },
    [xi.magic.spell.KNIGHTS_MINNE_II  ] = { 2, xi.effect.MINNE,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    xi.merit.MINNE_EFFECT,    xi.jp.MINNE_EFFECT,  12,   0,  69,   7, 10, true  },
    [xi.magic.spell.KNIGHTS_MINNE_III ] = { 3, xi.effect.MINNE,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    xi.merit.MINNE_EFFECT,    xi.jp.MINNE_EFFECT,  18,   0, 108,  11, 10, true  },
    [xi.magic.spell.KNIGHTS_MINNE_IV  ] = { 4, xi.effect.MINNE,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    xi.merit.MINNE_EFFECT,    xi.jp.MINNE_EFFECT,  30,   0, 164,  16, 10, true  },
    [xi.magic.spell.KNIGHTS_MINNE_V   ] = { 5, xi.effect.MINNE,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    xi.merit.MINNE_EFFECT,    xi.jp.MINNE_EFFECT,  50,   0, 204,  20, 10, true  },
    -- Minuet
    [xi.magic.spell.VALOR_MINUET      ] = { 1, xi.effect.MINUET,    xi.mod.AUGMENT_SONG_STAT, xi.mod.MINUET_EFFECT,   xi.merit.MINUET_EFFECT,   xi.jp.MINUET_EFFECT,  5,  50,  32,   3,  8, true  },
    [xi.magic.spell.VALOR_MINUET_II   ] = { 2, xi.effect.MINUET,    xi.mod.AUGMENT_SONG_STAT, xi.mod.MINUET_EFFECT,   xi.merit.MINUET_EFFECT,   xi.jp.MINUET_EFFECT, 10, 100,  64,   6,  6, true  },
    [xi.magic.spell.VALOR_MINUET_III  ] = { 3, xi.effect.MINUET,    xi.mod.AUGMENT_SONG_STAT, xi.mod.MINUET_EFFECT,   xi.merit.MINUET_EFFECT,   xi.jp.MINUET_EFFECT, 24, 200,  96,   9,  6, true  },
    [xi.magic.spell.VALOR_MINUET_IV   ] = { 4, xi.effect.MINUET,    xi.mod.AUGMENT_SONG_STAT, xi.mod.MINUET_EFFECT,   xi.merit.MINUET_EFFECT,   xi.jp.MINUET_EFFECT, 31, 300, 112,  11,  6, true  },
    [xi.magic.spell.VALOR_MINUET_V    ] = { 5, xi.effect.MINUET,    xi.mod.AUGMENT_SONG_STAT, xi.mod.MINUET_EFFECT,   xi.merit.MINUET_EFFECT,   xi.jp.MINUET_EFFECT, 32, 500, 124,  12,  6, true  },
    -- Paeon
    [xi.magic.spell.ARMYS_PAEON       ] = { 1, xi.effect.PAEON,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    0,                        0,                    1, 100,   2,   1,  0, true  },
    [xi.magic.spell.ARMYS_PAEON_II    ] = { 2, xi.effect.PAEON,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    0,                        0,                    2, 150,   3,   1,  0, true  },
    [xi.magic.spell.ARMYS_PAEON_III   ] = { 3, xi.effect.PAEON,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    0,                        0,                    3, 200,   4,   1,  0, true  },
    [xi.magic.spell.ARMYS_PAEON_IV    ] = { 4, xi.effect.PAEON,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    0,                        0,                    4, 250,   5,   1,  0, true  },
    [xi.magic.spell.ARMYS_PAEON_V     ] = { 5, xi.effect.PAEON,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    0,                        0,                    5, 350,   7,   1,  0, true  },
    [xi.magic.spell.ARMYS_PAEON_VI    ] = { 6, xi.effect.PAEON,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    0,                        0,                    6, 450,   8,   1,  0, true  },
    -- Prelude
    [xi.magic.spell.HUNTERS_PRELUDE   ] = { 1, xi.effect.PRELUDE,   xi.mod.AUGMENT_SONG_STAT, xi.mod.PRELUDE_EFFECT,  0,                        0,                   10,  85,  45, 4.5, 18, true  },
    [xi.magic.spell.ARCHERS_PRELUDE   ] = { 2, xi.effect.PRELUDE,   xi.mod.AUGMENT_SONG_STAT, xi.mod.PRELUDE_EFFECT,  0,                        0,                   20, 130,  60,   6, 18, true  },
    -- Status effect resistance: Aubade, Capriccio, Gavotte, Operetta, Pastoral,
    [xi.magic.spell.FOWL_AUBADE       ] = { 1, xi.effect.AUBADE,    xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.GOLD_CAPRICCIO    ] = { 1, xi.effect.CAPRICCIO, xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.GOBLIN_GAVOTTE    ] = { 1, xi.effect.GAVOTTE,   xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.SCOPS_OPERETTA    ] = { 1, xi.effect.OPERETTA,  xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.PUPPETS_OPERETTA  ] = { 2, xi.effect.OPERETTA,  xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   40, 200, 120,   8, 10, true  },
    [xi.magic.spell.HERB_PASTORAL     ] = { 1, xi.effect.PASTORAL,  xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.SHINING_FANTASIA  ] = { 1, xi.effect.FANTASIA,  xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.WARDING_ROUND     ] = { 1, xi.effect.ROUND,     xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   20, 200,  80,   8, 10, true  },
    -- Misc.
    [xi.magic.spell.GODDESSS_HYMNUS   ] = { 1, xi.effect.HYMNUS,    xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                    1,   0,   1,   0,  0, false },
    [xi.magic.spell.SENTINELS_SCHERZO ] = { 1, xi.effect.SCHERZO,   xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                    1, 350,  45,   1, 10, false },
    [xi.magic.spell.RAPTOR_MAZURKA    ] = { 1, xi.effect.MAZURKA,   xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   12,   0,  12,   0,  0, false },
    [xi.magic.spell.CHOCOBO_MAZURKA   ] = { 1, xi.effect.MAZURKA,   xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   24,   0,  24,   0,  0, false },

    -- Emnity Songs
    [xi.magic.spell.FOE_SIRVENTE      ] = { 1, xi.effect.SIRVENTE,  xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   35,   0,  35,   1,  0, true  },
    [xi.magic.spell.ADVENTURERS_DIRGE ] = { 1, xi.effect.DIRGE,     xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   32,   0,  32,   0,  0, true  },
}

xi.spells.parameters.teleportSpell =
{
-- Structure:       [spellId] = { Teleport, Key_Item, unknown_parameter, campaign },
    [xi.magic.spell.ESCAPE        ] = { xi.teleport.id.ESCAPE,  0,                                4, false },
    [xi.magic.spell.RECALL_JUGNER ] = { xi.teleport.id.JUGNER,  xi.ki.JUGNER_GATE_CRYSTAL,      4.7, false },
    [xi.magic.spell.RECALL_MERIPH ] = { xi.teleport.id.MERIPH,  xi.ki.MERIPHATAUD_GATE_CRYSTAL, 4.7, false },
    [xi.magic.spell.RECALL_PASHH  ] = { xi.teleport.id.PASHH,   xi.ki.PASHHOW_GATE_CRYSTAL,     4.7, false },
    [xi.magic.spell.RETRACE       ] = { xi.teleport.id.RETRACE, 0,                                4, true  },
    [xi.magic.spell.TELEPORT_ALTEP] = { xi.teleport.id.ALTEP,   xi.ki.ALTEPA_GATE_CRYSTAL,      4.7, false },
    [xi.magic.spell.TELEPORT_DEM  ] = { xi.teleport.id.DEM,     xi.ki.DEM_GATE_CRYSTAL,         4.7, false },
    [xi.magic.spell.TELEPORT_HOLLA] = { xi.teleport.id.HOLLA,   xi.ki.HOLLA_GATE_CRYSTAL,       4.7, false },
    [xi.magic.spell.TELEPORT_MEA  ] = { xi.teleport.id.MEA,     xi.ki.MEA_GATE_CRYSTAL,         4.7, false },
    [xi.magic.spell.TELEPORT_VAHZL] = { xi.teleport.id.VAHZL,   xi.ki.VAHZL_GATE_CRYSTAL,       4.7, false },
    [xi.magic.spell.TELEPORT_YHOAT] = { xi.teleport.id.YHOAT,   xi.ki.YHOATOR_GATE_CRYSTAL,     4.7, false },
    [xi.magic.spell.WARP          ] = { xi.teleport.id.WARP,    0,                                4, false },
    [xi.magic.spell.WARP_II       ] = { xi.teleport.id.WARP,    0,                              3.4, false },
}
