-----------------------------------
-- Damage Spell Utilities
-- Used for spells that deal direct damage. (Black, White, Dark and Ninjutsu)
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/magicburst")
require("scripts/globals/utils")
require("scripts/globals/magic")
require("scripts/globals/damage")
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
-- Structure:       function = { Fire,                         Ice,                         Air,                           Earth,                         Thunder,                           Water,                          Light,                      Dark                      }
xi.magic.dayStrong           = { xi.day.FIRESDAY,              xi.day.ICEDAY,               xi.day.WINDSDAY,               xi.day.EARTHSDAY,              xi.day.LIGHTNINGDAY,               xi.day.WATERSDAY,               xi.day.LIGHTSDAY,           xi.day.DARKSDAY           }
xi.magic.dayWeak             = { xi.day.WATERSDAY,             xi.day.FIRESDAY,             xi.day.ICEDAY,                 xi.day.WINDSDAY,               xi.day.EARTHSDAY,                  xi.day.LIGHTNINGDAY,            xi.day.DARKSDAY,            xi.day.LIGHTSDAY          }
xi.magic.singleWeatherStrong = { xi.weather.HOT_SPELL,         xi.weather.SNOW,             xi.weather.WIND,               xi.weather.DUST_STORM,         xi.weather.THUNDER,                xi.weather.RAIN,                xi.weather.AURORAS,         xi.weather.GLOOM          }
xi.magic.doubleWeatherStrong = { xi.weather.HEAT_WAVE,         xi.weather.BLIZZARDS,        xi.weather.GALES,              xi.weather.SAND_STORM,         xi.weather.THUNDERSTORMS,          xi.weather.SQUALL,              xi.weather.STELLAR_GLARE,   xi.weather.DARKNESS       }
xi.magic.singleWeatherWeak   = { xi.weather.RAIN,              xi.weather.HOT_SPELL,        xi.weather.SNOW,               xi.weather.WIND,               xi.weather.DUST_STORM,             xi.weather.THUNDER,             xi.weather.GLOOM,           xi.weather.AURORAS        }
xi.magic.doubleWeatherWeak   = { xi.weather.SQUALL,            xi.weather.HEAT_WAVE,        xi.weather.BLIZZARDS,          xi.weather.GALES,              xi.weather.SAND_STORM,             xi.weather.THUNDERSTORMS,       xi.weather.DARKNESS,        xi.weather.STELLAR_GLARE  }
xi.magic.resistMod           = { xi.mod.FIRE_MEVA,             xi.mod.ICE_MEVA,             xi.mod.WIND_MEVA,              xi.mod.EARTH_MEVA,             xi.mod.THUNDER_MEVA,               xi.mod.WATER_MEVA,              xi.mod.LIGHT_MEVA,          xi.mod.DARK_MEVA          }
xi.magic.specificDmgTakenMod = { xi.mod.FIRE_SDT,              xi.mod.ICE_SDT,              xi.mod.WIND_SDT,               xi.mod.EARTH_SDT,              xi.mod.THUNDER_SDT,                xi.mod.WATER_SDT,               xi.mod.LIGHT_SDT,           xi.mod.DARK_SDT           }
xi.magic.eleEvaMult          = { xi.mod.FIRE_EEM,              xi.mod.ICE_EEM,              xi.mod.WIND_EEM,               xi.mod.EARTH_EEM,              xi.mod.THUNDER_EEM,                xi.mod.WATER_EEM,               xi.mod.LIGHT_EEM,           xi.mod.DARK_EEM }
xi.magic.absorbMod           = { xi.mod.FIRE_ABSORB,           xi.mod.ICE_ABSORB,           xi.mod.WIND_ABSORB,            xi.mod.EARTH_ABSORB,           xi.mod.LTNG_ABSORB,                xi.mod.WATER_ABSORB,            xi.mod.LIGHT_ABSORB,        xi.mod.DARK_ABSORB        }
xi.magic.barSpell            = { xi.effect.BARFIRE,            xi.effect.BARBLIZZARD,       xi.effect.BARAERO,             xi.effect.BARSTONE,            xi.effect.BARTHUNDER,              xi.effect.BARWATER              }

local elementalObi           = { xi.mod.FORCE_FIRE_DWBONUS,    xi.mod.FORCE_ICE_DWBONUS,    xi.mod.FORCE_WIND_DWBONUS,     xi.mod.FORCE_EARTH_DWBONUS,    xi.mod.FORCE_LIGHTNING_DWBONUS,    xi.mod.FORCE_WATER_DWBONUS,     xi.mod.FORCE_LIGHT_DWBONUS, xi.mod.FORCE_DARK_DWBONUS }
local spellAcc               = { xi.mod.FIREACC,               xi.mod.ICEACC,               xi.mod.WINDACC,                xi.mod.EARTHACC,               xi.mod.THUNDERACC,                 xi.mod.WATERACC,                xi.mod.LIGHTACC,            xi.mod.DARKACC            }
local strongAffinityDmg      = { xi.mod.FIRE_AFFINITY_DMG,     xi.mod.ICE_AFFINITY_DMG,     xi.mod.WIND_AFFINITY_DMG,      xi.mod.EARTH_AFFINITY_DMG,     xi.mod.THUNDER_AFFINITY_DMG,       xi.mod.WATER_AFFINITY_DMG,      xi.mod.LIGHT_AFFINITY_DMG,  xi.mod.DARK_AFFINITY_DMG  }
local strongAffinityAcc      = { xi.mod.FIRE_AFFINITY_ACC,     xi.mod.ICE_AFFINITY_ACC,     xi.mod.WIND_AFFINITY_ACC,      xi.mod.EARTH_AFFINITY_ACC,     xi.mod.THUNDER_AFFINITY_ACC,       xi.mod.WATER_AFFINITY_ACC,      xi.mod.LIGHT_AFFINITY_ACC,  xi.mod.DARK_AFFINITY_ACC  }
local nullMod                = { xi.mod.FIRE_NULL,             xi.mod.ICE_NULL,             xi.mod.WIND_NULL,              xi.mod.EARTH_NULL,             xi.mod.LTNG_NULL,                  xi.mod.WATER_NULL,              xi.mod.LIGHT_NULL,          xi.mod.DARK_NULL          }
local blmMerit               = { xi.merit.FIRE_MAGIC_POTENCY,  xi.merit.ICE_MAGIC_POTENCY,  xi.merit.WIND_MAGIC_POTENCY,   xi.merit.EARTH_MAGIC_POTENCY,  xi.merit.LIGHTNING_MAGIC_POTENCY,  xi.merit.WATER_MAGIC_POTENCY    }
local rdmMerit               = { xi.merit.FIRE_MAGIC_ACCURACY, xi.merit.ICE_MAGIC_ACCURACY, xi.merit.WIND_MAGIC_ACCURACY,  xi.merit.EARTH_MAGIC_ACCURACY, xi.merit.LIGHTNING_MAGIC_ACCURACY, xi.merit.WATER_MAGIC_ACCURACY   }

-- Table variables.
local stat            = 1
local vNPC            = 2
local mNPC            = 3
local vPC             = 4
local inflectionPoint = 5
local zeroMultiplier  = 6
local bonusMAcc       = 13

local pTable =
{
-- Single target black magic spells:
-- Structure:           [spellId] = {  Stat used, vNPC, mNPC,  vPC,   I,  M0,  M50, M100, M200, M300, M400, M500, bonusMAcc },
    [xi.magic.spell.AERO        ] = { xi.mod.INT,   25,   1,   25,  35, 1.0,   0.5,  0.25, 0.125, 0.0625,   0.313,  0.0156,  0 },
    [xi.magic.spell.AERO_II     ] = { xi.mod.INT,  113,   1,  113, 133, 1.0,   0.5,  0.25, 0.125, 0.0625,   0.313,  0.0156, 10 },
    [xi.magic.spell.AERO_III    ] = { xi.mod.INT,  265, 1.5,  265, 295, 1.5,  0.75, 0.375, 0.188, 0.0938,  0.0469,  0.0234, 20 },
    [xi.magic.spell.AERO_IV     ] = { xi.mod.INT,  440,   2,  410, 472, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625, 0.03125, 20 },
    [xi.magic.spell.AERO_V      ] = { xi.mod.INT,  738, 2.3,  750, 550, 5.2,   4.5,   3.9,  2.98,   1.98,     1.0,     0.0, 25 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.AERO_VI     ] = { xi.mod.INT, 1070, 2.5, 1070, 600, 6.0,   5.8,   4.8,   3.8,    2.9,    1.98,     1.0,  0 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.TORNADO     ] = { xi.mod.INT,  552,   2,  657, 577, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625,  0.0313,  0 },
    [xi.magic.spell.TORNADO_II  ] = { xi.mod.INT,  710,   2,  710, 780, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625,  0.0313, 10 },
    [xi.magic.spell.BLIZZARD    ] = { xi.mod.INT,   46,   1,   46,  60, 1.0,   0.5,  0.25, 0.125, 0.0625,   0.313,  0.0156,  0 },
    [xi.magic.spell.BLIZZARD_II ] = { xi.mod.INT,  155,   1,  155, 178, 1.0,   0.5,  0.25, 0.125, 0.0625,   0.313,  0.0156, 10 },
    [xi.magic.spell.BLIZZARD_III] = { xi.mod.INT,  320, 1.5,  320, 345, 1.5,  0.75, 0.375, 0.188, 0.0938,  0.0469,  0.0234, 20 },
    [xi.magic.spell.BLIZZARD_IV ] = { xi.mod.INT,  506,   2,  541, 541, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625, 0.03125, 20 },
    [xi.magic.spell.BLIZZARD_V  ] = { xi.mod.INT,  829, 2.3,  850, 600, 4.4,   4.0,   3.8,  2.96,   1.96,     1.0,     0.0, 25 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.BLIZZARD_VI ] = { xi.mod.INT, 1190, 2.5, 1190, 650, 5.0,   5.6,   4.6,   3.6,    2.8,    1.96,     1.0,  0 }, -- I value unknown. Guesstimate used.
    [xi.magic.spell.FREEZE      ] = { xi.mod.INT,  552,   2,  603, 552, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625,  0.0313,  0 },
    [xi.magic.spell.FREEZE_II   ] = { xi.mod.INT,  710,   2,  710, 780, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625,  0.0313, 10 },
    [xi.magic.spell.FIRE        ] = { xi.mod.INT,   35,   1,   35,  46, 1.0,   0.5,  0.25, 0.125, 0.0625,   0.313,  0.0156,  0 },
    [xi.magic.spell.FIRE_II     ] = { xi.mod.INT,  133,   1,  133, 155, 1.0,   0.5,  0.25, 0.125, 0.0625,   0.313,  0.0156, 10 },
    [xi.magic.spell.FIRE_III    ] = { xi.mod.INT,  295, 1.5,  295, 320, 1.5,  0.75, 0.375, 0.188, 0.0938,  0.0469,  0.0234, 20 },
    [xi.magic.spell.FIRE_IV     ] = { xi.mod.INT,  472,   2,  472, 506, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625, 0.03125, 20 },
    [xi.magic.spell.FIRE_V      ] = { xi.mod.INT,  785, 2.3,  800, 550, 4.8,  4.24,  3.85,  2.97,   1.97,     1.0,     0.0, 25 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.FIRE_VI     ] = { xi.mod.INT, 1130, 2.5, 1130, 600, 5.5,   5.7,   4.7,   3.7,   2.85,    1.97,     1.0,   }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.FLARE       ] = { xi.mod.INT,  552,   2,  657, 684, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625,  0.0313,   },
    [xi.magic.spell.FLARE_II    ] = { xi.mod.INT,  710,   2,  710, 780, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625,  0.0313, 10 },
    [xi.magic.spell.STONE       ] = { xi.mod.INT,   10,   1,   10,  16, 1.0,   0.5,  0.25, 0.125, 0.0625,   0.313,  0.0156,  0 },
    [xi.magic.spell.STONE_II    ] = { xi.mod.INT,   78,   1,   78,  95, 1.0,   0.5,  0.25, 0.125, 0.0625,   0.313,  0.0156, 10 },
    [xi.magic.spell.STONE_III   ] = { xi.mod.INT,  210, 1.5,  210, 236, 1.5,  0.75, 0.375, 0.188, 0.0938,  0.0469,  0.0234, 20 },
    [xi.magic.spell.STONE_IV    ] = { xi.mod.INT,  381,   2,  381, 410, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625, 0.03125, 20 },
    [xi.magic.spell.STONE_V     ] = { xi.mod.INT,  626, 2.3,  650, 500, 6.0,   5.0,   4.0,   3.0,    2.0,     1.0,     0.0, 25 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.STONE_VI    ] = { xi.mod.INT,  950, 2.5,  950, 550, 7.0,   6.0,   5.0,   4.0,    3.0,     2.0,     1.0,  0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.QUAKE       ] = { xi.mod.INT,  552,   2,  577, 603, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625,  0.0313,  0 },
    [xi.magic.spell.QUAKE_II    ] = { xi.mod.INT,  710,   2,  710, 780, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625,  0.0313, 10 },
    [xi.magic.spell.THUNDER     ] = { xi.mod.INT,   60,   1,   60,  78, 1.0,   0.5,  0.25, 0.125, 0.0625,   0.313,  0.0156,  0 },
    [xi.magic.spell.THUNDER_II  ] = { xi.mod.INT,  178,   1,  178, 210, 1.0,   0.5,  0.25, 0.125, 0.0625,   0.313,  0.0156, 10 },
    [xi.magic.spell.THUNDER_III ] = { xi.mod.INT,  345, 1.5,  345, 381, 1.5,  0.75, 0.375, 0.188, 0.0938,  0.0469,  0.0234, 20 },
    [xi.magic.spell.THUNDER_IV  ] = { xi.mod.INT,  541,   2,  541, 626, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625, 0.03125, 20 },
    [xi.magic.spell.THUNDER_V   ] = { xi.mod.INT,  874, 2.3,  900, 700, 4.0,  3.74,  3.75,  2.95,   1.95,     1.0,     0.0, 25 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.THUNDER_VI  ] = { xi.mod.INT, 1250, 2.5, 1250, 750, 4.5,   5.5,   4.5,   3.5,   2.75,    1.95,     1.0,  0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.BURST       ] = { xi.mod.INT,  552,   2,  603, 630, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625,  0.0313,  0 },
    [xi.magic.spell.BURST_II    ] = { xi.mod.INT,  710,   2,  710, 780, 2.0,   1.0,   0.5,  0.25,  0.125,  0.0625,  0.0313, 10 },
    [xi.magic.spell.WATER       ] = { xi.mod.INT,   16,   1,   16,  25, 1.0,   0.5,  0.25, 0.125,  0.0625,  0.313,  0.0156,  0 },
    [xi.magic.spell.WATER_II    ] = { xi.mod.INT,   95,   1,  95, 113,  1.0,   0.5,  0.25, 0.125,  0.0625,  0.313,  0.0156, 10 },
    [xi.magic.spell.WATER_III   ] = { xi.mod.INT,  236, 1.5,  236, 265, 1.5,  0.75, 0.375, 0.188,  0.0938, 0.0469,  0.0234, 20 },
    [xi.magic.spell.WATER_IV    ] = { xi.mod.INT,  410,   2,  410, 440, 2.0,   1.0,   0.5,  0.25,   0.125, 0.0625, 0.03125, 20 },
    [xi.magic.spell.WATER_V     ] = { xi.mod.INT,  680, 2.3,  700, 500, 5.6,  4.74,  3.95,  2.99,    1.99,    1.0,     0.0, 25 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.WATER_VI    ] = { xi.mod.INT, 1010, 1.5, 1010, 550, 6.5,   5.9,   4.9,   3.9,    2.95,   1.99,     1.0,  0 }, -- I value Unknown. Guesstimate used.
    [xi.magic.spell.FLOOD       ] = { xi.mod.INT,  552,   2,  577, 657, 2.0,   1.0,   0.5,  0.25,   0.125, 0.0625,  0.0313,  0 },
    [xi.magic.spell.FLOOD_II    ] = { xi.mod.INT,  710,   2,  710, 780, 2.0,   1.0,   0.5,  0.25,   0.125, 0.0625,  0.0313, 10 },
    [xi.magic.spell.COMET       ] = { xi.mod.INT,  964, 2.3, 1000, 850, 4.0,  3.75,   3.5,   3.0,     2.0,    1.0,     1.0,  0 }, -- I value unknown. Guesstimate used.

-- Multiple target spells:
-- Structure:           [spellId] = {  Stat used, vNPC, mNPC,  vPC,   I,  M0,  M50, M100, M200, M300, M400, M500 },
    [xi.magic.spell.AEROGA      ] = { xi.mod.INT,   93,    1,  93, 120,  1.0,    0.5,    0.25,    0.125,    0.0625,    0.313,   0.0156 },
    [xi.magic.spell.AEROGA_II   ] = { xi.mod.INT,  266,    1,  266, 312, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.AEROGA_III  ] = { xi.mod.INT,  527,  1.5,  527, 642, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.AEROGA_IV   ] = { xi.mod.INT,  738,    2,    0, 700,   1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Aero V.
    [xi.magic.spell.AEROGA_V    ] = { xi.mod.INT, 1070,  2.3,    0, 750,   1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Aero VI.
    [xi.magic.spell.AERA        ] = { xi.mod.INT,  210,    1,  93, 250,  1.0,    0.5,    0.25,    0.125,    0.0625,    0.313,   0.0156 },
    [xi.magic.spell.AERA_II     ] = { xi.mod.INT,  430,    1,  266, 600, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.AERA_III    ] = { xi.mod.INT,  710,  1.5,  527, 700, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.AEROJA      ] = { xi.mod.INT,  844,  2.3,  850, 800, 5.2,  4.5,  3.9,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.BLIZZAGA    ] = { xi.mod.INT,  145,    1,  145, 172, 1.0,    0.5,    0.25,    0.125,    0.0625,    0.313,   0.0156 },
    [xi.magic.spell.BLIZZAGA_II ] = { xi.mod.INT,  350,    1,  350, 392, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.BLIZZAGA_III] = { xi.mod.INT,  642,  1.5,  642, 697, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.BLIZZAGA_IV ] = { xi.mod.INT,  829,    2,    0, 800,   1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Blizzard V.
    [xi.magic.spell.BLIZZAGA_V  ] = { xi.mod.INT, 1190,  2.3,    0, 950,   1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Blizzard VI.
    [xi.magic.spell.BLIZZARA    ] = { xi.mod.INT,  270,    1,  145, 300, 1.0,    0.5,    0.25,    0.125,    0.0625,    0.313,   0.0156 },
    [xi.magic.spell.BLIZZARA_II ] = { xi.mod.INT,  510,    1,  350, 550, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.BLIZZARA_III] = { xi.mod.INT,  830,  1.5,  642, 850, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.BLIZZAJA    ] = { xi.mod.INT,  953,  2.3,  950, 950, 4.4,    4,  3.8,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.FIRAGA      ] = { xi.mod.INT,  120,    1,  120, 145, 1.0,    0.5,    0.25,    0.125,    0.0625,    0.313,   0.0156 },
    [xi.magic.spell.FIRAGA_II   ] = { xi.mod.INT,  312,    1,  312, 350, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.FIRAGA_III  ] = { xi.mod.INT,  589,  1.5,  589, 642, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.FIRAGA_IV   ] = { xi.mod.INT,  785,    2,    0, 700,   1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Fire V.
    [xi.magic.spell.FIRAGA_V    ] = { xi.mod.INT, 1130,  2.3,    0, 800,   1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Fire VI.
    [xi.magic.spell.FIRA        ] = { xi.mod.INT,  240,    1,  120, 250, 1.0,    0.5,    0.25,    0.125,    0.0625,    0.313,   0.0156 },
    [xi.magic.spell.FIRA_II     ] = { xi.mod.INT,  470,    1,  312, 500, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.FIRA_III    ] = { xi.mod.INT,  760,  1.5,  589, 800, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.FIRAJA      ] = { xi.mod.INT,  902,  2.3,  900, 950, 4.8, 4.25, 3.85,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.STONEGA     ] = { xi.mod.INT,   56,    1,   56,  74,   1.0,    0.5,    0.25,    0.125,    0.0625,    0.313,   0.0156 },
    [xi.magic.spell.STONEGA_II  ] = { xi.mod.INT,  201,    1,  201, 232,   1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.STONEGA_III ] = { xi.mod.INT,  434,  1.5,  434, 480,   1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.STONEGA_IV  ] = { xi.mod.INT,  626,    2,    0, 650,   1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Stone V.
    [xi.magic.spell.STONEGA_V   ] = { xi.mod.INT,  950,  2.3,    0, 950,   1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Stone VI.
    [xi.magic.spell.STONERA     ] = { xi.mod.INT,  150,    1,  56, 150,   1.0,    0.5,    0.25,    0.125,    0.0625,    0.313,   0.0156 },
    [xi.magic.spell.STONERA_II  ] = { xi.mod.INT,  350,    1,  201, 350,  1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.STONERA_III ] = { xi.mod.INT,  650,  1.5,  434, 650,  1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.STONEJA     ] = { xi.mod.INT,  719,  2.3,  750, 750,   6,    5,    4,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.THUNDAGA    ] = { xi.mod.INT,  172,    1,  172, 201, 1.0,    0.5,    0.25,    0.125,    0.0625,    0.313,   0.0156 },
    [xi.magic.spell.THUNDAGA_II ] = { xi.mod.INT,  392,    1,  392, 434, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.THUNDAGA_III] = { xi.mod.INT,  697,  1.5,  697, 719, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.THUNDAGA_IV ] = { xi.mod.INT,  874,    2,    0, 900,   1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Thunder V.
    [xi.magic.spell.THUNDAGA_V  ] = { xi.mod.INT, 1250,  2.3,    0, 999,   1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Thunder VI.
    [xi.magic.spell.THUNDARA    ] = { xi.mod.INT,  300,    1,  172, 300, 1.0,    0.5,    0.25,    0.125,    0.0625,    0.313,   0.0156 },
    [xi.magic.spell.THUNDARA_II ] = { xi.mod.INT,  550,    1,  392, 550, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.THUNDARA_III] = { xi.mod.INT,  900,  1.5,  697, 900, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.THUNDAJA    ] = { xi.mod.INT, 1005,  2.3, 1000, 999,   4, 3.75, 3.75,    3,    2,    1,    0 }, -- Some values not found. Used guesstimates for M200 and M300.
    [xi.magic.spell.WATERGA     ] = { xi.mod.INT,   74,    1,   74,  96, 1.0,    0.5,    0.25,    0.125,    0.0625,    0.313,   0.0156 },
    [xi.magic.spell.WATERGA_II  ] = { xi.mod.INT,  232,    1,  232, 266, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.WATERGA_III ] = { xi.mod.INT,  480,  1.5,  480, 527, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.WATERGA_IV  ] = { xi.mod.INT,  680,    2,    0, 700,   1,    1,    1,    1,    1,    1,    0 }, -- Enemy only. No data found. Values taken from Water V.
    [xi.magic.spell.WATERGA_V   ] = { xi.mod.INT, 1010,  2.3,    0, 900,   1,    1,    1,    1,    1,    1,    1 }, -- Enemy only. No data found. Values taken from Water VI.
    [xi.magic.spell.WATERA      ] = { xi.mod.INT,  180,    1,  74, 200,  1.0,    0.5,    0.25,    0.125,    0.0625,    0.313,   0.0156 },
    [xi.magic.spell.WATERA_II   ] = { xi.mod.INT,  390,    1,  232, 400, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
    [xi.magic.spell.WATERA_III  ] = { xi.mod.INT,  660,  1.5,  480, 700, 1.5,  0.75,  0.375,    0.188,    0.0938,    0.0469,    0.0234 },
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
}

-----------------------------------
-- Basic Functions
-----------------------------------
-- TODO: Reduce complexity
-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
xi.spells.damage.calculateBaseDamage = function(caster, target, spell, spellId, skillType, statDiff)
    local spellDamage          = 0 -- The variable we want to calculate
    local baseSpellDamage      = 0 -- (V) In Wiki.
    local baseSpellDamageBonus = 0 -- (mDMG) In Wiki. Get from equipment, status, etc
    local statDiffBonus        = 0 -- statDiff x appropriate multipliers.

    -- Spell Damage = baseSpellDamage + statDiffBonus + baseSpellDamageBonus

    -----------------------------------
    -- STEP 1: baseSpellDamage (V)
    -----------------------------------
    if caster:isPC() and not xi.settings.main.USE_OLD_MAGIC_DAMAGE then
        baseSpellDamage = pTable[spellId][vPC] -- vPC
    else
        baseSpellDamage = pTable[spellId][vNPC] -- vNPC
    end

    -----------------------------------
    -- STEP 2: statDiffBonus (statDiff * M)
    -----------------------------------
    -- Black spell.
    if skillType == xi.skill.ELEMENTAL_MAGIC then
        if caster:isPC() then
            -- (M) In wiki.
            local spellMultiplier0   = pTable[spellId][zeroMultiplier]
            local spellMultiplier50  = pTable[spellId][zeroMultiplier + 1]
            local spellMultiplier100 = pTable[spellId][zeroMultiplier + 2]
            local spellMultiplier200 = pTable[spellId][zeroMultiplier + 3]
            local spellMultiplier300 = pTable[spellId][zeroMultiplier + 4]
            local spellMultiplier400 = pTable[spellId][zeroMultiplier + 5]
            local spellMultiplier500 = pTable[spellId][zeroMultiplier + 6]

            -- Ugly, but better than 7 more values in spells table.
            if statDiff < 50 then
                statDiffBonus = math.floor(statDiff * spellMultiplier0)
            elseif statDiff < 100 and statDiff >= 50 then
                statDiffBonus = math.floor(50 * spellMultiplier0) + math.floor((statDiff - 50) * spellMultiplier50)
            elseif statDiff < 200 and statDiff >= 100 then
                statDiffBonus = math.floor(50 * spellMultiplier0) + math.floor(50 * spellMultiplier50) + math.floor((statDiff - 100) * spellMultiplier100)
            elseif statDiff < 300 and statDiff >= 200 then
                statDiffBonus = math.floor(50 * spellMultiplier0) + math.floor(50 * spellMultiplier50) + math.floor(100 * spellMultiplier100) + math.floor((statDiff - 200) * spellMultiplier200)
            elseif statDiff < 400 and statDiff >= 300 then
                statDiffBonus = math.floor(50 * spellMultiplier0) + math.floor(50 * spellMultiplier50) + math.floor(100 * spellMultiplier100) + math.floor(100 * spellMultiplier200)
                statDiffBonus = statDiffBonus + math.floor((statDiff - 300) * spellMultiplier300)
            elseif statDiff < 500 and statDiff >= 400 then
                statDiffBonus = math.floor(50 * spellMultiplier0) + math.floor(50 * spellMultiplier50) + math.floor(100 * spellMultiplier100) + math.floor(100 * spellMultiplier200)
                statDiffBonus = statDiffBonus + math.floor(100 * spellMultiplier300) + math.floor((statDiff - 400) * spellMultiplier400)
            else -- It's over 500!
                statDiffBonus = math.floor(50 * spellMultiplier0) + math.floor(50 * spellMultiplier50) + math.floor(100 * spellMultiplier100) + math.floor(100 * spellMultiplier200)
                statDiffBonus = statDiffBonus + math.floor(100 * spellMultiplier300) + math.floor(100 * spellMultiplier400) + math.floor((statDiff - 500) * spellMultiplier500)
            end
        end

    -- Divine magic and Non-Player Elemental magic. TODO: Investigate "inflection point" (I) and its relation with the terms "soft cap" and "hard cap"
    elseif
        skillType == xi.skill.DIVINE_MAGIC or
        (skillType == xi.skill.ELEMENTAL_MAGIC and not caster:isPC())
    then
        local spellMultiplier = pTable[spellId][mNPC] -- M
        local inflexionPoint  = pTable[spellId][inflectionPoint] -- I
        if statDiff <= 0 then
            statDiffBonus = statDiff
        elseif statDiff > 0 and statDiff <= inflexionPoint then
            statDiffBonus = math.floor(statDiff * spellMultiplier)
        else
            statDiffBonus = math.floor(inflexionPoint * spellMultiplier) + math.floor((statDiff - inflexionPoint) * spellMultiplier / 2)
        end

    -- Ninjutsu.
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

    if -- Ultima Holy II
        caster:isMob() and
        caster:getPool() == 3209 and
        spellId == 22
    then
        spellDamage = math.random(750, 950)
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

xi.spells.damage.calculateMEVA = function(caster, target, levelDiff, resMod)
    local magiceva = target:getMod(xi.mod.MEVA)
    local mobCheck = target:isMob() and target:isNM() == false
    if target:isPC() then
        return magiceva + resMod
    elseif mobCheck and target:getMainLvl() <= 25 then
        levelDiff = utils.clamp(levelDiff, 0, 99) -- Mobs should not have a disadvantage when targeted
        return magiceva + (2 * levelDiff) + resMod
    elseif mobCheck and target:getMainLvl() <= 50 then
        levelDiff = utils.clamp(levelDiff, 0, 99) -- Mobs should not have a disadvantage when targeted
        return magiceva + (3 * levelDiff) + resMod
    else
        levelDiff = utils.clamp(levelDiff, 0, 99) -- Mobs should not have a disadvantage when targeted
        return magiceva + (4 * levelDiff) + resMod
    end
end

-- This function is used to calculate Resist tiers. The resist tiers work differently for enfeebles (which usually affect duration, not potency) than for nukes.
-- This is for nukes damage only. If an spell happens to do both damage and apply an status effect, they are calculated separately.
-- TODO: Reduce complexity
-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
xi.spells.damage.calculateResist = function(caster, target, spell, skillType, spellElement, statDiff, bonusMagicAccuracy, element)
    xi.msg.debug(caster, "======================")
    xi.msg.debug(caster, "xi.spells.damage.calculateResist")
    xi.msg.debug(caster, "======================")

    local resist        = 1 -- The variable we want to calculate
    local casterJob     = caster:getMainJob()
    local casterWeather = caster:getWeather()
    local spellGroup    = spell and spell:getSpellGroup() or xi.magic.spellGroup.NONE
    local spellId = 0
    local eleBonusMagicAccuracy = 0

    if spell then
        spellId = spell:getID()
        eleBonusMagicAccuracy = pTable[spellId][bonusMAcc]
    end

    local magicAcc = caster:getMod(xi.mod.MACC) + caster:getILvlMacc(xi.slot.MAIN)
    local resMod   = 0 -- Some spells may possibly be non elemental.

    -- The only damage spells that have bonus accuracy are single target ele nukes
    if eleBonusMagicAccuracy ~= nil then
        magicAcc = magicAcc + eleBonusMagicAccuracy
    end

    -- Magic Bursts of the correct element do not get resisted. SDT isn't involved here.
    local _, skillchainCount = xi.magic.FormMagicBurst(spellElement, target)
    xi.msg.debugValue(caster, "Skillchain Count", skillchainCount)

    -- Function flow:
    -- Step 0: We check for exceptions that would make the next steps obsolete.
    -- Step 1: We calculate caster magic Accuracy. Substeps categorized. Magic accuracy has no effect on potency.
    -- Step 2: We calculate target magic Evasion.
    -- Step 3: We calculate magic Hit Rate with the values calculated in steps 1 and 2.
    -- Step 4: We calculate resist tiers based off magic hit rate.

    -----------------------------------
    -- STEP 0: Exceptions.
    -----------------------------------
    -- Magic Shield and magic burst exceptions.
    -- Removed return 1 for skillchains, skillchains can/should be resisted
    if target:hasStatusEffect(xi.effect.MAGIC_SHIELD, 0) then
        xi.msg.debug(caster, "Target has Magic Shield, Resist Value 0")
        resist = 0
        return resist
    end

    -----------------------------------
    -- STEP 1: Get Caster Magic Accuracy.
    -----------------------------------
    -- Get the base magicAcc (just skill + skill mod (79 + skillID = ModID))
    if skillType ~= 0 then
        magicAcc = magicAcc + caster:getSkillLevel(skillType)
    else
        -- For mob skills / additional effects which don't have a skill.
        magicAcc = magicAcc + utils.getSkillLvl(1, caster:getMainLvl())
    end

    xi.msg.debugValue(caster, "Base Magic Accuracy", magicAcc)

    if spellElement ~= xi.magic.ele.NONE then
        -- Mod set in database. Base 0 means not resistant nor weak.
        resMod = utils.clamp(target:getMod(xi.magic.resistMod[element]) - 50, 0, 999)
        xi.msg.debugValue(caster, "Ele Resistance Mod", resMod)

        -- Add acc for elemental affinity accuracy and element specific accuracy
        local affinityBonus = caster:getMod(strongAffinityAcc[spellElement]) * 10
        xi.msg.debugValue(caster, "Affinity Bonus", affinityBonus)
        local elementBonus  = caster:getMod(spellAcc[spellElement])
        xi.msg.debugValue(caster, "Elemental Bonus", elementBonus)
        magicAcc = magicAcc + affinityBonus + elementBonus
        if
            math.random(1, 100) <= 33 or
            caster:getMod(elementalObi[spellElement]) >= 1
        then
            local dayElement = VanadielDayElement()
            -- Strong day.
            if dayElement == spellElement then
                magicAcc = magicAcc + 5

            -- Weak day.
            elseif dayElement == xi.magic.elementDescendant[spellElement] then
                magicAcc = magicAcc - 5
            end

            local weather = caster:getWeather()
            -- Strong weathers.
            if weather == xi.magic.singleWeatherStrong[spellElement] then
                magicAcc = magicAcc + caster:getMod(xi.mod.IRIDESCENCE) * 5 + 5
            elseif weather == xi.magic.doubleWeatherStrong[spellElement] then
                magicAcc = magicAcc + caster:getMod(xi.mod.IRIDESCENCE) * 5 + 10

            -- Weak weathers.
            elseif weather == xi.magic.singleWeatherWeak[spellElement] then
                magicAcc = magicAcc - caster:getMod(xi.mod.IRIDESCENCE) * 5 - 5
            elseif weather == xi.magic.doubleWeatherWeak[spellElement] then
                magicAcc = magicAcc - caster:getMod(xi.mod.IRIDESCENCE) * 5 - 10
            end
        end

        xi.msg.debugValue(caster, "Adjusted Magic Accuracy", magicAcc)
    end

    -- Get dStat Magic Accuracy. NOTE: Ninjutsu does not get this bonus/penalty.
    if skillType ~= xi.skill.NINJUTSU then
        if statDiff > 10 then
            magicAcc = magicAcc + 10 + (statDiff - 10) / 2
        else
            magicAcc = magicAcc + statDiff
        end

        xi.msg.debugValue(caster, "dStat Magic Accuracy Adjustment", magicAcc)
    end

    -----------------------------------
    -- magicAcc from status effects.
    -----------------------------------
    -- Altruism
    if
        caster:hasStatusEffect(xi.effect.ALTRUISM) and
        spellGroup == xi.magic.spellGroup.WHITE
    then
        magicAcc = magicAcc + caster:getStatusEffect(xi.effect.ALTRUISM):getPower()
    end

    -- Focalization
    if
        caster:hasStatusEffect(xi.effect.FOCALIZATION) and
        spellGroup == xi.magic.spellGroup.BLACK
    then
        magicAcc = magicAcc + caster:getStatusEffect(xi.effect.FOCALIZATION):getPower()
    end

    --Add acc for klimaform
    if
        spellElement > 0 and
        caster:hasStatusEffect(xi.effect.KLIMAFORM) and
        (casterWeather == xi.magic.singleWeatherStrong[spellElement] or casterWeather == xi.magic.doubleWeatherStrong[spellElement])
    then
        magicAcc = magicAcc + 15
    end

    -- Apply Divine Emblem to Banish and Holy families
    if
        casterJob == xi.job.PLD and
        skillType == xi.skill.DIVINE_MAGIC and
        caster:hasStatusEffect(xi.effect.DIVINE_EMBLEM)
    then
        magicAcc = magicAcc + 100 -- TODO: Confirm this value in retail
    end

    -- Dark Seal
    if
        casterJob == xi.job.DRK and
        skillType == xi.skill.DARK_MAGIC and
        caster:hasStatusEffect(xi.effect.DARK_SEAL)
    then
        magicAcc = magicAcc + 256 -- Need citation. 256 seems OP
        xi.msg.debugValue(caster, "Dark Seal Magic Accuracy Adjustment", magicAcc)
    end

    if caster:hasStatusEffect(xi.effect.ELEMENTAL_SEAL) then
        magicAcc = magicAcc + 256
        xi.msg.debugValue(caster, "Elemental Seal Magic Accuracy Adjustment", magicAcc)
    end

    -- Apply bonus magic accuracy for skillchains
    if skillchainCount > 0 then
        magicAcc = magicAcc + 25
        xi.msg.debugValue(caster, "Skillchain Bonus Magic Accuracy", magicAcc)
    end

    -- Apply bonus macc from TandemStrike
    local tandemBonus = xi.magic.handleTandemStrikeBonus(caster)
    if tandemBonus > 0 then
        magicAcc = magicAcc + tandemBonus
        xi.msg.debugValue(caster, "Tandem Strike Magic Accuracy Bonus", magicAcc)
    end

    -----------------------------------
    -- magicAcc from Job Points.
    -----------------------------------
    switch (casterJob) : caseof
    {
        [xi.job.WHM] = function()
            magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.WHM_MAGIC_ACC_BONUS)
        end,

        [xi.job.BLM] = function()
            magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.BLM_MAGIC_ACC_BONUS)
        end,

        [xi.job.RDM] = function()
            -- RDM Job Point: During saboteur, Enfeebling MACC +2
            if
                skillType == xi.skill.ENFEEBLING_MAGIC and
                caster:hasStatusEffect(xi.effect.SABOTEUR)
            then
                magicAcc = magicAcc + (caster:getJobPointLevel(xi.jp.SABOTEUR_EFFECT)) * 2
            end

            -- RDM Job Point: Magic Accuracy Bonus, All MACC + 1
            magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.RDM_MAGIC_ACC_BONUS)
        end,

        [xi.job.NIN] = function()
            if skillType == xi.skill.NINJUTSU then
                magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.NINJITSU_ACC_BONUS)
            end
        end,

        [xi.job.SCH] = function()
            if
                (spellGroup == xi.magic.spellGroup.WHITE and caster:hasStatusEffect(xi.effect.PARSIMONY)) or
                (spellGroup == xi.magic.spellGroup.BLACK and caster:hasStatusEffect(xi.effect.PENURY))
            then
                magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.STRATEGEM_EFFECT_I)
            end
        end,
    }

    -----------------------------------
    -- magicAcc from Merits.
    -----------------------------------
    switch (casterJob) : caseof
    {
        [xi.job.BLM] = function()
            if skillType == xi.skill.ELEMENTAL_MAGIC then
                magicAcc = magicAcc + caster:getMerit(xi.merit.ELEMENTAL_MAGIC_ACCURACY)
            end
        end,

        [xi.job.RDM] = function()
            -- Category 1
            if
                spellElement >= xi.magic.element.FIRE and
                spellElement <= xi.magic.element.WATER
            then
                magicAcc = magicAcc + caster:getMerit(rdmMerit[spellElement])
            end

            -- Category 2
            magicAcc = magicAcc + caster:getMerit(xi.merit.MAGIC_ACCURACY)
        end,

        [xi.job.NIN] = function()
            if skillType == xi.skill.NINJUTSU then
                magicAcc = magicAcc + caster:getMerit(xi.merit.NIN_MAGIC_ACCURACY)
            end
        end,

        [xi.job.BLU] = function()
            if skillType == xi.skill.BLUE_MAGIC then
                magicAcc = magicAcc + caster:getMerit(xi.merit.MAGICAL_ACCURACY)
            end
        end,
    }

    -----------------------------------
    -- magicAcc from Food.
    -----------------------------------
    local maccFood = magicAcc * (caster:getMod(xi.mod.FOOD_MACCP) / 100)
    magicAcc = magicAcc + utils.clamp(maccFood, 0, caster:getMod(xi.mod.FOOD_MACC_CAP))

    xi.msg.debugValue(caster, "Food Magic Accuracy Adjustment", magicAcc)

    -----------------------------------
    -- Apply level correction.
    -----------------------------------
    local levelDiff = target:getMainLvl() - caster:getMainLvl()

    -----------------------------------
    -- STEP 2: Get target magic evasion
    -- Base magic evasion (base magic evasion plus resistances(players), plus elemental defense(mobs)
    -----------------------------------
    local magiceva = target:getMod(xi.mod.MEVA)
    if target:isPC() then
        magiceva = magiceva + resMod
    else
        levelDiff = utils.clamp(levelDiff, 0, 200) -- Mobs should not have a disadvantage when targeted
        magiceva =  magiceva + (4 * levelDiff) + resMod
    end

    xi.msg.debugValue(caster, "Target Magic Evasion", magiceva)

    -----------------------------------
    -- STEP 3: Get Magic Hit Rate
    -- https://www.bg-wiki.com/ffxi/Magic_Hit_Rate
    -----------------------------------
    local magicHitRate = xi.magic.calculateMagicHitRate(magicAcc, magiceva, target, element, skillchainCount, skillType, caster, true)

    -----------------------------------
    -- STEP 4: Get Resist Tier
    -----------------------------------
    local resistVal = xi.magic.getMagicResist(magicHitRate, target, element, 0, skillchainCount, nil, caster, true)
    return resistVal
end

xi.spells.damage.calculateIfMagicBurst = function(caster, target, spell, spellElement) -- Calculates if a magic burst should occur.
    local magicBurst         = 1 -- The variable we want to calculate
    local _, skillchainCount = xi.magic.FormMagicBurst(spellElement, target) -- External function. Not present in magic.lua.

    if skillchainCount > 0 and target:hasStatusEffect(xi.effect.SKILLCHAIN) then
        -- Calculate the skillchain magic burst bonus based on number of skillchain steps
        if skillchainCount < 3 then  -- 2-stage Skillchain: MB = 1.35
            magicBurst = 1.35
        elseif skillchainCount < 4 then -- 3-stage Skillchain: MB = 1.45
            magicBurst = 1.45
        else -- X-stage Skillchain
            magicBurst = 1.25 + (0.1 * skillchainCount)
        end
    end

    return magicBurst
end

xi.spells.damage.calculateIfMagicBurstBonus = function(caster, target, spell, spellId, spellElement) -- Calculates the bonus damage applied to the spell.
    local magicBurstBonus        = 1.0
    local modBurst               = 1.0
    local ancientMagicBurstBonus = 0
    local _, skillchainCount = xi.magic.FormMagicBurst(spellElement, target) -- External function. Not present in magic.lua.

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
    xi.msg.debug(caster, "======================")
    xi.msg.debug(caster, "xi.spells.damage.calculateMagicBonusDiff")
    xi.msg.debug(caster, "======================")

    local magicBonusDiff = 1 -- The variable we want to calculate
    local casterJob      = caster:getMainJob()
    local mab            = caster:getMod(xi.mod.MATT)
    local mabCrit        = caster:getMod(xi.mod.MAGIC_CRITHITRATE)
    local mDefBarBonus   = 0

    xi.msg.debugValue(caster, "Base MAB", mab)
    xi.msg.debugValue(caster, "MAB Crit Rate", mabCrit)

    -- Ninja spell bonuses
    if skillType == xi.skill.NINJUTSU then
        -- Ninja Category 2 merits.
        mab = mab + caster:getMerit(xi.merit.NIN_MAGIC_BONUS)
        -- Ninja nuke bonus (for example from Koga Hatsuburi)
        mab = mab + caster:getMod(xi.mod.NIN_NUKE_BONUS)
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

    xi.msg.debugValue(caster, "Merit-adjusted MAB", mab)

    if math.random(1, 100) < mabCrit then
        mab = mab + 10 + caster:getMod(xi.mod.MAGIC_CRIT_DMG_INCREASE)
    end

    xi.msg.debugValue(caster, "MAB Crit Adjustment", mab)

    -- Bar Spells bonuses
    if
        spellElement >= xi.magic.element.FIRE and
        spellElement <= xi.magic.element.WATER
    then
        mab = mab + caster:getMerit(blmMerit[spellElement])
        xi.msg.debugValue(caster, "BLM Merit-adjusted MAB", mab)
        if target:hasStatusEffect(xi.magic.barSpell[spellElement]) then -- bar- spell magic defense bonus
            mDefBarBonus = target:getStatusEffect(xi.magic.barSpell[spellElement]):getSubPower()
        end
    end

    xi.msg.debugValue(caster, "Bar Spell MDEF Bonus", mDefBarBonus)

    -- Job Point MAB
    if casterJob == xi.job.RDM then
        mab = mab + caster:getJobPointLevel(xi.jp.RDM_MAGIC_ATK_BONUS)
    elseif casterJob == xi.job.GEO then
        mab = mab + caster:getJobPointLevel(xi.jp.GEO_MAGIC_ATK_BONUS)
    end

    -- Ancient Magic I and II MAB
    if spellId > 203 and spellId < 216 then -- If spell is Ancient Magic
        mab = mab + caster:getMerit(xi.merit.ANCIENT_MAGIC_ATK_BONUS)
    end

    xi.msg.debugValue(caster, "Ancient Magic-adjusted MAB", mab)

    xi.msg.debugValue(caster, "Target MDEF", target:getMod(xi.mod.MDEF))
    xi.msg.debugValue(caster, "Bar-spell Adjusted MDEF", target:getMod(xi.mod.MDEF) + mDefBarBonus)

    magicBonusDiff = (100 + mab) / (100 + target:getMod(xi.mod.MDEF) + mDefBarBonus)

    xi.msg.debugValue(caster, "Magic Bonus Difference", magicBonusDiff)

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

    targetMagicDamageAdjustment = xi.damage.returnDamageTakenMod(target, xi.attackType.MAGICAL, damageType)

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

-----------------------------------
-- Spell Helper Function
-----------------------------------
xi.spells.damage.useDamageSpell = function(caster, target, spell)
    local finalDamage  = 0 -- The variable we want to calculate

    -- Get Tabled Variables.
    local spellId         = spell:getID()
    local skillType       = spell:getSkillType()
    local spellElement    = spell:getElement()
    local statDiff        = caster:getStat(pTable[spellId][stat]) - target:getStat(pTable[spellId][stat])
    local spellDamageType = xi.damageType.ELEMENTAL + spellElement

    -- Magic Bursts of the correct element do not get resisted. SDT isn't involved here.
    local _, skillchainCount = xi.magic.FormMagicBurst(spellElement, target)
    local failedDiceRoll  = utils.ternary(math.random() >= 0.95, false, true)

    -- Variables/steps to calculate finalDamage.
    local spellDamage                 = xi.spells.damage.calculateBaseDamage(caster, target, spell, spellId, skillType, statDiff)
    local multipleTargetReduction     = xi.spells.damage.calculateMTDR(caster, target, spell)
    local eleStaffBonus               = xi.spells.damage.calculateEleStaffBonus(caster, spell, spellElement)
    local magianAffinity              = xi.spells.damage.calculateMagianAffinity(caster, spell)
    local resist                      = xi.spells.damage.calculateResist(caster, target,  spell, skillType, spellElement, statDiff, 0, spellElement)
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

    -- Debug
    xi.msg.debug(caster, "======================")
    xi.msg.debug(caster, "Final Damage Params")
    xi.msg.debug(caster, "======================")
    xi.msg.debugValue(caster, "Base Spell Damage", spellDamage)
    xi.msg.debugValue(caster, "Multi-target Damage Reduction", multipleTargetReduction)
    xi.msg.debugValue(caster, "Element Staff Bonus", eleStaffBonus)
    xi.msg.debugValue(caster, "Magian Affinity", magianAffinity)
    xi.msg.debugValue(caster, "Magic Resist State", resist)
    xi.msg.debugValue(caster, "Resist Tier Dice Roll", utils.ternary(failedDiceRoll, "Failed", "Success"))
    xi.msg.debugValue(caster, "Magic Burst Multiplier", magicBurst)
    xi.msg.debugValue(caster, "Magic Burst Bonus", magicBurstBonus)
    xi.msg.debugValue(caster, "Day & Weather Bonus", dayAndWeather)
    xi.msg.debugValue(caster, "Magic Bonus Difference", magicBonusDiff)
    xi.msg.debugValue(caster, "Target Magic Damage Adjustment", targetMagicDamageAdjustment)
    xi.msg.debugValue(caster, "Divine Emblem Multipleir", divineEmblemMultiplier)
    xi.msg.debugValue(caster, "Ebullience Multiplier", ebullienceMultiplier)
    xi.msg.debugValue(caster, "Skill Type Multiplier", skillTypeMultiplier)
    xi.msg.debugValue(caster, "Ninjutsu Skill Bonus", ninSkillBonus)
    xi.msg.debugValue(caster, "Ninjutsu Futae Bonus", ninFutaeBonus)
    xi.msg.debugValue(caster, "Undead Divine Penalty", undeadDivinePenalty)
    xi.msg.debugValue(caster, "Nuke Absorb / Nullify", nukeAbsorbOrNullify)

    -- Calculate finalDamage. It MUST be floored after EACH multiplication.
    finalDamage = math.floor(spellDamage * multipleTargetReduction)
    xi.msg.debugValue(caster, "MTDR Damage", finalDamage)
    finalDamage = math.floor(finalDamage * eleStaffBonus)
    xi.msg.debugValue(caster, "Ele Staff Bonus Damage", finalDamage)
    finalDamage = math.floor(finalDamage * magianAffinity)
    xi.msg.debugValue(caster, "Magian Affinity Damage", finalDamage)
    -- If this is a magic burst, player has a 5% chance to land a fully unresisted nuke
    finalDamage = math.floor(finalDamage * utils.ternary(skillchainCount > 0 and not failedDiceRoll, 1, resist))
    xi.msg.debugValue(caster, "Resist Damage", finalDamage)

    -- Apply magic burst damage
    finalDamage = math.floor(finalDamage * magicBurst)
    xi.msg.debugValue(caster, "Magic Burst Damage", finalDamage)
    finalDamage = math.floor(finalDamage * magicBurstBonus)
    xi.msg.debugValue(caster, "Magic Burst Bonus Damage", finalDamage)

    finalDamage = math.floor(finalDamage * dayAndWeather)
    xi.msg.debugValue(caster, "Day/Weather Damage", finalDamage)
    finalDamage = math.floor(finalDamage * magicBonusDiff)
    xi.msg.debugValue(caster, "Magic Bonus Diff Damage", finalDamage)
    finalDamage = math.floor(finalDamage * targetMagicDamageAdjustment)
    xi.msg.debugValue(caster, "Target Magic Adjustment Damage", finalDamage)
    finalDamage = math.floor(finalDamage * divineEmblemMultiplier)
    xi.msg.debugValue(caster, "Divine Emblem Damage", finalDamage)
    finalDamage = math.floor(finalDamage * ebullienceMultiplier)
    xi.msg.debugValue(caster, "Ebullience Damage", finalDamage)
    finalDamage = math.floor(finalDamage * skillTypeMultiplier)
    xi.msg.debugValue(caster, "Skill Type Damage", finalDamage)
    finalDamage = math.floor(finalDamage * ninSkillBonus)
    xi.msg.debugValue(caster, "Ninjutsu Skill Bonus Damage", finalDamage)
    finalDamage = math.floor(finalDamage * ninFutaeBonus)
    xi.msg.debugValue(caster, "Ninjutsu Futae BOnus Damage", finalDamage)
    finalDamage = math.floor(finalDamage * undeadDivinePenalty)
    xi.msg.debugValue(caster, "Undead Penalty Damage", finalDamage)
    finalDamage = math.floor(finalDamage * scarletDeliriumMultiplier)
    xi.msg.debugValue(caster, "Scarlet Delirium Damage", finalDamage)
    finalDamage = math.floor(finalDamage * nukeAbsorbOrNullify)
    xi.msg.debugValue(caster, "Nuke Absorb / Nullify Damage", finalDamage)

    if finalDamage > 0 then
        finalDamage = utils.clamp(finalDamage - target:getMod(xi.mod.PHALANX), 0, 99999)
        xi.msg.debugValue(caster, "Phalanx Reduction", target:getMod(xi.mod.PHALANX))
        finalDamage = utils.clamp(utils.oneforall(target, finalDamage), 0, 99999)
        local preRampartDmg = finalDamage
        finalDamage = utils.clamp(utils.rampart(target, finalDamage), -99999, 99999)
        xi.msg.debugValue(caster, "Rampart Reduction", preRampartDmg - finalDamage)
        local preStoneskinDmg = finalDamage
        finalDamage = utils.clamp(utils.stoneskin(target, finalDamage), -99999, 99999)
        xi.msg.debugValue(caster, "Stoneskin Reduction", preStoneskinDmg - finalDamage)
    end

    if
        target:hasStatusEffect(xi.effect.SKILLCHAIN) and
        magicBurst > 1 and
        finalDamage > 0
    then
        target:triggerListener("MAGIC_BURST_TAKE", caster, target, finalDamage)
    end

    -- Handle Magic Absorb
    if finalDamage < 0 then
        finalDamage = target:addHP(-finalDamage)
        spell:setMsg(xi.msg.basic.MAGIC_RECOVERS_HP)

    -- Handle final adjustments. Most are located in core. TODO: Decide if we want core handling this.
    else
        -- Modifier that causes mob to take either 0 or 1 damage.
        if target:getLocalVar("DAMAGE_NULL") == 1 then
            finalDamage = finalDamage % 2
        end

        -- Handle Bind break and TP?
        target:takeSpellDamage(caster, spell, finalDamage, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL + spellElement)

        -- Handle Afflatus Misery.
        target:handleAfflatusMiseryDamage(finalDamage)

        if target:hasStatusEffect(xi.effect.SKILLCHAIN) and (magicBurst > 1) then -- Gated as this is run per target.
            if caster:isPC() then
                caster:setLocalVar("[MAGICBURST]Enmity_Reduction", 1)
                caster:setLocalVar("[MAGICBURST]Enmity_Reduction_State", 1)
            end
        end

        -- Handle Enmity.
        target:updateEnmityFromDamage(caster, finalDamage)

        -- Only add TP if the target is a mob and if the spell actually does damage.
        if target:getObjType() ~= xi.objType.PC and finalDamage > 0 then
            target:addTP(100)
        end

        -- Add "Magic Burst!" message
        if target:hasStatusEffect(xi.effect.SKILLCHAIN) and (magicBurst > 1) then -- Gated as this is run per target.
            spell:setMsg(spell:getMagicBurstMessage())
            caster:triggerRoeEvent(xi.roe.triggers.magicBurst)
        end
    end

    xi.msg.debugValue(caster, "Final Damage", finalDamage)
    xi.msg.debug(caster, "======================")

    return finalDamage
end
