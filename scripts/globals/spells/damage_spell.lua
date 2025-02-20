-----------------------------------
-- Damage Spell Utilities
-- Used for spells that deal direct damage. (Black, White, Dark and Ninjutsu)
-----------------------------------
require('scripts/globals/combat/element_tables')
require('scripts/globals/combat/magic_hit_rate')
require('scripts/globals/jobpoints')
require('scripts/globals/magicburst')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.damage = xi.spells.damage or {}
-----------------------------------
-- File structure:
-- 17 INDEPENDENT functions. Close them for better readability.
-- 1 FINAL function. Uses all 17 previous functions in succession and order.

-----------------------------------
-- Tables
-----------------------------------
local column =
{
    STAT_USED       =  1,
    BONUS_MACC      =  2,
    NPC_POWER       =  3,
    NPC_MULTIPLIER  =  4,
    PC_POWER        =  5,
    INFLEXION_POINT =  6,
    MULTIPLIER_0    =  7,
    MULTIPLIER_50   =  8,
    MULTIPLIER_100  =  9,
    MULTIPLIER_200  = 10,
    MULTIPLIER_300  = 11,
    MULTIPLIER_400  = 12,
    MULTIPLIER_500  = 13,
}

local pTable =
{
-- Single target black magic spells:
--                                       1          2     3     4      5      6    7    8    9     10    11    12    13
-- Structure:             [spellId] = {  Stat used, mAcc, vNPC, mNPC,  vPC,   I,   M0,  M50, M100, M200, M300, M400, M500 },
    [xi.magic.spell.AERO          ] = { xi.mod.INT,    0,   25,    1,   40,  35,  1.6,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.AERO_II       ] = { xi.mod.INT,   10,  113,    1,  140, 133,  2.6,  1.8,    1,    0,    0,    0,    0 },
    [xi.magic.spell.AERO_III      ] = { xi.mod.INT,   20,  265,  1.5,  260, 295,  3.4,  2.8,  1.9,    1,    0,    0,    0 },
    [xi.magic.spell.AERO_IV       ] = { xi.mod.INT,   20,  440,    2,  480, 472,  4.4,  3.8,  2.9, 1.98,    1,    0,    0 },
    [xi.magic.spell.AERO_V        ] = { xi.mod.INT,   25,  738,  2.3,  750, 550,  5.2,  4.5,  3.9, 2.98, 1.98,    1,    0 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.AERO_VI       ] = { xi.mod.INT,    0, 1070,  2.5, 1070, 600,    6,  5.8,  4.8,  3.8,  2.9, 1.98,    1 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.TORNADO       ] = { xi.mod.INT,    0,  552,    2,  700, 577,    2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.TORNADO_II    ] = { xi.mod.INT,   10,  710,    2,  800, 780,    2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.BLIZZARD      ] = { xi.mod.INT,    0,   46,    1,   70,  60,  1.2,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.BLIZZARD_II   ] = { xi.mod.INT,   10,  155,    1,  180, 178,  2.2,  1.6,    1,    0,    0,    0,    0 },
    [xi.magic.spell.BLIZZARD_III  ] = { xi.mod.INT,   20,  320,  1.5,  320, 345,  2.8,  2.6,  1.8,    1,    0,    0,    0 },
    [xi.magic.spell.BLIZZARD_IV   ] = { xi.mod.INT,   20,  506,    2,  560, 541,  3.9,  3.6,  2.8, 1.96,    1,    0,    0 },
    [xi.magic.spell.BLIZZARD_V    ] = { xi.mod.INT,   25,  829,  2.3,  850, 600,  4.4,    4,  3.8, 2.96, 1.96,    1,    0 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.BLIZZARD_VI   ] = { xi.mod.INT,    0, 1190,  2.5, 1190, 650,    5,  5.6,  4.6,  3.6,  2.8, 1.96,    1 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.FREEZE        ] = { xi.mod.INT,    0,  552,    2,  700, 552,    2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.FREEZE_II     ] = { xi.mod.INT,   10,  710,    2,  800, 780,    2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.FIRE          ] = { xi.mod.INT,    0,   35,    1,   55,  46,  1.4,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.FIRE_II       ] = { xi.mod.INT,   10,  133,    1,  160, 155,  2.4,  1.7,    1,    0,    0,    0,    0 },
    [xi.magic.spell.FIRE_III      ] = { xi.mod.INT,   20,  295,  1.5,  290, 320,  3.1,  2.7, 1.85,    1,    0,    0,    0 },
    [xi.magic.spell.FIRE_IV       ] = { xi.mod.INT,   20,  472,    2,  520, 506,  4.2,  3.7, 2.85, 1.97,    1,    0,    0 },
    [xi.magic.spell.FIRE_V        ] = { xi.mod.INT,   25,  785,  2.3,  800, 550,  4.8, 4.24, 3.85, 2.97, 1.97,    1,    0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.FIRE_VI       ] = { xi.mod.INT,    0, 1130,  2.5, 1130, 600,  5.5,  5.7,  4.7,  3.7, 2.85, 1.97,    1 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.FLARE         ] = { xi.mod.INT,    0,  552,    2,  700, 684,    2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.FLARE_II      ] = { xi.mod.INT,   10,  710,    2,  800, 780,    2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.STONE         ] = { xi.mod.INT,    0,   10,    1,   10,  16,    2,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.STONE_II      ] = { xi.mod.INT,   10,   78,    1,  100,  95,    3,    2,    1,    0,    0,    0,    0 },
    [xi.magic.spell.STONE_III     ] = { xi.mod.INT,   20,  210,  1.5,  200, 236,    4,    3,    2,    1,    0,    0,    0 },
    [xi.magic.spell.STONE_IV      ] = { xi.mod.INT,   20,  381,    2,  400, 410,    5,    4,    3,    2,    1,    0,    0 },
    [xi.magic.spell.STONE_V       ] = { xi.mod.INT,   25,  626,  2.3,  650, 500,    6,    5,    4,    3,    2,    1,    0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.STONE_VI      ] = { xi.mod.INT,    0,  950,  2.5,  950, 550,    7,    6,    5,    4,    3,    2,    1 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.QUAKE         ] = { xi.mod.INT,    0,  552,    2,  700, 603,    2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.QUAKE_II      ] = { xi.mod.INT,   10,  710,    2,  800, 780,    2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.THUNDER       ] = { xi.mod.INT,    0,   60,    1,   85,  78,    1,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.THUNDER_II    ] = { xi.mod.INT,   10,  178,    1,  200, 210,    2,  1.5,    1,    0,    0,    0,    0 },
    [xi.magic.spell.THUNDER_III   ] = { xi.mod.INT,   20,  345,  1.5,  350, 381,  2.5,  2.5, 1.75,    1,    0,    0,    0 },
    [xi.magic.spell.THUNDER_IV    ] = { xi.mod.INT,   20,  541,    2,  600, 626,  3.6,  3.5, 2.75, 1.95,    1,    0,    0 },
    [xi.magic.spell.THUNDER_V     ] = { xi.mod.INT,   25,  874,  2.3,  900, 700,    4, 3.74, 3.75, 2.95, 1.95,    1,    0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.THUNDER_VI    ] = { xi.mod.INT,    0, 1250,  2.5, 1250, 750,  4.5,  5.5,  4.5,  3.5, 2.75, 1.95,    1 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.BURST         ] = { xi.mod.INT,    0,  552,    2,  700, 630,    2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.BURST_II      ] = { xi.mod.INT,   10,  710,    2,  800, 780,    2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.WATER         ] = { xi.mod.INT,    0,   16,    1,   25,  25,  1.8,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.WATER_II      ] = { xi.mod.INT,   10,   95,    1,  120, 113,  2.8,  1.9,    1,    0,    0,    0,    0 },
    [xi.magic.spell.WATER_III     ] = { xi.mod.INT,   20,  236,  1.5,  230, 265,  3.7,  2.9, 1.95,    1,    0,    0,    0 },
    [xi.magic.spell.WATER_IV      ] = { xi.mod.INT,   20,  410,    2,  440, 440,  4.7,  3.9, 2.95, 1.99,    1,    0,    0 },
    [xi.magic.spell.WATER_V       ] = { xi.mod.INT,   25,  680,  2.3,  700, 500,  5.6, 4.74, 3.95, 2.99, 1.99,    1,    0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.WATER_VI      ] = { xi.mod.INT,    0, 1010,  1.5, 1010, 550,  6.5,  5.9,  4.9,  3.9, 2.95, 1.99,    1 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.FLOOD         ] = { xi.mod.INT,    0,  552,    2,  700, 657,    2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.FLOOD_II      ] = { xi.mod.INT,   10,  710,    2,  800, 780,    2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.COMET         ] = { xi.mod.INT,    0,  964,  2.3, 1000, 850,    4, 3.75,  3.5,    3,    2,    1,    1 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.DEATH         ] = {          0,    0,   32,    0,   32,   0,    0,    0,    0,    0,    0,    0,    0 },

    -- Helixes (Initial damage) https://www.bluegartr.com/threads/108196-Random-Facts-Thread-Magic?p=6817880&viewfull=1#post6817880
    [xi.magic.spell.GEOHELIX      ] = { xi.mod.INT,    0,   35,    1,   31, 100,    1,    1,  0.5,    0,    0,    0,    0 },
    [xi.magic.spell.GEOHELIX_II   ] = { xi.mod.INT,    0,   75,    2,   75, 100,    2,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.HYDROHELIX    ] = { xi.mod.INT,    0,   35,    1,   31, 100,    1,    1,  0.5,    0,    0,    0,    0 },
    [xi.magic.spell.HYDROHELIX_II ] = { xi.mod.INT,    0,   75,    2,   75, 100,    2,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.ANEMOHELIX    ] = { xi.mod.INT,    0,   35,    1,   31, 100,    1,    1,  0.5,    0,    0,    0,    0 },
    [xi.magic.spell.ANEMOHELIX_II ] = { xi.mod.INT,    0,   75,    2,   75, 100,    2,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.PYROHELIX     ] = { xi.mod.INT,    0,   35,    1,   31, 100,    1,    1,  0.5,    0,    0,    0,    0 },
    [xi.magic.spell.PYROHELIX_II  ] = { xi.mod.INT,    0,   75,    2,   75, 100,    2,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.CRYOHELIX     ] = { xi.mod.INT,    0,   35,    1,   31, 100,    1,    1,  0.5,    0,    0,    0,    0 },
    [xi.magic.spell.CRYOHELIX_II  ] = { xi.mod.INT,    0,   75,    2,   75, 100,    2,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.IONOHELIX     ] = { xi.mod.INT,    0,   35,    1,   31, 100,    1,    1,  0.5,    0,    0,    0,    0 },
    [xi.magic.spell.IONOHELIX_II  ] = { xi.mod.INT,    0,   75,    2,   75, 100,    2,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.NOCTOHELIX    ] = { xi.mod.INT,    0,   35,    1,   31, 100,    1,    1,  0.5,    0,    0,    0,    0 },
    [xi.magic.spell.NOCTOHELIX_II ] = { xi.mod.INT,    0,   75,    2,   75, 100,    2,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.LUMINOHELIX   ] = { xi.mod.INT,    0,   35,    1,   31, 100,    1,    1,  0.5,    0,    0,    0,    0 },
    [xi.magic.spell.LUMINOHELIX_II] = { xi.mod.INT,    0,   75,    2,   75, 100,    2,    1,    0,    0,    0,    0,    0 },

-- Multiple target spells:
--                                       1          2     3     4      5      6    7    8    9     10    11    12    13
-- Structure:             [spellId] = {  Stat used, mAcc, vNPC, mNPC,  vPC,   I,   M0,  M50, M100, M200, M300, M400, M500 },
    [xi.magic.spell.AEROGA        ] = { xi.mod.INT,    0,   93,    1,  100, 120,  2.6,  1.8,    1,    0,    0,    0,    0 },
    [xi.magic.spell.AEROGA_II     ] = { xi.mod.INT,    0,  266,    1,  310, 312,  3.4,  2.8,  1.9,    1,    0,    0,    0 },
    [xi.magic.spell.AEROGA_III    ] = { xi.mod.INT,    0,  527,  1.5,  580, 642,  4.4,  3.8,  2.9, 1.98,    1,    0,    0 },
    [xi.magic.spell.AEROGA_IV     ] = { xi.mod.INT,    0,  738,    2,    0, 700,    1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Aero V.
    [xi.magic.spell.AEROGA_V      ] = { xi.mod.INT,    0, 1070,  2.3,    0, 750,    1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Aero VI.
    [xi.magic.spell.AERA          ] = { xi.mod.INT,    0,  210,    1,  210, 250,  2.6,  1.8,    1,    0,    0,    0,    0 },
    [xi.magic.spell.AERA_II       ] = { xi.mod.INT,    0,  430,    1,  430, 600,  3.4,  2.8,  1.9,    1,    0,    0,    0 },
    [xi.magic.spell.AERA_III      ] = { xi.mod.INT,    0,  710,  1.5,  710, 700,  4.4,  3.8,  2.9, 1.98,    1,    0,    0 }, -- No info found. Since Aera I and II N Values coincided with Aeroga 1 and II, used Values of Aeroga III.
    [xi.magic.spell.AEROJA        ] = { xi.mod.INT,    0,  844,  2.3,  850, 800,  5.2,  4.5,  3.9,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.BLIZZAGA      ] = { xi.mod.INT,    0,  145,    1,  160, 172,  2.2,  1.6,    1,    0,    0,    0,    0 },
    [xi.magic.spell.BLIZZAGA_II   ] = { xi.mod.INT,    0,  350,    1,  370, 392,  2.8,  2.6,  1.8,    1,    0,    0,    0 },
    [xi.magic.spell.BLIZZAGA_III  ] = { xi.mod.INT,    0,  642,  1.5,  660, 697,  3.9,  3.6,  2.8, 1.96,    1,    0,    0 },
    [xi.magic.spell.BLIZZAGA_IV   ] = { xi.mod.INT,    0,  829,    2,    0, 800,    1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Blizzard V.
    [xi.magic.spell.BLIZZAGA_V    ] = { xi.mod.INT,    0, 1190,  2.3,    0, 950,    1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Blizzard VI.
    [xi.magic.spell.BLIZZARA      ] = { xi.mod.INT,    0,  270,    1,  270, 300,  2.2,  1.6,    1,    0,    0,    0,    0 },
    [xi.magic.spell.BLIZZARA_II   ] = { xi.mod.INT,    0,  510,    1,  510, 550,  2.8,  2.6,  1.8,    1,    0,    0,    0 },
    [xi.magic.spell.BLIZZARA_III  ] = { xi.mod.INT,    0,  830,  1.5,  830, 850,  3.9,  3.6,  2.8, 1.96,    1,    0,    0 }, -- No info found. Since Blizzara I and II N Values coincided with Blizzaga 1 and II, used Values of Blizzaga III.
    [xi.magic.spell.BLIZZAJA      ] = { xi.mod.INT,    0,  953,  2.3,  950, 950,  4.4,    4,  3.8,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.FIRAGA        ] = { xi.mod.INT,    0,  120,    1,  120, 145,  2.4,  1.7,    1,    0,    0,    0,    0 },
    [xi.magic.spell.FIRAGA_II     ] = { xi.mod.INT,    0,  312,    1,  340, 350,  3.1,  2.7, 1.85,    1,    0,    0,    0 },
    [xi.magic.spell.FIRAGA_III    ] = { xi.mod.INT,    0,  589,  1.5,  620, 642,  4.2,  3.7, 2.85, 1.97,    1,    0,    0 },
    [xi.magic.spell.FIRAGA_IV     ] = { xi.mod.INT,    0,  785,    2,    0, 700,    1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Fire V.
    [xi.magic.spell.FIRAGA_V      ] = { xi.mod.INT,    0, 1130,  2.3,    0, 800,    1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Fire VI.
    [xi.magic.spell.FIRA          ] = { xi.mod.INT,    0,  240,    1,  240, 250,  2.4,  1.7,    1,    0,    0,    0,    0 },
    [xi.magic.spell.FIRA_II       ] = { xi.mod.INT,    0,  470,    1,  470, 500,  3.1,  2.7, 1.85,    1,    0,    0,    0 },
    [xi.magic.spell.FIRA_III      ] = { xi.mod.INT,    0,  760,  1.5,  760, 800,  4.2,  3.7, 2.85, 1.97,    1,    0,    0 }, -- No info found. Since Fira I and II N Values coincided with Firaga 1 and II, used Values of Firaga III.
    [xi.magic.spell.FIRAJA        ] = { xi.mod.INT,    0,  902,  2.3,  900, 950,  4.8, 4.25, 3.85,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.STONEGA       ] = { xi.mod.INT,    0,   56,    1,   60,  74,    3,    2,    1,    0,    0,    0,    0 },
    [xi.magic.spell.STONEGA_II    ] = { xi.mod.INT,    0,  201,    1,  250, 232,    4,    3,    2,    1,    0,    0,    0 },
    [xi.magic.spell.STONEGA_III   ] = { xi.mod.INT,    0,  434,  1.5,  500, 480,    5,    4,    3,    2,    1,    0,    0 },
    [xi.magic.spell.STONEGA_IV    ] = { xi.mod.INT,    0,  626,    2,    0, 650,    1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Stone V.
    [xi.magic.spell.STONEGA_V     ] = { xi.mod.INT,    0,  950,  2.3,    0, 950,    1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Stone VI.
    [xi.magic.spell.STONERA       ] = { xi.mod.INT,    0,  150,    1,  150, 150,    3,    2,    1,    0,    0,    0,    0 },
    [xi.magic.spell.STONERA_II    ] = { xi.mod.INT,    0,  350,    1,  350, 350,    4,    3,    2,    1,    0,    0,    0 },
    [xi.magic.spell.STONERA_III   ] = { xi.mod.INT,    0,  650,  1.5,  650, 650,    5,    4,    3,    2,    1,    0,    0 }, -- No info found. Since Stonera I and II N Values coincided with Stonega 1 and II, used Values of Stonega III.
    [xi.magic.spell.STONEJA       ] = { xi.mod.INT,    0,  719,  2.3,  750, 750,    6,    5,    4,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.THUNDAGA      ] = { xi.mod.INT,    0,  172,    1,  200, 201,    2,  1.5,    1,    0,    0,    0,    0 },
    [xi.magic.spell.THUNDAGA_II   ] = { xi.mod.INT,    0,  392,    1,  400, 434,  2.5,  2.5, 1.75,    1,    0,    0,    0 },
    [xi.magic.spell.THUNDAGA_III  ] = { xi.mod.INT,    0,  697,  1.5,  700, 719,  3.6,  3.5, 2.75, 1.95,    1,    0,    0 },
    [xi.magic.spell.THUNDAGA_IV   ] = { xi.mod.INT,    0,  874,    2,    0, 900,    1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Thunder V.
    [xi.magic.spell.THUNDAGA_V    ] = { xi.mod.INT,    0, 1250,  2.3,    0, 999,    1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Thunder VI.
    [xi.magic.spell.THUNDARA      ] = { xi.mod.INT,    0,  300,    1,  300, 300,    2,  1.5,    1,    0,    0,    0,    0 },
    [xi.magic.spell.THUNDARA_II   ] = { xi.mod.INT,    0,  550,    1,  550, 550,  2.5,  2.5, 1.75,    1,    0,    0,    0 },
    [xi.magic.spell.THUNDARA_III  ] = { xi.mod.INT,    0,  900,  1.5,  900, 900,  3.6,  3.5, 2.75, 1.95,    1,    0,    0 }, -- No info found. Since Thundara I and II N Values coincided with Thundaga 1 and II, used Values of Thundaga III.
    [xi.magic.spell.THUNDAJA      ] = { xi.mod.INT,    0, 1005,  2.3, 1000, 999,    4, 3.75, 3.75,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.WATERGA       ] = { xi.mod.INT,    0,   74,    1,   80,  96,  2.8,  1.9,    1,    0,    0,    0,    0 },
    [xi.magic.spell.WATERGA_II    ] = { xi.mod.INT,    0,  232,    1,  280, 266,  3.7,  2.9, 1.95,    1,    0,    0,    0 },
    [xi.magic.spell.WATERGA_III   ] = { xi.mod.INT,    0,  480,  1.5,  540, 527,  4.7,  3.9, 2.95, 1.99,    1,    0,    0 },
    [xi.magic.spell.WATERGA_IV    ] = { xi.mod.INT,    0,  680,    2,    0, 700,    1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Water V.
    [xi.magic.spell.WATERGA_V     ] = { xi.mod.INT,    0, 1010,  2.3,    0, 900,    1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Water VI.
    [xi.magic.spell.WATERA        ] = { xi.mod.INT,    0,  180,    1,  180, 200,  2.8,  1.9,    1,    0,    0,    0,    0 },
    [xi.magic.spell.WATERA_II     ] = { xi.mod.INT,    0,  390,    1,  390, 400,  3.7,  2.9, 1.95,    1,    0,    0,    0 },
    [xi.magic.spell.WATERA_III    ] = { xi.mod.INT,    0,  660,  1.5,  660, 700,  4.7,  3.9, 2.95, 1.99,    1,    0,    0 }, -- No info found. Since Watera I and II N Values coincided with Waterga 1 and II, used Values of Waterga III.
    [xi.magic.spell.WATERJA       ] = { xi.mod.INT,    0,  782,  2.3,  800, 900,  5.6, 4.75, 3.95,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.

-- Ninjutsu spells: https://www.ffxiah.com/forum/topic/56749/updated-ninjutsu-damage-formulae/
--                                       1          2     3        4   5      6  7
-- Structure:             [spellId] = {  Stat used, mAcc, vNPC,    M,  vPC,   I, M0 },
    [xi.magic.spell.DOTON_ICHI    ] = { xi.mod.INT,    0,   16,    1,   16,  25, 0 },
    [xi.magic.spell.DOTON_NI      ] = { xi.mod.INT,    0,   69,    1,   69, 113, 0 },
    [xi.magic.spell.DOTON_SAN     ] = { xi.mod.INT,    0,  134,    2,  134, 118, 0 },
    [xi.magic.spell.HUTON_ICHI    ] = { xi.mod.INT,    0,   16,    1,   16,  25, 0 },
    [xi.magic.spell.HUTON_NI      ] = { xi.mod.INT,    0,   69,    1,   69, 113, 0 },
    [xi.magic.spell.HUTON_SAN     ] = { xi.mod.INT,    0,  134,    2,  134, 118, 0 },
    [xi.magic.spell.HYOTON_ICHI   ] = { xi.mod.INT,    0,   16,    1,   16,  25, 0 },
    [xi.magic.spell.HYOTON_NI     ] = { xi.mod.INT,    0,   69,    1,   69, 113, 0 },
    [xi.magic.spell.HYOTON_SAN    ] = { xi.mod.INT,    0,  134,    2,  134, 118, 0 },
    [xi.magic.spell.KATON_ICHI    ] = { xi.mod.INT,    0,   16,    1,   16,  25, 0 },
    [xi.magic.spell.KATON_NI      ] = { xi.mod.INT,    0,   69,    1,   69, 113, 0 },
    [xi.magic.spell.KATON_SAN     ] = { xi.mod.INT,    0,  134,    2,  134, 118, 0 },
    [xi.magic.spell.RAITON_ICHI   ] = { xi.mod.INT,    0,   16,    1,   16,  25, 0 },
    [xi.magic.spell.RAITON_NI     ] = { xi.mod.INT,    0,   69,    1,   69, 113, 0 },
    [xi.magic.spell.RAITON_SAN    ] = { xi.mod.INT,    0,  134,    2,  134, 118, 0 },
    [xi.magic.spell.SUITON_ICHI   ] = { xi.mod.INT,    0,   16,    1,   16,  25, 0 },
    [xi.magic.spell.SUITON_NI     ] = { xi.mod.INT,    0,   69,    1,   69, 113, 0 },
    [xi.magic.spell.SUITON_SAN    ] = { xi.mod.INT,    0,  134,    2,  134, 118, 0 },

-- Divine spells: https://nw6yx36onohv5j6wmzoba3nllq-ac4c6men2g7xr2a-wiki-ffo-jp.translate.goog/html/1963.html
--                                       1          2     3        4   5      6  7
-- Structure:             [spellId] = {  Stat used, mAcc, vNPC,    M,  vPC,   I, M0 },
    [xi.magic.spell.BANISH        ] = { xi.mod.MND,    0,   14,    1,   14,  25, 0 },
    [xi.magic.spell.BANISH_II     ] = { xi.mod.MND,    0,   85,    1,   85, 113, 0 },
    [xi.magic.spell.BANISH_III    ] = { xi.mod.MND,    0,  198,  1.5,  198, 250, 0 },
    [xi.magic.spell.BANISH_IV     ] = { xi.mod.MND,    0,  420,  1.5,  420, 400, 0 }, -- Enemy only. Stats unknown/unchecked.
    [xi.magic.spell.BANISHGA      ] = { xi.mod.MND,    0,   50,    1,   50,  46, 0 },
    [xi.magic.spell.BANISHGA_II   ] = { xi.mod.MND,    0,  180,    1,  180, 133, 0 },
    [xi.magic.spell.BANISHGA_III  ] = { xi.mod.MND,    0,  480,  1.5,  480, 450, 0 }, -- Enemy only. Stats unknown.
    [xi.magic.spell.BANISHGA_IV   ] = { xi.mod.MND,    0,  600,  1.5,  600, 600, 0 }, -- Enemy only. Stats unknown.
    [xi.magic.spell.HOLY          ] = { xi.mod.MND,    0,  125,    1,  125, 150, 0 },
    [xi.magic.spell.HOLY_II       ] = { xi.mod.MND,    0,  250,    2,  250, 300, 0 },

-- Dark spells.
--                                       1          2     3     4      5      6    7    8    9     10    11    12    13
-- Structure:             [spellId] = {  Stat used, mAcc, vNPC, mNPC,  vPC,   I,   M0,  M50, M100, M200, M300, M400, M500 },
    [xi.magic.spell.KAUSTRA       ] = { xi.mod.INT,    0,    0, 0.67,    0, 300, 0.67, 0.67, 0.67, 0.67,    0,    0,    0 },

-- Healing Spells when used against undead/zombie: https://wiki.ffo.jp/html/336.html
-- Structure:             [spellId] = {  Stat used, mAcc, vNPC,    M,  vPC,   I, M0 },
    [xi.magic.spell.CURE          ] = { xi.mod.MND,    0,    7,    1,    7,  16, 0 },
    [xi.magic.spell.CURE_II       ] = { xi.mod.MND,    0,   35,    1,   35,  60, 0 },
    [xi.magic.spell.CURE_III      ] = { xi.mod.MND,    0,   70,    1,   70, 133, 0 },
    [xi.magic.spell.CURE_IV       ] = { xi.mod.MND,    0,  140,  1.5,  140, 104, 0 }, -- Not a typo. Both Inflexion point and upper cap by extension are lower than Cure III.
    [xi.magic.spell.CURE_V        ] = { xi.mod.MND,    0,  210,  1.5,  210, 159, 0 },
    [xi.magic.spell.CURE_VI       ] = { xi.mod.MND,    0,  295,    2,  295, 212, 0 },
}

local function cardinalChantBonus(actor, target, direction, spellId, skillType)
    -- https://www.bg-wiki.com/ffxi/Cardinal_Chant
    local chantBonus = 0

    -- Early return
    if spellId == 0 or skillType ~= xi.skill.ELEMENTAL_MAGIC then
        return chantBonus
    end

    -- Calculate base bonus.
    local raSpellTable =
    set{
        xi.magic.spell.STONERA,  xi.magic.spell.STONERA_II,  xi.magic.spell.STONERA_III,
        xi.magic.spell.WATERA,   xi.magic.spell.WATERA_II,   xi.magic.spell.WATERA_III,
        xi.magic.spell.AERA,     xi.magic.spell.AERA_II,     xi.magic.spell.AERA_III,
        xi.magic.spell.FIRA,     xi.magic.spell.FIRA_II,     xi.magic.spell.FIRA_III,
        xi.magic.spell.BLIZZARA, xi.magic.spell.BLIZZARA_II, xi.magic.spell.BLIZZARA_III,
        xi.magic.spell.THUNDARA, xi.magic.spell.THUNDARA_II, xi.magic.spell.THUNDARA_III,
    }

    local chantTable =
    {
        [0] = { [xi.direction.EAST] = {  0,  0 }, [xi.direction.SOUTH] = {  0,  0 }, [xi.direction.WEST] = {  0,  0 }, [xi.direction.NORTH] = {  0,  0 } },
        [1] = { [xi.direction.EAST] = {  5,  8 }, [xi.direction.SOUTH] = {  5,  8 }, [xi.direction.WEST] = { 10, 15 }, [xi.direction.NORTH] = {  5,  8 } },
        [2] = { [xi.direction.EAST] = {  7, 10 }, [xi.direction.SOUTH] = {  7, 10 }, [xi.direction.WEST] = { 14, 19 }, [xi.direction.NORTH] = {  7, 10 } },
        [3] = { [xi.direction.EAST] = { 10, 14 }, [xi.direction.SOUTH] = { 10, 14 }, [xi.direction.WEST] = { 18, 24 }, [xi.direction.NORTH] = { 10, 14 } },
        [4] = { [xi.direction.EAST] = { 13, 17 }, [xi.direction.SOUTH] = { 13, 17 }, [xi.direction.WEST] = { 22, 28 }, [xi.direction.NORTH] = { 13, 17 } },
    }

    local isRaSpell = raSpellTable[spellId] and 2 or 1
    local baseBonus = chantTable[actor:getMod(xi.mod.CARDINAL_CHANT)][direction][isRaSpell]

    -- Calculate fervor %
    local fervorFactor = actor:hasStatusEffect(xi.effect.COLLIMATED_FERVOR) and 1.5 or 1

    -- Calculate gear %
    local gearFactor = 1 + actor:getMod(xi.mod.CARDINAL_CHANT_BONUS) / 100

    -- Calculate angle %
    local angle       = utils.getWorldRotation(actor:getPos(), target:getPos())
    local angleFactor = 0

    switch (direction) : caseof
    {
        [xi.direction.EAST] = function() -- MAB -> Optimal angle = 0
            if angle > 192 and angle < 256 then
                angleFactor = 1 - (256 - angle) / 64
            elseif angle >= 0 and angle < 64 then
                angleFactor = 1 - angle / 64
            end
        end,

        [xi.direction.SOUTH] = function() -- MACC -> Optimal angle = 64
            if angle > 0 and angle < 64 then
                angleFactor = 1 - (64 - angle) / 64
            elseif angle >= 64 and angle < 128 then
                angleFactor = 1 - (angle - 64) / 64
            end
        end,

        [xi.direction.WEST] = function() -- MBB -> Optimal angle = 128
            if angle > 64 and angle < 128 then
                angleFactor = 1 - (128 - angle) / 64
            elseif angle >= 128 and angle < 192 then
                angleFactor = 1 - (angle - 128) / 64
            end
        end,

        [xi.direction.NORTH] = function() -- M.Crit -> Optimal angle = 192
            if angle > 128 and angle < 192 then
                angleFactor = 1 - (192 - angle) / 64
            elseif angle >= 192 and angle < 256 then
                angleFactor = 1 - (angle - 192) / 64
            end
        end,
    }

    chantBonus = math.floor(baseBonus * fervorFactor * gearFactor * angleFactor)

    return chantBonus
end

-----------------------------------
-- Basic Functions
-----------------------------------
xi.spells.damage.calculateBaseDamage = function(caster, target, spellId, spellGroup, skillType, statUsed)
    local spellDamage  = 0 -- The variable we want to calculate
    local useNewSystem = false -- Default to old.

    -- Choose system to use.
    if
        pTable[spellId][column.MULTIPLIER_0] > 0 and -- We actually have new system values.
        caster:isPC() and                            -- Only players use new system.
        not xi.settings.main.USE_OLD_MAGIC_DAMAGE    -- New system is allowed in settings.
    then
        useNewSystem = true -- Use new system.
    end

    -----------------------------------
    -- STEP 1: baseSpellDamage (V)
    -----------------------------------
    local baseSpellDamage = pTable[spellId][column.NPC_POWER] -- (V) In Wiki.

    if useNewSystem then
        baseSpellDamage = pTable[spellId][column.PC_POWER] -- vPC
    end

    -----------------------------------
    -- STEP 2: statDiffBonus (statDiff * M)
    -----------------------------------
    local statDiffBonus = 0 -- statDiff x appropriate multipliers.
    local statDiff      = caster:getStat(statUsed) - target:getStat(statUsed)

    -- New System
    if useNewSystem then
        local mTable =
        {
            [1] = {   0,  50 },
            [2] = {  50,  50 },
            [3] = { 100, 100 },
            [4] = { 200, 100 },
            [5] = { 300, 100 },
            [6] = { 400, 100 },
            [7] = { 500, 100 },
        }

        for i = 1, 7 do
            statDiffBonus = statDiffBonus + math.floor(utils.clamp(statDiff - mTable[i][1], 0, mTable[i][2]) * pTable[spellId][column.INFLEXION_POINT + i])
        end

    -- Old system
    else
        local spellMultiplier = pTable[spellId][column.NPC_MULTIPLIER]  -- M
        local inflexionPoint  = pTable[spellId][column.INFLEXION_POINT] -- I

        -- Cap stat difference. In the old system, in 99% of cases, the stat difference capped at 3 times the infexion point, from which point, stat would stop taking effect.
        local statCap = 3 * inflexionPoint

        statDiff = math.min(statDiff, statCap)

        -- Operations.
        if statDiff <= 0 then
            statDiffBonus = statDiff
        elseif statDiff <= inflexionPoint then
            statDiffBonus = math.floor(statDiff * spellMultiplier)
        else
            statDiffBonus = math.floor(inflexionPoint * spellMultiplier) + math.floor((statDiff - inflexionPoint) * spellMultiplier / 2)
        end
    end

    -----------------------------------
    -- STEP 3: baseSpellDamageBonus (mDMG)
    -----------------------------------
    local baseSpellDamageBonus = 0 -- (mDMG) In Wiki. Get from equipment, status, etc

    if caster:isPC() then
        -- BLM Job Point: Manafont Elemental Magic Damage +3
        if caster:hasStatusEffect(xi.effect.MANAFONT) then
            baseSpellDamageBonus = baseSpellDamageBonus + caster:getJobPointLevel(xi.jp.MANAFONT_EFFECT) * 3
        end

        -- BLM Job Point: With Manawell mDMG +1
        if caster:hasStatusEffect(xi.effect.MANAWELL) then
            baseSpellDamageBonus = baseSpellDamageBonus + caster:getJobPointLevel(xi.jp.MANAWELL_EFFECT)
            caster:delStatusEffectSilent(xi.effect.MANAWELL)
        end

        -- BLM Job Point: Magic Damage Bonus
        if caster:getMainJob() == xi.job.BLM then
            baseSpellDamageBonus = baseSpellDamageBonus + caster:getJobPointLevel(xi.jp.MAGIC_DMG_BONUS)
        end

        -- NIN Job Point: Elemental Ninjutsu Effect
        if skillType == xi.skill.NINJUTSU then
            baseSpellDamageBonus = baseSpellDamageBonus + caster:getJobPointLevel(xi.jp.ELEM_NINJITSU_EFFECT) * 2
        end

        -- SCH Job Point: Stratagem Effect III
        if
            (spellGroup == xi.magic.spellGroup.WHITE and caster:hasStatusEffect(xi.effect.RAPTURE)) or
            (spellGroup == xi.magic.spellGroup.BLACK and caster:hasStatusEffect(xi.effect.EBULLIENCE))
        then
            baseSpellDamageBonus = baseSpellDamageBonus + caster:getJobPointLevel(xi.jp.STRATEGEM_EFFECT_III) * 2
        end
    end

    -- Bonus to spell base damage from gear.
    baseSpellDamageBonus = baseSpellDamageBonus + caster:getMod(xi.mod.MAGIC_DAMAGE)

    -----------------------------------
    -- STEP 4: Spell Damage
    -----------------------------------
    spellDamage = baseSpellDamage + baseSpellDamageBonus + statDiffBonus

    -----------------------------------
    -- STEP 5: Exceptions
    -----------------------------------
    -- Death
    if spellId == xi.magic.spell.DEATH then
        spellDamage = baseSpellDamage + caster:getMP() * 3

    -- Helix-spells
    elseif
        (spellId >= xi.magic.spell.GEOHELIX and spellId <= xi.magic.spell.LUMINOHELIX) or
        (spellId >= xi.magic.spell.GEOHELIX_II and spellId <= xi.magic.spell.LUMINOHELIX_II)
    then
        spellDamage = spellDamage + caster:getMod(xi.mod.HELIX_EFFECT)

    -- Kaustra
    elseif spellId == xi.magic.spell.KAUSTRA then
        baseSpellDamage = math.floor(caster:getMainLvl() * 0.67) / 10
        statDiffBonus   = math.floor(statDiffBonus)

        spellDamage = math.floor(baseSpellDamage * (baseSpellDamageBonus + statDiffBonus))
    end

    return utils.clamp(spellDamage, 0, 99999)
end

-- Calculate: Multiple Target Damage Reduction (MTDR)
xi.spells.damage.calculateMTDR = function(spell)
    local multipleTargetReduction = 1 -- The variable we want to calculate.
    local targets                 = spell:getTotalTargets()

    if targets > 1 then
        if targets > 1 and targets < 10 then
            multipleTargetReduction = 0.9 - 0.05 * targets
        else
            multipleTargetReduction = 0.4
        end
    end

    return multipleTargetReduction
end

xi.spells.damage.calculateElementalStaffBonus = function(caster, spellElement)
    local elementalStaffBonus = 1

    if spellElement > xi.element.NONE then
        elementalStaffBonus = elementalStaffBonus + caster:getMod(xi.combat.element.getElementalAffinityDMGModifier(spellElement)) * 0.05
    end

    return elementalStaffBonus
end

xi.spells.damage.calculateMagianAffinity = function()
    -- TODO: IMPLEMENT MAGIAN TRIALS AFFINITY SYSTEM, which could be as simple as introducing a new modifier. Out of the scope of this rewrite, for now
    local magianAffinity = 1

    -- TODO: Code Magian Trials affinity.
    -- TODO: ADD (because it's additive) bonuses from atmas. Also, not sure the current affinity mod is the ACTUAL "affinity" mod as understood in wikis.

    return magianAffinity
end

-- Elemental Specific Damage Taken (Elemental SDT)
-- SDT (Species/Specific Damage Taken) is a stat/mod present in mobs and players that applies a % to specific damage types.
-- Each of the 8 elements has an SDT modifier (Modifiers 54 to 61. Check script(globals/status.lua)
-- Mob elemental modifiers are populated by the values set in "mob_resistances.sql" (The database). SDT columns.
-- The value of the modifiers are base 10000. Positive numbers mean less damage taken. Negative mean more damage taken.
-- Examples:
-- A value of 5000 -> 50% LESS damage taken.
-- A value of -5000 -> 50% MORE damage taken.
-- A word on SDT as understood in some wikis, even if they are refering to resistance and not actual SDT
-- SDT under 50% applies a flat 1/2 *, which was for a long time confused with an additional resist tier, which, in reality, its an independent multiplier.
-- This is understandable, because in a way, it is effectively a whole tier, but recent testing with skillchains/magic bursts after resist was removed from them, proved this.
-- SDT affects magic burst damage, but never in a "negative" way.
-- https://www.bg-wiki.com/ffxi/Resist for some SDT info.
-- *perhaps this simply means there is a cap/clamp limiting it there.
xi.spells.damage.calculateSDT = function(target, spellElement)
    local sdt = 1 -- The variable we want to calculate

    if spellElement > xi.element.NONE then
        sdt = 1 - target:getMod(xi.combat.element.getElementalSDTModifier(spellElement)) / 10000
    end

    return utils.clamp(sdt, 0, 3)
end

xi.spells.damage.calculateAdditionalResistTier = function(caster, target, spellElement)
    local additionalResistTier = 1

    if
        not caster:hasStatusEffect(xi.effect.SUBTLE_SORCERY) and                               -- Subtle sorcery bypasses this tier.
        target:getMod(xi.combat.element.getElementalResistanceRankModifier(spellElement)) >= 4 -- Forced only at and after rank 4 (50% EEM).
    then
        additionalResistTier = additionalResistTier / 2
    end

    return additionalResistTier
end

xi.spells.damage.calculateDayAndWeather = function(caster, spellId, spellElement)
    local dayAndWeather = 1 -- The variable we want to calculate

    -- Return if no/incorrect element.
    if spellElement <= xi.element.NONE then
        return dayAndWeather
    end

    local weather      = caster:getWeather()
    local dayElement   = VanadielDayElement()
    local isHelixSpell = false -- TODO: I'm not sure thats the correct way to handle helixes. This is how we handle it and im not gonna change it for now.

    -- See if its a Helix type spell
    if
        (spellId >= xi.magic.spell.GEOHELIX and spellId <= xi.magic.spell.LUMINOHELIX) or
        (spellId >= xi.magic.spell.GEOHELIX_II and spellId <= xi.magic.spell.LUMINOHELIX_II)
    then
        isHelixSpell = true
    end

    -- Calculate Weather bonus + Iridescence bonus.
    if
        math.random(1, 100) <= 33 or
        caster:getMod(xi.combat.element.getForcedDayOrWeatherBonusModifier(spellElement)) >= 1 or
        isHelixSpell
    then
        -- Strong weathers.
        if weather == xi.combat.element.getAssociatedSingleWeather(spellElement) then
            dayAndWeather = dayAndWeather + 0.1 + caster:getMod(xi.mod.IRIDESCENCE) * 0.05
        elseif weather == xi.combat.element.getAssociatedDoubleWeather(spellElement) then
            dayAndWeather = dayAndWeather + 0.25 + caster:getMod(xi.mod.IRIDESCENCE) * 0.05

        -- Weak weathers.
        elseif weather == xi.combat.element.getOppositeSingleWeather(spellElement) then
            dayAndWeather = dayAndWeather - 0.1 - caster:getMod(xi.mod.IRIDESCENCE) * 0.05
        elseif weather == xi.combat.element.getOppositeDoubleWeather(spellElement) then
            dayAndWeather = dayAndWeather - 0.25 - caster:getMod(xi.mod.IRIDESCENCE) * 0.05
        end
    end

    -- Calculate day bonus
    if
        math.random(1, 100) <= 33 or
        caster:getMod(xi.combat.element.getForcedDayOrWeatherBonusModifier(spellElement)) >= 1 or
        isHelixSpell
    then
        -- Strong day.
        if dayElement == spellElement then
            dayAndWeather = dayAndWeather + 0.1 + caster:getMod(xi.mod.DAY_NUKE_BONUS) / 100 -- sorc. tonban(+1)/zodiac ring

        -- Weak day.
        elseif dayElement == xi.combat.element.getOppositeElement(spellElement) then
            dayAndWeather = dayAndWeather - 0.1
        end
    end

    -- Cap bonuses from both day and weather
    dayAndWeather = utils.clamp(dayAndWeather, 0.6, 1.4)

    return dayAndWeather
end

-- Magic Attack Bonus VS Magic Defense Bonus
xi.spells.damage.calculateMagicBonusDiff = function(caster, target, spellId, skillType, spellElement)
    local magicBonusDiff = 1 -- The variable we want to calculate
    local casterJob      = caster:getMainJob()
    local mab            = caster:getMod(xi.mod.MATT) + cardinalChantBonus(caster, target, xi.direction.EAST, spellId, skillType)
    local mabCrit        = caster:getMod(xi.mod.MAGIC_CRITHITRATE) + cardinalChantBonus(caster, target, xi.direction.NORTH, spellId, skillType)
    local mDefBarBonus   = 0

    -- Ninja spell bonuses
    if skillType == xi.skill.NINJUTSU then
        -- Ninja Category 2 merits.
        mab = mab + caster:getMerit(xi.merit.NIN_MAGIC_BONUS)
        -- Ninja Category 1 merits
        -- TODO: merge spellFamily and spell ID tables into one table in spell_data.lua, then use spellFamily here instead of spellID
        if
            spellId >= xi.magic.spell.KATON_ICHI and
            spellId <= xi.magic.spell.KATON_SAN
        then
            mab = mab + caster:getMerit(xi.merit.KATON_EFFECT)
        elseif
            spellId >= xi.magic.spell.HYOTON_ICHI and
            spellId <= xi.magic.spell.HYOTON_SAN
        then
            mab = mab + caster:getMerit(xi.merit.HYOTON_EFFECT)
        elseif
            spellId >= xi.magic.spell.HUTON_ICHI and
            spellId <= xi.magic.spell.HUTON_SAN
        then
            mab = mab + caster:getMerit(xi.merit.HUTON_EFFECT)
        elseif
            spellId >= xi.magic.spell.DOTON_ICHI and
            spellId <= xi.magic.spell.DOTON_SAN
        then
            mab = mab + caster:getMerit(xi.merit.DOTON_EFFECT)
        elseif
            spellId >= xi.magic.spell.RAITON_ICHI and
            spellId <= xi.magic.spell.RAITON_SAN
        then
            mab = mab + caster:getMerit(xi.merit.RAITON_EFFECT)
        elseif
            spellId >= xi.magic.spell.SUITON_ICHI and
            spellId <= xi.magic.spell.SUITON_SAN
        then
            mab = mab + caster:getMerit(xi.merit.SUITON_EFFECT)
        end

        -- "Enhances ninjutsu damage" ("Koga Hatsuburi" type gear)
        mab = mab + caster:getMod(xi.mod.NIN_NUKE_BONUS_INNIN)
    end

    if math.random(1, 100) <= mabCrit then
        mab = mab + 10 + caster:getMod(xi.mod.MAGIC_CRIT_DMG_INCREASE)
    end

    -- Bar Spells bonuses and BLM merits.
    if
        spellElement >= xi.element.FIRE and
        spellElement <= xi.element.WATER
    then
        mab = mab + caster:getMerit(xi.combat.element.getElementalPotencyMerit(spellElement))

        if target:hasStatusEffect(xi.combat.element.getAssociatedBarspellEffect(spellElement)) then -- bar- spell magic defense bonus
            mDefBarBonus = target:getStatusEffect(xi.combat.element.getAssociatedBarspellEffect(spellElement)):getSubPower()
        end
    end

    -- Job Point MAB
    if casterJob == xi.job.RDM then
        mab = mab + caster:getJobPointLevel(xi.jp.RDM_MAGIC_ATK_BONUS)
    elseif casterJob == xi.job.GEO then
        mab = mab + caster:getJobPointLevel(xi.jp.GEO_MAGIC_ATK_BONUS)
    end

    -- Ancient Magic I and II MAB
    if
        spellId >= xi.magic.spell.FLARE and
        spellId <= xi.magic.spell.FLOOD_II
    then
        mab = mab + caster:getMerit(xi.merit.ANCIENT_MAGIC_ATK_BONUS)
    end

    -- Final operations
    local finalCasterMAB = (100 + mab) * (1 + caster:getMod(xi.mod.AUTO_MAB_COEFFICIENT) / 100)
    local finalTargetMDB = 100 + target:getMod(xi.mod.MDEF) + mDefBarBonus

    magicBonusDiff = utils.clamp(finalCasterMAB / finalTargetMDB, 0, 10)

    return magicBonusDiff
end

-- Calculate: Target Magic Damage Adjustment (TMDA)
-- SDT follow-up. This time for specific modifiers.
-- Referred to on item as "Magic Damage Taken -%", "Damage Taken -%" (Ex. Defending Ring) and "Magic Damage Taken II -%" (Aegis)
xi.spells.damage.calculateTMDA = function(target, spellElement)
    local targetMagicDamageAdjustment = 1

    -- The values set for this modifiers are base 10000.
    -- -2500 in item_mods.sql means -25% damage recived.
    -- 2500 would mean 25% ADDITIONAL damage taken.
    -- The effects of the "Shell" spells are also included in this step.

    local globalDamageTaken   = target:getMod(xi.mod.DMG) / 10000         -- Mod is base 10000
    local magicDamageTaken    = target:getMod(xi.mod.DMGMAGIC) / 10000    -- Mod is base 10000
    local magicDamageTakenII  = target:getMod(xi.mod.DMGMAGIC_II) / 10000 -- Mod is base 10000
    local uMagicDamageTaken   = target:getMod(xi.mod.UDMGMAGIC) / 10000   -- Mod is base 10000.
    local combinedDamageTaken = utils.clamp(magicDamageTaken + globalDamageTaken, -0.5, 0.5) -- The combination of regular "Damage Taken" and "Magic Damage Taken" caps at 50% both ways.

    targetMagicDamageAdjustment = utils.clamp(targetMagicDamageAdjustment + combinedDamageTaken + magicDamageTakenII, 0.125, 1.875) -- "Magic Damage Taken II" bypasses the regular cap, but combined cap is 87.5% both ways.
    targetMagicDamageAdjustment = utils.clamp(targetMagicDamageAdjustment + uMagicDamageTaken, 0, 2) -- Uncapped magic damage modifier. Cap is 100% both ways.

    return targetMagicDamageAdjustment
end

-- Divine seal applies its own multiplier to healing spells when used against undead.
-- NOTE: If we have reached this far with a heling spell, the target is confirmed to be undead.
xi.spells.damage.calculateDivineSealMultiplier = function(caster, skillType)
    local divineSealMultiplier = 1

    if
        caster:hasStatusEffect(xi.effect.DIVINE_SEAL) and
        skillType == xi.skill.HEALING_MAGIC
    then
        divineSealMultiplier = 2
        caster:delStatusEffect(xi.effect.DIVINE_SEAL)
    end

    return divineSealMultiplier
end

-- Divine Emblem applies its own damage multiplier to divine spells.
xi.spells.damage.calculateDivineEmblemMultiplier = function(caster, skillType)
    local divineEmblemMultiplier = 1

    if
        caster:hasStatusEffect(xi.effect.DIVINE_EMBLEM) and
        skillType == xi.skill.DIVINE_MAGIC
    then
        divineEmblemMultiplier = 1 + caster:getSkillLevel(xi.skill.DIVINE_MAGIC) / 100
        caster:delStatusEffect(xi.effect.DIVINE_EMBLEM)
    end

    return divineEmblemMultiplier
end

-- Ebullience applies an entirely separate multiplier to Black Magic.
xi.spells.damage.calculateEbullienceMultiplier = function(caster, spellGroup)
    local ebullienceMultiplier = 1

    if
        caster:hasStatusEffect(xi.effect.EBULLIENCE) and
        spellGroup == xi.magic.spellGroup.BLACK
    then
        ebullienceMultiplier = 1.2 + caster:getMod(xi.mod.EBULLIENCE_AMOUNT) / 100
        caster:delStatusEffectSilent(xi.effect.EBULLIENCE)
    end

    return ebullienceMultiplier
end

-- CUSTOM function supported in settings.
xi.spells.damage.calculateSkillTypeMultiplier = function(skillType)
    local skillTypeMultiplier = 1

    if skillType == xi.skill.ELEMENTAL_MAGIC then
        skillTypeMultiplier = xi.settings.main.ELEMENTAL_POWER
    elseif skillType == xi.skill.DARK_MAGIC then
        skillTypeMultiplier = xi.settings.main.DARK_POWER
    elseif skillType == xi.skill.NINJUTSU then
        skillTypeMultiplier = xi.settings.main.NINJUTSU_POWER
    elseif skillType == xi.skill.DIVINE_MAGIC then
        skillTypeMultiplier = xi.settings.main.DIVINE_POWER
    end

    return skillTypeMultiplier
end

xi.spells.damage.calculateNinSkillBonus = function(caster, spellId, skillType)
    local ninSkillBonus = 1

    local skillCaps =
    {
    -- Tier = { Min skill, Max skill}
        [1] = {  50, 250 },
        [2] = { 125, 350 },
        [3] = { 275, 500 },
    }

    if skillType == xi.skill.NINJUTSU and caster:getMainJob() == xi.job.NIN then
        -- Get spell tier.
        local spellTier = 3

        if spellId % 3 == 2 then     -- Ichi nuke spell ids are 320, 323, 326, 329, 332, and 335
            spellTier = 1
        elseif spellId % 3 == 0 then -- Ni nuke spell ids are 1 more than their corresponding Ichi spell
            spellTier = 2
        end

        -- Get skill bonus.
        local skillLevel = utils.clamp(caster:getSkillLevel(xi.skill.NINJUTSU), skillCaps[spellTier][1], skillCaps[spellTier][2])
        ninSkillBonus    = 1 + (skillLevel - skillCaps[spellTier][1]) / 200
    end

    return ninSkillBonus
end

xi.spells.damage.calculateNinFutaeBonus = function(caster, skillType)
    local ninFutaeBonus = 1

    if
        skillType == xi.skill.NINJUTSU and
        caster:hasStatusEffect(xi.effect.FUTAE)
    then
        ninFutaeBonus = (150 + caster:getJobPointLevel(xi.jp.FUTAE_EFFECT) * 5) / 100
        caster:delStatusEffect(xi.effect.FUTAE)
    end

    return ninFutaeBonus
end

xi.spells.damage.calculateNinjutsuMultiplier = function(caster, target, skillType)
    local ninjutsuMultiplier = 1

    -- Ninjutsu damage multiplier from Innin.
    if
        skillType == xi.skill.NINJUTSU and
        caster:hasStatusEffect(xi.effect.INNIN) and
        caster:isBehind(target)
    then
        ninjutsuMultiplier = 1 + caster:getMod(xi.mod.NIN_NUKE_BONUS_INNIN) / 100
    end

    return ninjutsuMultiplier
end

xi.spells.damage.calculateUndeadDivinePenalty = function(target, skillType)
    local undeadDivinePenalty = 1

    if target:isUndead() and skillType == xi.skill.DIVINE_MAGIC then
        undeadDivinePenalty = 1.5
    end

    return undeadDivinePenalty
end

xi.spells.damage.calculateScarletDeliriumMultiplier = function(caster)
    local scarletDeliriumMultiplier = 1

    -- Scarlet delirium are 2 different status effects. SCARLET_DELIRIUM_1 is the one that boosts power.
    if caster:hasStatusEffect(xi.effect.SCARLET_DELIRIUM_1) then
        local power = caster:getStatusEffect(xi.effect.SCARLET_DELIRIUM_1):getPower()

        scarletDeliriumMultiplier = 1 + power / 100
    end

    return scarletDeliriumMultiplier
end

xi.spells.damage.calculateHelixMeritMultiplier = function(caster, spellId)
    local helixMeritMultiplier = 1

    if
        (spellId >= xi.magic.spell.GEOHELIX and spellId <= xi.magic.spell.LUMINOHELIX) or
        (spellId >= xi.magic.spell.GEOHELIX_II and spellId <= xi.magic.spell.LUMINOHELIX_II)
    then
        helixMeritMultiplier = 1 + 2 * caster:getMerit(xi.merit.HELIX_MAGIC_ACC_ATT) / 100
    end

    return helixMeritMultiplier
end

xi.spells.damage.calculateAreaOfEffectResistance = function(target, spell)
    local areaOfEffectMultiplier = 1

    if target:getID() ~= spell:getPrimaryTargetID() then
        areaOfEffectMultiplier = utils.clamp(areaOfEffectMultiplier + target:getMod(xi.mod.DMG_AOE) / 10000, 0, 2)
    end

    return areaOfEffectMultiplier
end

xi.spells.damage.calculateNukeAbsorbOrNullify = function(target, spellElement)
    local nukeAbsorbOrNullify = 1
    local liementFactor       = target:checkLiementAbsorb(xi.damageType.ELEMENTAL + spellElement) -- Check for Liement.

    -- Absobtion by liement.
    if liementFactor < 0 then
        return liementFactor
    end

    -- Elemental damage.
    local absorbElementModValue  = 0
    local nullifyElementModValue = 0

    if spellElement > xi.element.NONE then
        absorbElementModValue  = target:getMod(xi.combat.element.getElementalAbsorptionModifier(spellElement))
        nullifyElementModValue = target:getMod(xi.combat.element.getElementalNullificationModifier(spellElement))
    end

    -- Calculate chance for spell absorption.
    local absorbChance = math.random(1, 100)
    if
        absorbChance <= target:getMod(xi.mod.ABSORB_DMG_CHANCE) or -- All damage.
        absorbChance <= target:getMod(xi.mod.MAGIC_ABSORB) or      -- Magical damage.
        absorbChance <= absorbElementModValue                      -- Element damage.
    then
        nukeAbsorbOrNullify = -1
    end

    -- Calculate chance for spell nullification.
    local nullifyChance = math.random(1, 100)
    if
        nullifyChance <= target:getMod(xi.mod.NULL_DAMAGE) or         -- All damage.
        nullifyChance <= target:getMod(xi.mod.NULL_MAGICAL_DAMAGE) or -- Magical damage.
        nullifyChance <= nullifyElementModValue                       -- Element damage.
    then
        nukeAbsorbOrNullify = 0
    end

    return nukeAbsorbOrNullify
end

xi.spells.damage.calculateIfMagicBurst = function(target, spellElement, skillchainCount)
    local magicBurst = 1 -- The variable we want to calculate

    if spellElement > xi.element.NONE then
        local resistRank = target:getMod(xi.combat.element.getElementalResistanceRankModifier(spellElement))
        local rankTable  = { 1.15, 0.85, 0.6, 0.5, 0.4, 0.15, 0.05 }
        local rankBonus  = 0

        if resistRank <= -3 then
            rankBonus = 1.5
        elseif resistRank >= 5 then
            rankBonus = 0
        else
            rankBonus = rankTable[resistRank + 3]
        end

        magicBurst = 1.25 + rankBonus + skillchainCount / 10
    end

    -- Sengikori appears to add to base mb multiplier per JP wiki https://wiki.ffo.jp/html/20051.html
    if
        skillchainCount >= 1 and
        target:getMod(xi.mod.SENGIKORI_MB_DMG_DEBUFF) > 0
    then
        magicBurst = magicBurst + target:getMod(xi.mod.SENGIKORI_MB_DMG_DEBUFF) / 100
        target:setMod(xi.mod.SENGIKORI_MB_DMG_DEBUFF, 0) -- Consume the "Effect" upon magic burst.
    end

    return magicBurst
end

xi.spells.damage.calculateIfMagicBurstBonus = function(caster, target, spellId, skillType, spellElement)
    local magicBurstBonus = 1 -- The variable we want to calculate
    local cappedBonus     = caster:getMod(xi.mod.MAGIC_BURST_BONUS_CAPPED) / 100
    local uncappedBonus   = caster:getMod(xi.mod.MAGIC_BURST_BONUS_UNCAPPED) / 100

    -- TODO: merge spellFamily and spell ID tables into one table in spell_data.lua, then maybe add a family for all AM and use spellFamily here instead of spellID
    if spellId >= xi.magic.spell.FLARE and spellId <= xi.magic.spell.FLOOD_II then
        cappedBonus = cappedBonus + caster:getMerit(xi.merit.ANCIENT_MAGIC_BURST_DMG) / 100
    end

    -- Apply Innin Magic Burst bonus
    if caster:isBehind(target) and caster:hasStatusEffect(xi.effect.INNIN) then
        cappedBonus = cappedBonus + caster:getMerit(xi.merit.INNIN_EFFECT) / 100
    end

    -- Cap bonuses from first step at 40% or 0.4
    cappedBonus = utils.clamp(cappedBonus, 0, 0.4)

    -- BLM Job Point: Magic Burst Damage and GEO cardinal chant.
    uncappedBonus = uncappedBonus + caster:getJobPointLevel(xi.jp.MAGIC_BURST_DMG_BONUS) / 100 + cardinalChantBonus(caster, target, xi.direction.WEST, spellId, skillType) / 100

    -- Get final multiplier
    magicBurstBonus = magicBurstBonus + cappedBonus + uncappedBonus

    return magicBurstBonus
end

-- Consecutive Elemental Damage Penalty. Most commonly known as "Nuke Wall".
xi.spells.damage.calculateNukeWallFactor = function(target, spellElement, finalDamage)
    local nukeWallFactor = 1

    -- Initial check.
    if
        not target:isNM() or               -- Target is not an NM.
        spellElement <= xi.element.NONE or -- Action isn't elemental.
        finalDamage < 0                    -- Action hals target.
    then
        return nukeWallFactor
    end

    -- Calculate current effect potency and apply it to nukeWallFactor.
    local potency = 0

    if target:hasStatusEffect(xi.effect.NUKE_WALL) then
        local effect = target:getStatusEffect(xi.effect.NUKE_WALL)

        -- Current nuke wall effect.
        if spellElement == effect:getSubPower() then
            potency = effect:getPower()

            -- Effect potency is reduced by 20% after 1 second and remains stable for the remaining time, unless refreshed.
            if effect:getTimeRemaining() <= 4000 then
                potency = utils.clamp(potency - 2000, 0, 4000) -- Potency is reduced by 2000 (20%) after first second has happened. Can't go below 0.
            end
        end

        -- Rayke effect.
        if target:hasStatusEffect(xi.effect.RAYKE) then
            local raykeSubpower = target:getStatusEffect(xi.effect.RAYKE):getSubPower()

            -- current bit size of subPower is 16 bits, 4*4 = 16
            -- Step from 0 to 16 in increments of 4...
            for i = 0, 16, 4 do
                -- If element is bitpacked into rayke subeffect...
                if bit.band(bit.rshift(raykeSubpower, i), 0xF) == spellElement then
                    potency = math.floor(potency / 2)

                    break
                end
            end
        end

        target:delStatusEffectSilent(xi.effect.NUKE_WALL)
    end

    nukeWallFactor = 1 - potency / 10000

    -- Calculate damage needed to reach the potency cap (4000). The lower the level, the easier to hit potency cap.
    local damageCap = target:getMainLvl() * 21 + 500

    -- Calculate final effect potency, dependant on damage dealt.
    local finalPotency = utils.clamp(math.floor(4000 * finalDamage / damageCap) + potency, 0, 4000)

    -- Renew status effect.
    target:addStatusEffectEx(xi.effect.NUKE_WALL, 0, finalPotency, 0, 5, 0, spellElement)

    return nukeWallFactor
end

-----------------------------------
-- Spell Helper Function
-----------------------------------
xi.spells.damage.useDamageSpell = function(caster, target, spell)
    local finalDamage = 0 -- The variable we want to calculate

    -- Get Tabled Variables.
    local spellId      = spell:getID()
    local skillType    = spell:getSkillType()
    local spellGroup   = spell:getSpellGroup()
    local spellElement = spell:getElement()
    local statUsed     = pTable[spellId][column.STAT_USED]
    local bonusMacc    = pTable[spellId][column.BONUS_MACC] + cardinalChantBonus(caster, target, xi.direction.SOUTH, spellId, skillType)

    -- Calculate damage absobtion or nullification.
    local nukeAbsorbOrNullify = xi.spells.damage.calculateNukeAbsorbOrNullify(target, spellElement)

    -- Skip everything if we nullify the spell.
    if nukeAbsorbOrNullify == 0 then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)

        return 0
    end

    -- Skip resistances, magic damage adjustment (TMDA), magic burst and nuke-wall if we absorb the spell.
    local resistTier                  = 1
    local targetMagicDamageAdjustment = 1
    local magicBurst                  = 1
    local magicBurstBonus             = 1

    if nukeAbsorbOrNullify > 0 then
        resistTier                  = xi.combat.magicHitRate.calculateResistRate(caster, target, spellGroup, skillType, 0, spellElement, statUsed, 0, bonusMacc)
        targetMagicDamageAdjustment = xi.spells.damage.calculateTMDA(target, spellElement)

        -- If spell is NOT blue magic OR (if its blue magic AND has status effect)
        if
            spellGroup ~= xi.magic.spellGroup.BLUE or
            (spellGroup == xi.magic.spellGroup.BLUE and
            (caster:hasStatusEffect(xi.effect.BURST_AFFINITY) or
            caster:hasStatusEffect(xi.effect.AZURE_LORE)))
        then
            local _, skillchainCount = xi.magicburst.formMagicBurst(spellElement, target) -- External function. Not present in magic.lua.

            if skillchainCount > 0 then
                magicBurst      = xi.spells.damage.calculateIfMagicBurst(target, spellElement, skillchainCount)
                magicBurstBonus = xi.spells.damage.calculateIfMagicBurstBonus(caster, target, spellId, skillType, spellElement)

                if spellGroup == xi.magic.spellGroup.BLUE then
                    caster:delStatusEffectSilent(xi.effect.BURST_AFFINITY)
                end
            end
        end
    end

    -- Calculate base damage and the rest of damage multipliers.
    local spellDamage               = xi.spells.damage.calculateBaseDamage(caster, target, spellId, spellGroup, skillType, statUsed)
    local multipleTargetReduction   = xi.spells.damage.calculateMTDR(spell)
    local elementalStaffBonus       = xi.spells.damage.calculateElementalStaffBonus(caster, spellElement)
    local magianAffinity            = xi.spells.damage.calculateMagianAffinity()
    local additionalResistTier      = xi.spells.damage.calculateAdditionalResistTier(caster, target, spellElement)
    local sdt                       = xi.spells.damage.calculateSDT(target, spellElement)
    local dayAndWeather             = xi.spells.damage.calculateDayAndWeather(caster, spellId, spellElement)
    local magicBonusDiff            = xi.spells.damage.calculateMagicBonusDiff(caster, target, spellId, skillType, spellElement)
    local divineSealMultiplier      = xi.spells.damage.calculateDivineSealMultiplier(caster, skillType)
    local divineEmblemMultiplier    = xi.spells.damage.calculateDivineEmblemMultiplier(caster, skillType)
    local ebullienceMultiplier      = xi.spells.damage.calculateEbullienceMultiplier(caster, spellGroup)
    local skillTypeMultiplier       = xi.spells.damage.calculateSkillTypeMultiplier(skillType)
    local ninSkillBonus             = xi.spells.damage.calculateNinSkillBonus(caster, spellId, skillType)
    local ninFutaeBonus             = xi.spells.damage.calculateNinFutaeBonus(caster, skillType)
    local ninjutsuMultiplier        = xi.spells.damage.calculateNinjutsuMultiplier(caster, target, skillType)
    local undeadDivinePenalty       = xi.spells.damage.calculateUndeadDivinePenalty(target, skillType)
    local scarletDeliriumMultiplier = xi.spells.damage.calculateScarletDeliriumMultiplier(caster)
    local helixMeritMultiplier      = xi.spells.damage.calculateHelixMeritMultiplier(caster, spellId)
    local areaOfEffectResistance    = xi.spells.damage.calculateAreaOfEffectResistance(target, spell)

    -- Calculate finalDamage. It MUST be floored after EACH multiplication.
    finalDamage = math.floor(spellDamage * multipleTargetReduction)
    finalDamage = math.floor(finalDamage * elementalStaffBonus)
    finalDamage = math.floor(finalDamage * magianAffinity)
    finalDamage = math.floor(finalDamage * sdt)
    finalDamage = math.floor(finalDamage * resistTier)
    finalDamage = math.floor(finalDamage * additionalResistTier)
    finalDamage = math.floor(finalDamage * dayAndWeather)
    finalDamage = math.floor(finalDamage * magicBonusDiff)
    finalDamage = math.floor(finalDamage * targetMagicDamageAdjustment)
    finalDamage = math.floor(finalDamage * divineSealMultiplier)
    finalDamage = math.floor(finalDamage * divineEmblemMultiplier)
    finalDamage = math.floor(finalDamage * ebullienceMultiplier)
    finalDamage = math.floor(finalDamage * skillTypeMultiplier)
    finalDamage = math.floor(finalDamage * ninSkillBonus)
    finalDamage = math.floor(finalDamage * ninFutaeBonus)
    finalDamage = math.floor(finalDamage * ninjutsuMultiplier)
    finalDamage = math.floor(finalDamage * undeadDivinePenalty)
    finalDamage = math.floor(finalDamage * scarletDeliriumMultiplier)
    finalDamage = math.floor(finalDamage * helixMeritMultiplier)
    finalDamage = math.floor(finalDamage * areaOfEffectResistance)
    finalDamage = math.floor(finalDamage * nukeAbsorbOrNullify)
    finalDamage = math.floor(finalDamage * magicBurst)
    finalDamage = math.floor(finalDamage * magicBurstBonus)

    -- Handle "Nuke Wall". It must be handled after all previous calculations, but before clamp.
    if nukeAbsorbOrNullify > 0 then
        local nukeWallFactor = xi.spells.damage.calculateNukeWallFactor(target, spellElement, finalDamage)
        finalDamage          = math.floor(finalDamage * nukeWallFactor)
    end

    -- Handle Magic Absorb message and HP recovery.
    if finalDamage < 0 then
        finalDamage = target:addHP(-finalDamage)
        spell:setMsg(xi.msg.basic.MAGIC_RECOVERS_HP)

        return finalDamage
    end

    -- Handle Phalanx, One for All, Stoneskin.
    finalDamage = utils.clamp(finalDamage - target:getMod(xi.mod.PHALANX), 0, 99999)
    finalDamage = utils.clamp(utils.oneforall(target, finalDamage), 0, 99999)
    finalDamage = utils.clamp(utils.stoneskin(target, finalDamage), -99999, 99999)

    -- Handle final adjustments. Most are located in core. TODO: Decide if we want core handling this.
    -- Check if the mob has a damage cap
    finalDamage = target:checkDamageCap(finalDamage)

    -- Handle Bind break and TP?
    target:takeSpellDamage(caster, spell, finalDamage, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL + spellElement)

    -- Handle Afflatus Misery.
    target:handleAfflatusMiseryDamage(finalDamage)

    -- Handle Enmity.
    target:updateEnmityFromDamage(caster, finalDamage)

    -- Add "Magic Burst!" message
    if magicBurst > 1 then
        spell:setMsg(xi.msg.basic.MAGIC_BURST_DAMAGE)
        caster:triggerRoeEvent(xi.roeTrigger.MAGIC_BURST)
    end

    return finalDamage
end
