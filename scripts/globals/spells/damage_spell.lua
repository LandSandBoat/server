-----------------------------------
-- Damage Spell Utilities
-- Used for spells that deal direct damage. (Black, White, Dark and Ninjutsu)
-----------------------------------
require("scripts/globals/combat/magic_hit_rate")
require("scripts/globals/jobpoints")
require("scripts/globals/magicburst")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/spell_data")
require("scripts/globals/status")
require("scripts/globals/utils")
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
-- Structure:       function = { Fire,                 Ice,                   Air,                  Earth,                 Thunder,                  Water,                    Light,                    Dark                     }
xi.magic.dayStrong           = { xi.day.FIRESDAY,      xi.day.ICEDAY,         xi.day.WINDSDAY,      xi.day.EARTHSDAY,      xi.day.LIGHTNINGDAY,      xi.day.WATERSDAY,         xi.day.LIGHTSDAY,         xi.day.DARKSDAY          }
xi.magic.dayWeak             = { xi.day.WATERSDAY,     xi.day.FIRESDAY,       xi.day.ICEDAY,        xi.day.WINDSDAY,       xi.day.EARTHSDAY,         xi.day.LIGHTNINGDAY,      xi.day.DARKSDAY,          xi.day.LIGHTSDAY         }
xi.magic.singleWeatherStrong = { xi.weather.HOT_SPELL, xi.weather.SNOW,       xi.weather.WIND,      xi.weather.DUST_STORM, xi.weather.THUNDER,       xi.weather.RAIN,          xi.weather.AURORAS,       xi.weather.GLOOM         }
xi.magic.doubleWeatherStrong = { xi.weather.HEAT_WAVE, xi.weather.BLIZZARDS,  xi.weather.GALES,     xi.weather.SAND_STORM, xi.weather.THUNDERSTORMS, xi.weather.SQUALL,        xi.weather.STELLAR_GLARE, xi.weather.DARKNESS      }
xi.magic.singleWeatherWeak   = { xi.weather.RAIN,      xi.weather.HOT_SPELL,  xi.weather.SNOW,      xi.weather.WIND,       xi.weather.DUST_STORM,    xi.weather.THUNDER,       xi.weather.GLOOM,         xi.weather.AURORAS       }
xi.magic.doubleWeatherWeak   = { xi.weather.SQUALL,    xi.weather.HEAT_WAVE,  xi.weather.BLIZZARDS, xi.weather.GALES,      xi.weather.SAND_STORM,    xi.weather.THUNDERSTORMS, xi.weather.DARKNESS,      xi.weather.STELLAR_GLARE }
xi.magic.specificDmgTakenMod = { xi.mod.FIRE_SDT,      xi.mod.ICE_SDT,        xi.mod.WIND_SDT,      xi.mod.EARTH_SDT,      xi.mod.THUNDER_SDT,       xi.mod.WATER_SDT,         xi.mod.LIGHT_SDT,         xi.mod.DARK_SDT          }
xi.magic.absorbMod           = { xi.mod.FIRE_ABSORB,   xi.mod.ICE_ABSORB,     xi.mod.WIND_ABSORB,   xi.mod.EARTH_ABSORB,   xi.mod.LTNG_ABSORB,       xi.mod.WATER_ABSORB,      xi.mod.LIGHT_ABSORB,      xi.mod.DARK_ABSORB       }
xi.magic.barSpell            = { xi.effect.BARFIRE,    xi.effect.BARBLIZZARD, xi.effect.BARAERO,    xi.effect.BARSTONE,    xi.effect.BARTHUNDER,     xi.effect.BARWATER        }

local elementalObi           = { xi.mod.FORCE_FIRE_DWBONUS,   xi.mod.FORCE_ICE_DWBONUS,   xi.mod.FORCE_WIND_DWBONUS,   xi.mod.FORCE_EARTH_DWBONUS,   xi.mod.FORCE_LIGHTNING_DWBONUS,   xi.mod.FORCE_WATER_DWBONUS,  xi.mod.FORCE_LIGHT_DWBONUS, xi.mod.FORCE_DARK_DWBONUS }
local strongAffinityDmg      = { xi.mod.FIRE_AFFINITY_DMG,    xi.mod.ICE_AFFINITY_DMG,    xi.mod.WIND_AFFINITY_DMG,    xi.mod.EARTH_AFFINITY_DMG,    xi.mod.THUNDER_AFFINITY_DMG,      xi.mod.WATER_AFFINITY_DMG,   xi.mod.LIGHT_AFFINITY_DMG,  xi.mod.DARK_AFFINITY_DMG  }
local nullMod                = { xi.mod.FIRE_NULL,            xi.mod.ICE_NULL,            xi.mod.WIND_NULL,            xi.mod.EARTH_NULL,            xi.mod.LTNG_NULL,                 xi.mod.WATER_NULL,           xi.mod.LIGHT_NULL,          xi.mod.DARK_NULL          }
local resistRankMod          = { xi.mod.FIRE_RES_RANK,        xi.mod.ICE_RES_RANK,        xi.mod.WIND_RES_RANK,        xi.mod.EARTH_RES_RANK,        xi.mod.THUNDER_RES_RANK,          xi.mod.WATER_RES_RANK,       xi.mod.LIGHT_RES_RANK,      xi.mod.DARK_RES_RANK      }
local blmMerit               = { xi.merit.FIRE_MAGIC_POTENCY, xi.merit.ICE_MAGIC_POTENCY, xi.merit.WIND_MAGIC_POTENCY, xi.merit.EARTH_MAGIC_POTENCY, xi.merit.LIGHTNING_MAGIC_POTENCY, xi.merit.WATER_MAGIC_POTENCY }

-- Table variables.
local stat            = 1
local vNPC            = 2
local mNPC            = 3
local vPC             = 4
local inflectionPoint = 5

local pTable =
{
-- Single target black magic spells:
-- Structure:           [spellId] = {  Stat used, vNPC, mNPC,  vPC,   I,  M0,  M50, M100, M200, M300, M400, M500 },
    [xi.magic.spell.AERO        ] = { xi.mod.INT,   25,    1,   40,  35, 1.6,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.AERO_II     ] = { xi.mod.INT,  113,    1,  140, 133, 2.6,  1.8,    1,    0,    0,    0,    0 },
    [xi.magic.spell.AERO_III    ] = { xi.mod.INT,  265,  1.5,  260, 295, 3.4,  2.8,  1.9,    1,    0,    0,    0 },
    [xi.magic.spell.AERO_IV     ] = { xi.mod.INT,  440,    2,  480, 472, 4.4,  3.8,  2.9, 1.98,    1,    0,    0 },
    [xi.magic.spell.AERO_V      ] = { xi.mod.INT,  738,  2.3,  750, 550, 5.2,  4.5,  3.9, 2.98, 1.98,    1,    0 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.AERO_VI     ] = { xi.mod.INT, 1070,  2.5, 1070, 600,   6,  5.8,  4.8,  3.8,  2.9, 1.98,    1 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.TORNADO     ] = { xi.mod.INT,  552,    2,  700, 577,   2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.TORNADO_II  ] = { xi.mod.INT,  710,    2,  800, 780,   2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.BLIZZARD    ] = { xi.mod.INT,   46,    1,   70,  60, 1.2,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.BLIZZARD_II ] = { xi.mod.INT,  155,    1,  180, 178, 2.2,  1.6,    1,    0,    0,    0,    0 },
    [xi.magic.spell.BLIZZARD_III] = { xi.mod.INT,  320,  1.5,  320, 345, 2.8,  2.6,  1.8,    1,    0,    0,    0 },
    [xi.magic.spell.BLIZZARD_IV ] = { xi.mod.INT,  506,    2,  560, 541, 3.9,  3.6,  2.8, 1.96,    1,    0,    0 },
    [xi.magic.spell.BLIZZARD_V  ] = { xi.mod.INT,  829,  2.3,  850, 600, 4.4,    4,  3.8, 2.96, 1.96,    1,    0 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.BLIZZARD_VI ] = { xi.mod.INT, 1190,  2.5, 1190, 650,   5,  5.6,  4.6,  3.6,  2.8, 1.96,    1 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.FREEZE      ] = { xi.mod.INT,  552,    2,  700, 552,   2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.FREEZE_II   ] = { xi.mod.INT,  710,    2,  800, 780,   2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.FIRE        ] = { xi.mod.INT,   35,    1,   55,  46, 1.4,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.FIRE_II     ] = { xi.mod.INT,  133,    1,  160, 155, 2.4,  1.7,    1,    0,    0,    0,    0 },
    [xi.magic.spell.FIRE_III    ] = { xi.mod.INT,  295,  1.5,  290, 320, 3.1,  2.7, 1.85,    1,    0,    0,    0 },
    [xi.magic.spell.FIRE_IV     ] = { xi.mod.INT,  472,    2,  520, 506, 4.2,  3.7, 2.85, 1.97,    1,    0,    0 },
    [xi.magic.spell.FIRE_V      ] = { xi.mod.INT,  785,  2.3,  800, 550, 4.8, 4.24, 3.85, 2.97, 1.97,    1,    0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.FIRE_VI     ] = { xi.mod.INT, 1130,  2.5, 1130, 600, 5.5,  5.7,  4.7,  3.7, 2.85, 1.97,    1 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.FLARE       ] = { xi.mod.INT,  552,    2,  700, 684,   2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.FLARE_II    ] = { xi.mod.INT,  710,    2,  800, 780,   2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.STONE       ] = { xi.mod.INT,   10,    1,   10,  16,   2,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.STONE_II    ] = { xi.mod.INT,   78,    1,  100,  95,   3,    2,    1,    0,    0,    0,    0 },
    [xi.magic.spell.STONE_III   ] = { xi.mod.INT,  210,  1.5,  200, 236,   4,    3,    2,    1,    0,    0,    0 },
    [xi.magic.spell.STONE_IV    ] = { xi.mod.INT,  381,    2,  400, 410,   5,    4,    3,    2,    1,    0,    0 },
    [xi.magic.spell.STONE_V     ] = { xi.mod.INT,  626,  2.3,  650, 500,   6,    5,    4,    3,    2,    1,    0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.STONE_VI    ] = { xi.mod.INT,  950,  2.5,  950, 550,   7,    6,    5,    4,    3,    2,    1 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.QUAKE       ] = { xi.mod.INT,  552,    2,  700, 603,   2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.QUAKE_II    ] = { xi.mod.INT,  710,    2,  800, 780,   2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.THUNDER     ] = { xi.mod.INT,   60,    1,   85,  78,   1,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.THUNDER_II  ] = { xi.mod.INT,  178,    1,  200, 210,   2,  1.5,    1,    0,    0,    0,    0 },
    [xi.magic.spell.THUNDER_III ] = { xi.mod.INT,  345,  1.5,  350, 381, 2.5,  2.5, 1.75,    1,    0,    0,    0 },
    [xi.magic.spell.THUNDER_IV  ] = { xi.mod.INT,  541,    2,  600, 626, 3.6,  3.5, 2.75, 1.95,    1,    0,    0 },
    [xi.magic.spell.THUNDER_V   ] = { xi.mod.INT,  874,  2.3,  900, 700,   4, 3.74, 3.75, 2.95, 1.95,    1,    0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.THUNDER_VI  ] = { xi.mod.INT, 1250,  2.5, 1250, 750, 4.5,  5.5,  4.5,  3.5, 2.75, 1.95,    1 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.BURST       ] = { xi.mod.INT,  552,    2,  700, 630,   2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.BURST_II    ] = { xi.mod.INT,  710,    2,  800, 780,   2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.WATER       ] = { xi.mod.INT,   16,    1,   25,  25, 1.8,    1,    0,    0,    0,    0,    0 },
    [xi.magic.spell.WATER_II    ] = { xi.mod.INT,   95,    1,  120, 113, 2.8,  1.9,    1,    0,    0,    0,    0 },
    [xi.magic.spell.WATER_III   ] = { xi.mod.INT,  236,  1.5,  230, 265, 3.7,  2.9, 1.95,    1,    0,    0,    0 },
    [xi.magic.spell.WATER_IV    ] = { xi.mod.INT,  410,    2,  440, 440, 4.7,  3.9, 2.95, 1.99,    1,    0,    0 },
    [xi.magic.spell.WATER_V     ] = { xi.mod.INT,  680,  2.3,  700, 500, 5.6, 4.74, 3.95, 2.99, 1.99,    1,    0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.WATER_VI    ] = { xi.mod.INT, 1010,  1.5, 1010, 550, 6.5,  5.9,  4.9,  3.9, 2.95, 1.99,    1 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.FLOOD       ] = { xi.mod.INT,  552,    2,  700, 657,   2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.FLOOD_II    ] = { xi.mod.INT,  710,    2,  800, 780,   2,    2,    2,    2,    2,    2,    2 },
    [xi.magic.spell.COMET       ] = { xi.mod.INT,  964,  2.3, 1000, 850,   4, 3.75,  3.5,    3,    2,    1,    1 }, -- I value unknown. Guesstimate used.

-- Multiple target spells:
-- Structure:           [spellId] = {  Stat used, vNPC, mNPC,  vPC,   I,  M0,  M50, M100, M200, M300, M400, M500 },
    [xi.magic.spell.AEROGA      ] = { xi.mod.INT,   93,    1,  100, 120, 2.6,  1.8,    1,    0,    0,    0,    0 },
    [xi.magic.spell.AEROGA_II   ] = { xi.mod.INT,  266,    1,  310, 312, 3.4,  2.8,  1.9,    1,    0,    0,    0 },
    [xi.magic.spell.AEROGA_III  ] = { xi.mod.INT,  527,  1.5,  580, 642, 4.4,  3.8,  2.9, 1.98,    1,    0,    0 },
    [xi.magic.spell.AEROGA_IV   ] = { xi.mod.INT,  738,    2,    0, 700,   1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Aero V.
    [xi.magic.spell.AEROGA_V    ] = { xi.mod.INT, 1070,  2.3,    0, 750,   1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Aero VI.
    [xi.magic.spell.AERA        ] = { xi.mod.INT,  210,    1,  210, 250, 2.6,  1.8,    1,    0,    0,    0,    0 },
    [xi.magic.spell.AERA_II     ] = { xi.mod.INT,  430,    1,  430, 600, 3.4,  2.8,  1.9,    1,    0,    0,    0 },
    [xi.magic.spell.AERA_III    ] = { xi.mod.INT,  710,  1.5,  710, 700, 4.4,  3.8,  2.9, 1.98,    1,    0,    0 }, -- No info found. Since Aera I and II N Values coincided with Aeroga 1 and II, used Values of Aeroga III.
    [xi.magic.spell.AEROJA      ] = { xi.mod.INT,  844,  2.3,  850, 800, 5.2,  4.5,  3.9,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.BLIZZAGA    ] = { xi.mod.INT,  145,    1,  160, 172, 2.2,  1.6,    1,    0,    0,    0,    0 },
    [xi.magic.spell.BLIZZAGA_II ] = { xi.mod.INT,  350,    1,  370, 392, 2.8,  2.6,  1.8,    1,    0,    0,    0 },
    [xi.magic.spell.BLIZZAGA_III] = { xi.mod.INT,  642,  1.5,  660, 697, 3.9,  3.6,  2.8, 1.96,    1,    0,    0 },
    [xi.magic.spell.BLIZZAGA_IV ] = { xi.mod.INT,  829,    2,    0, 800,   1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Blizzard V.
    [xi.magic.spell.BLIZZAGA_V  ] = { xi.mod.INT, 1190,  2.3,    0, 950,   1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Blizzard VI.
    [xi.magic.spell.BLIZZARA    ] = { xi.mod.INT,  270,    1,  270, 300, 2.2,  1.6,    1,    0,    0,    0,    0 },
    [xi.magic.spell.BLIZZARA_II ] = { xi.mod.INT,  510,    1,  510, 550, 2.8,  2.6,  1.8,    1,    0,    0,    0 },
    [xi.magic.spell.BLIZZARA_III] = { xi.mod.INT,  830,  1.5,  830, 850, 3.9,  3.6,  2.8, 1.96,    1,    0,    0 }, -- No info found. Since Blizzara I and II N Values coincided with Blizzaga 1 and II, used Values of Blizzaga III.
    [xi.magic.spell.BLIZZAJA    ] = { xi.mod.INT,  953,  2.3,  950, 950, 4.4,    4,  3.8,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.FIRAGA      ] = { xi.mod.INT,  120,    1,  120, 145, 2.4,  1.7,    1,    0,    0,    0,    0 },
    [xi.magic.spell.FIRAGA_II   ] = { xi.mod.INT,  312,    1,  340, 350, 3.1,  2.7, 1.85,    1,    0,    0,    0 },
    [xi.magic.spell.FIRAGA_III  ] = { xi.mod.INT,  589,  1.5,  620, 642, 4.2,  3.7, 2.85, 1.97,    1,    0,    0 },
    [xi.magic.spell.FIRAGA_IV   ] = { xi.mod.INT,  785,    2,    0, 700,   1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Fire V.
    [xi.magic.spell.FIRAGA_V    ] = { xi.mod.INT, 1130,  2.3,    0, 800,   1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Fire VI.
    [xi.magic.spell.FIRA        ] = { xi.mod.INT,  240,    1,  240, 250, 2.4,  1.7,    1,    0,    0,    0,    0 },
    [xi.magic.spell.FIRA_II     ] = { xi.mod.INT,  470,    1,  470, 500, 3.1,  2.7, 1.85,    1,    0,    0,    0 },
    [xi.magic.spell.FIRA_III    ] = { xi.mod.INT,  760,  1.5,  760, 800, 4.2,  3.7, 2.85, 1.97,    1,    0,    0 }, -- No info found. Since Fira I and II N Values coincided with Firaga 1 and II, used Values of Firaga III.
    [xi.magic.spell.FIRAJA      ] = { xi.mod.INT,  902,  2.3,  900, 950, 4.8, 4.25, 3.85,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.STONEGA     ] = { xi.mod.INT,   56,    1,   60,  74,   3,    2,    1,    0,    0,    0,    0 },
    [xi.magic.spell.STONEGA_II  ] = { xi.mod.INT,  201,    1,  250, 232,   4,    3,    2,    1,    0,    0,    0 },
    [xi.magic.spell.STONEGA_III ] = { xi.mod.INT,  434,  1.5,  500, 480,   5,    4,    3,    2,    1,    0,    0 },
    [xi.magic.spell.STONEGA_IV  ] = { xi.mod.INT,  626,    2,    0, 650,   1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Stone V.
    [xi.magic.spell.STONEGA_V   ] = { xi.mod.INT,  950,  2.3,    0, 950,   1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Stone VI.
    [xi.magic.spell.STONERA     ] = { xi.mod.INT,  150,    1,  150, 150,   3,    2,    1,    0,    0,    0,    0 },
    [xi.magic.spell.STONERA_II  ] = { xi.mod.INT,  350,    1,  350, 350,   4,    3,    2,    1,    0,    0,    0 },
    [xi.magic.spell.STONERA_III ] = { xi.mod.INT,  650,  1.5,  650, 650,   5,    4,    3,    2,    1,    0,    0 }, -- No info found. Since Stonera I and II N Values coincided with Stonega 1 and II, used Values of Stonega III.
    [xi.magic.spell.STONEJA     ] = { xi.mod.INT,  719,  2.3,  750, 750,   6,    5,    4,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.THUNDAGA    ] = { xi.mod.INT,  172,    1,  200, 201,   2,  1.5,    1,    0,    0,    0,    0 },
    [xi.magic.spell.THUNDAGA_II ] = { xi.mod.INT,  392,    1,  400, 434, 2.5,  2.5, 1.75,    1,    0,    0,    0 },
    [xi.magic.spell.THUNDAGA_III] = { xi.mod.INT,  697,  1.5,  700, 719, 3.6,  3.5, 2.75, 1.95,    1,    0,    0 },
    [xi.magic.spell.THUNDAGA_IV ] = { xi.mod.INT,  874,    2,    0, 900,   1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Thunder V.
    [xi.magic.spell.THUNDAGA_V  ] = { xi.mod.INT, 1250,  2.3,    0, 999,   1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Thunder VI.
    [xi.magic.spell.THUNDARA    ] = { xi.mod.INT,  300,    1,  300, 300,   2,  1.5,    1,    0,    0,    0,    0 },
    [xi.magic.spell.THUNDARA_II ] = { xi.mod.INT,  550,    1,  550, 550, 2.5,  2.5, 1.75,    1,    0,    0,    0 },
    [xi.magic.spell.THUNDARA_III] = { xi.mod.INT,  900,  1.5,  900, 900, 3.6,  3.5, 2.75, 1.95,    1,    0,    0 }, -- No info found. Since Thundara I and II N Values coincided with Thundaga 1 and II, used Values of Thundaga III.
    [xi.magic.spell.THUNDAJA    ] = { xi.mod.INT, 1005,  2.3, 1000, 999,   4, 3.75, 3.75,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.WATERGA     ] = { xi.mod.INT,   74,    1,   80,  96, 2.8,  1.9,    1,    0,    0,    0,    0 },
    [xi.magic.spell.WATERGA_II  ] = { xi.mod.INT,  232,    1,  280, 266, 3.7,  2.9, 1.95,    1,    0,    0,    0 },
    [xi.magic.spell.WATERGA_III ] = { xi.mod.INT,  480,  1.5,  540, 527, 4.7,  3.9, 2.95, 1.99,    1,    0,    0 },
    [xi.magic.spell.WATERGA_IV  ] = { xi.mod.INT,  680,    2,    0, 700,   1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Water V.
    [xi.magic.spell.WATERGA_V   ] = { xi.mod.INT, 1010,  2.3,    0, 900,   1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Water VI.
    [xi.magic.spell.WATERA      ] = { xi.mod.INT,  180,    1,  180, 200, 2.8,  1.9,    1,    0,    0,    0,    0 },
    [xi.magic.spell.WATERA_II   ] = { xi.mod.INT,  390,    1,  390, 400, 3.7,  2.9, 1.95,    1,    0,    0,    0 },
    [xi.magic.spell.WATERA_III  ] = { xi.mod.INT,  660,  1.5,  660, 700, 4.7,  3.9, 2.95, 1.99,    1,    0,    0 }, -- No info found. Since Watera I and II N Values coincided with Waterga 1 and II, used Values of Waterga III.
    [xi.magic.spell.WATERJA     ] = { xi.mod.INT,  782,  2.3,  800, 900, 5.6, 4.75, 3.95,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.

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
    [xi.magic.spell.BANISH      ] = { xi.mod.MND,   14,    1,   14,  25 },
    [xi.magic.spell.BANISH_II   ] = { xi.mod.MND,   85,    1,   85, 113 },
    [xi.magic.spell.BANISH_III  ] = { xi.mod.MND,  198,  1.5,  198, 250 },
    [xi.magic.spell.BANISH_IV   ] = { xi.mod.MND,  420,  1.5,  420, 400 }, -- Enemy only. Stats unknown/unchecked.
    [xi.magic.spell.BANISHGA    ] = { xi.mod.MND,   50,    1,   50,  46 },
    [xi.magic.spell.BANISHGA_II ] = { xi.mod.MND,  180,    1,  180, 133 },
    [xi.magic.spell.BANISHGA_III] = { xi.mod.MND,  480,  1.5,  480, 450 }, -- Enemy only. Stats unknown.
    [xi.magic.spell.BANISHGA_IV ] = { xi.mod.MND,  600,  1.5,  600, 600 }, -- Enemy only. Stats unknown.
    [xi.magic.spell.HOLY        ] = { xi.mod.MND,  125,    1,  125, 150 },
    [xi.magic.spell.HOLY_II     ] = { xi.mod.MND,  250,    2,  250, 300 },

-- TODO: Healing Spells when used against undead/zombie
}

-----------------------------------
-- Basic Functions
-----------------------------------
xi.spells.damage.calculateBaseDamage = function(caster, target, spell, spellId, skillType, statUsed)
    local spellDamage          = 0 -- The variable we want to calculate
    local baseSpellDamage      = 0 -- (V) In Wiki.
    local baseSpellDamageBonus = 0 -- (mDMG) In Wiki. Get from equipment, status, etc
    local statDiffBonus        = 0 -- statDiff x appropriate multipliers.
    local statDiff             = caster:getStat(statUsed) - target:getStat(statUsed)

    -- Spell Damage = baseSpellDamage + statDiffBonus + baseSpellDamageBonus

    -----------------------------------
    -- STEP 1: baseSpellDamage (V)
    -----------------------------------
    if
        caster:isPC() and
        not xi.settings.main.USE_OLD_MAGIC_DAMAGE
    then
        baseSpellDamage = pTable[spellId][vPC] -- vPC
    else
        baseSpellDamage = pTable[spellId][vNPC] -- vNPC
    end

    -----------------------------------
    -- STEP 2: statDiffBonus (statDiff * M)
    -----------------------------------
    -- New System: Player Elemental magic. Setting for old system must be false.
    if
        skillType == xi.skill.ELEMENTAL_MAGIC and
        caster:isPC() and
        not xi.settings.main.USE_OLD_MAGIC_DAMAGE
    then
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
            statDiffBonus = statDiffBonus + math.floor(utils.clamp(statDiff - mTable[i][1], 0, mTable[i][2]) * pTable[spellId][5 + i])
        end

    -- TODO: Investigate "inflection point" (I) and its relation with the terms "soft cap" and "hard cap"

    -- Old System: Divine magic, Non-Player Elemental magic and Player elemental magic IF setting for old system is used.
    elseif
        skillType == xi.skill.DIVINE_MAGIC or
        (skillType == xi.skill.ELEMENTAL_MAGIC and not caster:isPC()) or                                    -- Mobs always use old system
        (skillType == xi.skill.ELEMENTAL_MAGIC and caster:isPC() and xi.settings.main.USE_OLD_MAGIC_DAMAGE) -- Players use old system only when setting is enabled.
    then
        local spellMultiplier = pTable[spellId][mNPC]            -- M
        local inflexionPoint  = pTable[spellId][inflectionPoint] -- I

        if statDiff <= 0 then
            statDiffBonus = statDiff
        elseif statDiff > 0 and statDiff <= inflexionPoint then
            statDiffBonus = math.floor(statDiff * spellMultiplier)
        else
            statDiffBonus = math.floor(inflexionPoint * spellMultiplier) + math.floor((statDiff - inflexionPoint) * spellMultiplier / 2)
        end

    -- Old System: Ninjutsu. "I" (Infection point) isn't used due to lack of information. Values in table are currently made up and unused.
    elseif skillType == xi.skill.NINJUTSU then
        statDiffBonus = math.floor(statDiff * pTable[spellId][mNPC])
    end

    -----------------------------------
    -- STEP 3: baseSpellDamageBonus (mDMG)
    -----------------------------------
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
    end

    -- Bonus to spell base damage from gear.
    baseSpellDamageBonus = baseSpellDamageBonus + caster:getMod(xi.mod.MAGIC_DAMAGE)

    -----------------------------------
    -- STEP 4: Spell Damage
    -----------------------------------
    spellDamage = baseSpellDamage + baseSpellDamageBonus + statDiffBonus

    -- No negative base damage value allowed.
    if spellDamage < 0 then
        spellDamage = 0
    end

    return spellDamage
end

-- Calculate: Multiple Target Damage Reduction (MTDR)
xi.spells.damage.calculateMTDR = function(caster, target, spell)
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

xi.spells.damage.calculateEleStaffBonus = function(caster, spell, spellElement)
    local eleStaffBonus = caster:getMod(strongAffinityDmg[spellElement])

    if eleStaffBonus > 0 then
        eleStaffBonus = 1 + eleStaffBonus * 0.05
    else
        eleStaffBonus = 1
    end

    return eleStaffBonus
end

xi.spells.damage.calculateMagianAffinity = function(caster, spell)
    -- TODO: IMPLEMENT MAGIAN TRIALS AFFINITY SYSTEM, which could be as simple as introducing a new modifier. Out of the scope of this rewrite, for now
    local magianAffinity = 1

    -- TODO: Code Magian Trials affinity.
    -- TODO: ADD (because it's additive) bonuses from atmas. Also, not sure the current affinity mod is the ACTUAL "affinity" mod as understood in wikis.

    return magianAffinity
end

-- Elemental Specific Damage Taken (Elemental SDT)
xi.spells.damage.calculateSDT = function(caster, target, spell, spellElement)
    local sdt    = 1 -- The variable we want to calculate
    local sdtMod = 0

    if spellElement > 0 then
        sdtMod = target:getMod(xi.magic.specificDmgTakenMod[spellElement])

    -- SDT (Species/Specific Damage Taken) is a stat/mod present in mobs and players that applies a % to specific damage types.
    -- Each of the 8 elements has an SDT modifier (Modifiers 54 to 61. Check script(globals/status.lua)
    -- Mob elemental modifiers are populated by the values set in "mob_resistances.sql" (The database). SDT columns.
    -- The value of the modifiers are base 10000. Positive numbers mean less damage taken. Negative mean more damage taken.
    -- Examples:
    -- A value of 5000 -> 50% LESS damage taken.
    -- A value of -5000 -> 50% MORE damage taken.

        sdt = (sdtMod / -10000) + 1
    end

    -- A word on SDT as understood in some wikis, even if they are refering to resistance and not actual SDT
    -- SDT under 50% applies a flat 1/2 *, which was for a long time confused with an additional resist tier, which, in reality, its an independent multiplier.
    -- This is understandable, because in a way, it is effectively a whole tier, but recent testing with skillchains/magic bursts after resist was removed from them, proved this.
    -- SDT affects magic burst damage, but never in a "negative" way.
    -- https://www.bg-wiki.com/ffxi/Resist for some SDT info.
    -- *perhaps this simply means there is a cap/clamp limiting it there.

    return sdt
end

-- This function is used to calculate Resist tiers. The resist tiers work differently for enfeebles (which usually affect duration, not potency) than for nukes.
-- This is for nukes damage only. If an spell happens to do both damage and apply an status effect, they are calculated separately.
xi.spells.damage.calculateResist = function(caster, target, spell, skillType, spellElement, statUsed)
    -- Get Caster Magic Accuracy.
    local magicAcc = xi.combat.magicHitRate.calculateActorMagicAccuracy(caster, target, spell, skillType, spellElement, statUsed)

    -- Get Target Magic Evasion.
    local magicEva = xi.combat.magicHitRate.calculateTargetMagicEvasion(caster, target, spellElement, false, 0) -- false = not an enfeeble. 0 = No meva modifier.

    -- Calculate Magic Hit Rate with the previous 2 values.
    local magicHitRate = xi.combat.magicHitRate.calculateMagicHitRate(magicAcc, magicEva)

    -- Calculate Resist Rate.
    local resist = xi.combat.magicHitRate.calculateResistRate(caster, target, skillType, spellElement, magicHitRate)

    return resist
end

xi.spells.damage.calculateIfMagicBurst = function(caster, target, spell, spellElement)
    local magicBurst         = 1 -- The variable we want to calculate
    local _, skillchainCount = FormMagicBurst(spellElement, target) -- External function. Not present in magic.lua.

    if skillchainCount > 0 then
        local rankBonus  = 0

        if spellElement ~= xi.magic.ele.NONE then
            local resistRank = target:getMod(resistRankMod[spellElement])
            local rankTable  = { 1.15, 0.85, 0.6, 0.5, 0.4, 0.15, 0.05 }

            if resistRank <= -3 then
                rankBonus = 1.5
            elseif resistRank >= 5 then
                rankBonus = 0
            else
                rankBonus = rankTable[resistRank + 3]
            end
        end

        magicBurst = 1.25 + (0.1 * skillchainCount) + rankBonus
    end

    return magicBurst
end

xi.spells.damage.calculateIfMagicBurstBonus = function(caster, target, spell, spellId, spellElement)
    local magicBurstBonus        = 1 -- The variable we want to calculate
    local modBurst               = 1
    local ancientMagicBurstBonus = 0
    local _, skillchainCount     = FormMagicBurst(spellElement, target) -- External function. Not present in magic.lua.

    -- TODO: merge spellFamily and spell ID tables into one table in spell_data.lua, then maybe ad a family for all AM and use spellFamily here instead of spellID
    if spellId >= xi.magic.spell.FLARE and spellId <= xi.magic.spell.FLOOD_II then
        ancientMagicBurstBonus = caster:getMerit(xi.merit.ANCIENT_MAGIC_BURST_DMG) / 100
    end

    -- MBB = 1.0 + Gear + Atma/Atmacite + AMII Merits + others -- This Caps at 1.4
    -- MBB = MBB + trait

    if
        spell and
        spell:getSpellGroup() == 3 and
        not (caster:hasStatusEffect(xi.effect.BURST_AFFINITY) or caster:hasStatusEffect(xi.effect.AZURE_LORE))
    then
        return magicBurstBonus
    end

    -- Obtain multiplier from gear, atma and job traits -- Job traits should be done separately
    modBurst = modBurst + (caster:getMod(xi.mod.MAG_BURST_BONUS) / 100) + ancientMagicBurstBonus

    -- Apply Innin bonus
    if caster:isBehind(target) and caster:hasStatusEffect(xi.effect.INNIN) then
        modBurst = modBurst + (caster:getMerit(xi.merit.INNIN_EFFECT) / 100)
    end

    -- BLM Job Point: Magic Burst Damage
    modBurst = modBurst + (caster:getJobPointLevel(xi.jp.MAGIC_BURST_DMG_BONUS) / 100)

    -- Cap bonuses from first multiplier at 40% or 1.4
    if modBurst > 1.4 then
        modBurst = 1.4
    end

    -- TODO: BLM job trait has to be separate from gear trait, since the job trait is NOT capped. At least, cap is not known.
    -- Magic Burst Damage I is found in gear. caps at 40% with innin, AM2 and such
    -- Magic Burst Damage II is found in other gear and BLM job traits pertain to this one OR to a third, separate one. neither has known cap

    if skillchainCount > 0 then
        magicBurstBonus = modBurst -- + modBurstTrait once investigated. Probably needs to be divided by 100
    end

    return magicBurstBonus
end

xi.spells.damage.calculateDayAndWeather = function(caster, target, spell, spellId, spellElement)
    local dayAndWeather = 1 -- The variable we want to calculate
    local weather       = caster:getWeather()
    local dayElement    = VanadielDayElement()
    local isHelixSpell  = false -- TODO: I'm not sure thats the correct way to handle helixes. This is how we handle it and im not gonna change it for now.

    -- See if its a Helix type spell
    if spellId >= 278 and spellId <= 285 then
        isHelixSpell = true
    end

    -- Calculate Weather bonus
    if
        math.random() < 0.33 or
        caster:getMod(elementalObi[spellElement]) >= 1 or
        isHelixSpell
    then
        if weather == xi.magic.singleWeatherStrong[spellElement] then
            dayAndWeather = dayAndWeather + 0.10
            if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
                dayAndWeather = dayAndWeather + 0.10
            end
        elseif weather == xi.magic.singleWeatherWeak[spellElement] then
            dayAndWeather = dayAndWeather - 0.10
        elseif weather == xi.magic.doubleWeatherStrong[spellElement] then
            dayAndWeather = dayAndWeather + 0.25
            if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
                dayAndWeather = dayAndWeather + 0.10
            end
        elseif weather == xi.magic.doubleWeatherWeak[spellElement] then
            dayAndWeather = dayAndWeather - 0.25
        end
    end

    -- Calculate day bonus
    if dayElement == spellElement then
        dayAndWeather = dayAndWeather + caster:getMod(xi.mod.DAY_NUKE_BONUS) / 100 -- sorc. tonban(+1)/zodiac ring
        if
            math.random() < 0.33 or
            caster:getMod(elementalObi[spellElement]) >= 1 or
            isHelixSpell
        then
            dayAndWeather = dayAndWeather + 0.10
        end
    elseif dayElement == xi.magic.elementDescendant[spellElement] then
        if
            math.random() < 0.33 or
            caster:getMod(elementalObi[spellElement]) >= 1 or
            isHelixSpell
        then
            dayAndWeather = dayAndWeather - 0.10
        end
    end

    -- Cap bonuses from both day and weather
    if dayAndWeather > 1.4 then
        dayAndWeather = 1.4
    end

    return dayAndWeather
end

-- Magic Attack Bonus VS Magic Defense Bonus
xi.spells.damage.calculateMagicBonusDiff = function(caster, target, spell, spellId, skillType, spellElement)
    local magicBonusDiff = 1 -- The variable we want to calculate
    local casterJob      = caster:getMainJob()
    local mab            = caster:getMod(xi.mod.MATT)
    local mabCrit        = caster:getMod(xi.mod.MAGIC_CRITHITRATE)
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
        then -- Katon series.
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
    end

    if math.random(1, 100) < mabCrit then
        mab = mab + 10 + caster:getMod(xi.mod.MAGIC_CRIT_DMG_INCREASE)
    end

    -- Bar Spells bonuses
    if
        spellElement >= xi.magic.element.FIRE and
        spellElement <= xi.magic.element.WATER
    then
        mab = mab + caster:getMerit(blmMerit[spellElement])
        if target:hasStatusEffect(xi.magic.barSpell[spellElement]) then -- bar- spell magic defense bonus
            mDefBarBonus = target:getStatusEffect(xi.magic.barSpell[spellElement]):getSubPower()
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

    magicBonusDiff = (100 + mab) / (100 + target:getMod(xi.mod.MDEF) + mDefBarBonus)

    if magicBonusDiff < 0 then
        magicBonusDiff = 0
    end

    return magicBonusDiff
end

-- Calculate: Target Magic Damage Adjustment (TMDA)
-- SDT follow-up. This time for specific modifiers.
-- Referred to on item as "Magic Damage Taken -%", "Damage Taken -%" (Ex. Defending Ring) and "Magic Damage Taken II -%" (Aegis)
xi.spells.damage.calculateTMDA = function(caster, target, damageType)
    local targetMagicDamageAdjustment = 1 -- The variable we want to calculate

    targetMagicDamageAdjustment = target:checkLiementAbsorb(damageType) -- check for Liement.
    if targetMagicDamageAdjustment < 0 then -- skip MDT/DT/MDTII etc for Liement if we absorb.
        return targetMagicDamageAdjustment
    end

    -- The values set for this modifiers are base 10000.
    -- -2500 in item_mods.sql means -25% damage recived.
    -- 2500 would mean 25% ADDITIONAL damage taken.
    -- The effects of the "Shell" spells are also included in this step.

    local globalDamageTaken     = target:getMod(xi.mod.DMG) / 10000         -- Mod is base 10000
    local magicDamageTaken      = target:getMod(xi.mod.DMGMAGIC) / 10000    -- Mod is base 10000
    local magicDamageTakenII    = target:getMod(xi.mod.DMGMAGIC_II) / 10000 -- Mod is base 10000
    local uMagicDamageTaken     = target:getMod(xi.mod.UDMGMAGIC) / 10000   -- Mod is base 10000.

    local combinedDamageTaken   = utils.clamp(magicDamageTaken + globalDamageTaken, -0.5, 0.5) -- The combination of regular "Damage Taken" and "Magic Damage Taken" caps at 50% both ways.
    targetMagicDamageAdjustment = utils.clamp(1 + combinedDamageTaken + magicDamageTakenII, 0.125, 1.875) -- "Magic Damage Taken II" bypasses the regular cap, but combined cap is 87.5% both ways.
    targetMagicDamageAdjustment = utils.clamp(targetMagicDamageAdjustment + uMagicDamageTaken, 0, 2) -- Uncapped magic damage modifier. Cap is 100% both ways.

    return targetMagicDamageAdjustment
end

-- Divine Emblem applies its own damage multiplier.
xi.spells.damage.calculateDivineEmblemMultiplier = function(caster, target, spell)
    local divineEmblemMultiplier = 1

    if caster:hasStatusEffect(xi.effect.DIVINE_EMBLEM) then
        divineEmblemMultiplier = 1 + caster:getSkillLevel(xi.skill.DIVINE_MAGIC) / 100
        caster:delStatusEffect(xi.effect.DIVINE_EMBLEM)
    end

    return divineEmblemMultiplier
end

-- Ebullience applies an entirely separate multiplier.
xi.spells.damage.calculateEbullienceMultiplier = function(caster, target, spell)
    local ebullienceMultiplier = 1

    if caster:hasStatusEffect(xi.effect.EBULLIENCE) then
        ebullienceMultiplier = 1.2 + caster:getMod(xi.mod.EBULLIENCE_AMOUNT) / 100
        caster:delStatusEffectSilent(xi.effect.EBULLIENCE)
    end

    return ebullienceMultiplier
end

-- CUSTOM function supported in scripts/globals/settings.lua
xi.spells.damage.calculateSkillTypeMultiplier = function(caster, target, spell, skillType)
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

xi.spells.damage.calculateNinSkillBonus = function(caster, target, spell, spellId, skillType)
    local ninSkillBonus = 1

    if skillType == xi.skill.NINJUTSU and caster:getMainJob() == xi.job.NIN then
        if spellId % 3 == 2 then     -- Ichi nuke spell ids are 320, 323, 326, 329, 332, and 335
            ninSkillBonus = 100 + math.floor((caster:getSkillLevel(xi.skill.NINJUTSU) - 50) / 2)
        elseif spellId % 3 == 0 then -- Ni nuke spell ids are 1 more than their corresponding Ichi spell
            ninSkillBonus = 100 + math.floor((caster:getSkillLevel(xi.skill.NINJUTSU) - 125) / 2)
        else                         -- San nuke spell, also has ids 1 more than their corresponding Ni spell
            ninSkillBonus = 100 + math.floor((caster:getSkillLevel(xi.skill.NINJUTSU) - 275) / 2)
        end

        ninSkillBonus = utils.clamp(ninSkillBonus / 100, 1, 2) -- bonus caps at +100%, and does not go negative
    end

    return ninSkillBonus
end

xi.spells.damage.calculateNinFutaeBonus = function(caster, target, spell, skillType)
    local ninFutaeBonus = 1

    if
        skillType == xi.skill.NINJUTSU and
        caster:hasStatusEffect(xi.effect.FUTAE)
    then
        ninFutaeBonus = (150  + caster:getJobPointLevel(xi.jp.FUTAE_EFFECT) * 5) / 100
        caster:delStatusEffect(xi.effect.FUTAE)
    end

    return ninFutaeBonus
end

xi.spells.damage.calculateUndeadDivinePenalty = function(caster, target, spell, skillType)
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

xi.spells.damage.calculateNukeAbsorbOrNullify = function(caster, target, spell, spellElement)
    local nukeAbsorbOrNullify = 1

    -- Calculate chance for spell absorption.
    if math.random(1, 100) <= target:getMod(xi.magic.absorbMod[spellElement]) then
        nukeAbsorbOrNullify = -1
    end

    -- Calculate chance for spell nullification.
    local nullifyChance = math.random(1, 100)
    if
        nullifyChance <= target:getMod(nullMod[spellElement]) or
        nullifyChance <= target:getMod(xi.mod.MAGIC_NULL)
    then
        nukeAbsorbOrNullify = 0
    end

    return nukeAbsorbOrNullify
end

-- Consecutive Elemental Damage Penalty. Most commonly known as "Nuke Wall".
xi.spells.damage.calculateNukeWallFactor = function(caster, target, spell, spellElement, finalDamage)
    local nukeWallFactor = 1

    -- Initial check.
    if
        not target:isNM() or
        spellElement <= 0 or
        finalDamage < 0
    then
        return nukeWallFactor
    end

    -- Calculate current effect potency and apply it to nukeWallFactor.
    local potency = 0

    if target:hasStatusEffect(xi.effect.NUKE_WALL) then
        local effect = target:getStatusEffect(xi.effect.NUKE_WALL)

        if spellElement == effect:getSubPower() then
            potency = effect:getPower()

            -- Effect potency is reduced by 20% after 1 second and remains stable for the remaining time, unless refreshed.
            if effect:getTimeRemaining() <= 4000 then
                potency = utils.clamp(potency - 2000, 0, 4000) -- Potency is reduced by 2000 after first second has happened. Can't go below 0.
            end
        end
    end

    nukeWallFactor = 1 - potency / 10000

    -- Calculate damage needed to reach the potency cap (4000). The lower the level, the easier to hit potency cap.
    local damageCap = target:getMainLvl() * 21 + 500

    -- Calculate final effect potency, dependant on damage dealt.
    local finalPotency = utils.clamp(math.floor(4000 * finalDamage / damageCap) + potency, 0, 4000)

    -- Renew status effect.
    target:delStatusEffectSilent(xi.effect.NUKE_WALL)
    target:addStatusEffectEx(xi.effect.NUKE_WALL, 0, finalPotency, 0, 5, 0, spellElement)

    return nukeWallFactor
end

-----------------------------------
-- Spell Helper Function
-----------------------------------
xi.spells.damage.useDamageSpell = function(caster, target, spell)
    local finalDamage  = 0 -- The variable we want to calculate

    -- Get Tabled Variables.
    local spellId         = spell:getID()
    local skillType       = spell:getSkillType()
    local spellElement    = spell:getElement()
    local statUsed        = pTable[spellId][stat]
    local spellDamageType = xi.damageType.ELEMENTAL + spellElement

    -- Variables/steps to calculate finalDamage.
    local spellDamage                 = xi.spells.damage.calculateBaseDamage(caster, target, spell, spellId, skillType, statUsed)
    local multipleTargetReduction     = xi.spells.damage.calculateMTDR(caster, target, spell)
    local eleStaffBonus               = xi.spells.damage.calculateEleStaffBonus(caster, spell, spellElement)
    local magianAffinity              = xi.spells.damage.calculateMagianAffinity(caster, spell)
    local sdt                         = xi.spells.damage.calculateSDT(caster, target, spell, spellElement)
    local resist                      = xi.spells.damage.calculateResist(caster, target, spell, skillType, spellElement, statUsed)
    local magicBurst                  = xi.spells.damage.calculateIfMagicBurst(caster, target,  spell, spellElement)
    local magicBurstBonus             = xi.spells.damage.calculateIfMagicBurstBonus(caster, target, spell, spellId, spellElement)
    local dayAndWeather               = xi.spells.damage.calculateDayAndWeather(caster, target, spell, spellId, spellElement)
    local magicBonusDiff              = xi.spells.damage.calculateMagicBonusDiff(caster, target, spell, spellId, skillType, spellElement)
    local targetMagicDamageAdjustment = xi.spells.damage.calculateTMDA(caster, target, spellDamageType)
    local divineEmblemMultiplier      = xi.spells.damage.calculateDivineEmblemMultiplier(caster, target, spell)
    local ebullienceMultiplier        = xi.spells.damage.calculateEbullienceMultiplier(caster, target, spell)
    local skillTypeMultiplier         = xi.spells.damage.calculateSkillTypeMultiplier(caster, target, spell, skillType)
    local ninSkillBonus               = xi.spells.damage.calculateNinSkillBonus(caster, target, spell, spellId, skillType)
    local ninFutaeBonus               = xi.spells.damage.calculateNinFutaeBonus(caster, target, spell, skillType)
    local undeadDivinePenalty         = xi.spells.damage.calculateUndeadDivinePenalty(caster, target, spell, skillType)
    local scarletDeliriumMultiplier   = xi.spells.damage.calculateScarletDeliriumMultiplier(caster)
    local nukeAbsorbOrNullify         = xi.spells.damage.calculateNukeAbsorbOrNullify(caster, target, spell, spellElement)

    -- Calculate finalDamage. It MUST be floored after EACH multiplication.
    finalDamage = math.floor(spellDamage * multipleTargetReduction)
    finalDamage = math.floor(finalDamage * eleStaffBonus)
    finalDamage = math.floor(finalDamage * magianAffinity)
    finalDamage = math.floor(finalDamage * sdt)
    finalDamage = math.floor(finalDamage * resist)
    finalDamage = math.floor(finalDamage * magicBurst)
    finalDamage = math.floor(finalDamage * magicBurstBonus)
    finalDamage = math.floor(finalDamage * dayAndWeather)
    finalDamage = math.floor(finalDamage * magicBonusDiff)
    finalDamage = math.floor(finalDamage * targetMagicDamageAdjustment)
    finalDamage = math.floor(finalDamage * divineEmblemMultiplier)
    finalDamage = math.floor(finalDamage * ebullienceMultiplier)
    finalDamage = math.floor(finalDamage * skillTypeMultiplier)
    finalDamage = math.floor(finalDamage * ninSkillBonus)
    finalDamage = math.floor(finalDamage * ninFutaeBonus)
    finalDamage = math.floor(finalDamage * undeadDivinePenalty)
    finalDamage = math.floor(finalDamage * scarletDeliriumMultiplier)
    finalDamage = math.floor(finalDamage * nukeAbsorbOrNullify)

    -- Handle "Nuke Wall". It must be handled after all previous calculations, but before clamp.
    local nukeWallFactor = xi.spells.damage.calculateNukeWallFactor(caster, target, spell, spellElement, finalDamage)

    finalDamage = math.floor(finalDamage * nukeWallFactor)

    -- Handle Phalanx
    if finalDamage > 0 then
        finalDamage = utils.clamp(finalDamage - target:getMod(xi.mod.PHALANX), 0, 99999)
    end

    -- Handle One For All
    if finalDamage > 0 then
        finalDamage = utils.clamp(utils.oneforall(target, finalDamage), 0, 99999)
    end

    -- Handle Stoneskin
    if finalDamage > 0 then
        finalDamage = utils.clamp(utils.stoneskin(target, finalDamage), -99999, 99999)
    end

    -- Handle Magic Absorb
    if finalDamage < 0 then
        finalDamage = target:addHP(-finalDamage)
        spell:setMsg(xi.msg.basic.MAGIC_RECOVERS_HP)

    -- Handle final adjustments. Most are located in core. TODO: Decide if we want core handling this.
    else
        -- Handle Bind break and TP?
        target:takeSpellDamage(caster, spell, finalDamage, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL + spellElement)

        -- Handle Afflatus Misery.
        target:handleAfflatusMiseryDamage(finalDamage)

        -- Handle Enmity.
        target:updateEnmityFromDamage(caster, finalDamage)

        -- Only add TP if the target is a mob and if the spell actually does damage.
        if target:getObjType() ~= xi.objType.PC and finalDamage > 0 then
            target:addTP(100)
        end

        -- Add "Magic Burst!" message
        if magicBurst > 1 then
            spell:setMsg(xi.msg.basic.MAGIC_BURST_DAMAGE)
            caster:triggerRoeEvent(xi.roe.triggers.magicBurst)
        end
    end

    return finalDamage
end
