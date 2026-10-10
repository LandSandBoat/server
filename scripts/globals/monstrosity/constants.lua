-----------------------------------
-- Monstrosity - Constants
-----------------------------------
require('scripts/globals/monstrosity/settings')
require('scripts/globals/quests')
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

-----------------------------------
-- Feretory
-----------------------------------
xi.monstrosity.feretoryEntrance = { x = -358, y = -3.4, z = -440, rot = 64 }

-- The client lists the starters as rabbit, lizard, mandragora.
xi.monstrosity.starterCutsceneIndex =
{
    [xi.monstrositySpecies.RABBIT    ] = 1,
    [xi.monstrositySpecies.LIZARD    ] = 2,
    [xi.monstrositySpecies.MANDRAGORA] = 3,
}

-----------------------------------
-- Belligerency
-----------------------------------
-- The zones are fixed by the client menu, the level caps are not (JP wiki, BG).
xi.monstrosity.belligerencyCaps =
{
    [xi.zone.BUBURIMU_PENINSULA] = 30,
    [xi.zone.XARCABARD]          = 60,
    [xi.zone.ULEGUERAND_RANGE]   = 90,
}

-----------------------------------
-- Relinquish
-----------------------------------
-- Retail counts down from 4, 3 s apart.
xi.monstrosity.relinquishCount    = 4
xi.monstrosity.relinquishInterval = 3000

-- Slip damage stops Relinquish before it counts, though the recast is still spent.
xi.monstrosity.relinquishBlockers =
{
    xi.effect.POISON,
    xi.effect.BIO,
    xi.effect.DIA,
    xi.effect.BURN,
    xi.effect.FROST,
    xi.effect.CHOKE,
    xi.effect.RASP,
    xi.effect.SHOCK,
    xi.effect.DROWN,
}

-----------------------------------
-- Teyrnon
-----------------------------------
-- Purchasable instincts: the race II instincts, then one per job. A job instinct is half price once
-- that job's limit break quest is done.
xi.monstrosity.instinctPrices =
{
    race        = 500,
    job         = 10000,
    limitBroken = 5000,
}

-- Purchased instinct names start at this message param. Lower values name an item.
xi.monstrosity.instinctNameBase = 30464

-- Only one limit break quest exists for each pre-ToAU job, so those read Maat's Cap instead.
xi.monstrosity.limitBreakQuests =
{
    [xi.job.BLU] = { xi.questLog.AHT_URHGAN,  xi.quest.id.ahtUrhgan.THE_BEAST_WITHIN           },
    [xi.job.COR] = { xi.questLog.AHT_URHGAN,  xi.quest.id.ahtUrhgan.BREAKING_THE_BONDS_OF_FATE },
    [xi.job.PUP] = { xi.questLog.BASTOK,      xi.quest.id.bastok.ACHIEVING_TRUE_POWER          },
    [xi.job.DNC] = { xi.questLog.JEUNO,       xi.quest.id.jeuno.A_FURIOUS_FINALE               },
    [xi.job.SCH] = { xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.SURVIVAL_OF_THE_WISEST    },
    [xi.job.GEO] = { xi.questLog.ADOULIN,     xi.quest.id.adoulin.ELEMENTARY_MY_DEAR_SYLVIE    },
    [xi.job.RUN] = { xi.questLog.ADOULIN,     xi.quest.id.adoulin.ENDEAVORING_TO_AWAKEN        },
}

-- Protect and Shell follow the spell tier for the Monipulator's level: the first row whose level it is under.
local protectTiers =
{
    { level = 27,  power = 20  },
    { level = 47,  power = 50  },
    { level = 63,  power = 90  },
    { level = 76,  power = 140 },
    { level = 100, power = 220 },
}

-- Shell power is in 1/256ths of 10000: Shell I is 27/256, Shell V 75/256.
local shellTiers =
{
    { level = 37,  power = 1055 },
    { level = 57,  power = 1641 },
    { level = 68,  power = 2188 },
    { level = 76,  power = 2617 },
    { level = 100, power = 2930 },
}

-- Teyrnon's buffs by menu slot. The costs are fixed in the client event, the durations come from capture
-- timers. Dedication pays its bonus until expCap exp is gained. tierBonus is added per tier under
-- ENHANCES_PROT_SHELL_RCVD.
xi.monstrosity.teyrnonBuffs =
{
    [0] = { cost = 3000, effect = xi.effect.DEDICATION, power = 50,   duration = 3600, expCap = 10000 },
    [1] = { cost = 400,  effect = xi.effect.DEDICATION, power = 100,  duration = 3600, expCap = 2000  },
    [2] = { cost = 10,   effect = xi.effect.REGEN,      power = 1,    duration = 3600, tick = 3       },
    [3] = { cost = 10,   effect = xi.effect.REFRESH,    power = 1,    duration = 3600, tick = 3       },
    [4] = { cost = 100,  effect = xi.effect.PROTECT,    tiers = protectTiers, tierBonus = 2, duration = 1800 },
    [5] = { cost = 100,  effect = xi.effect.SHELL,      tiers = shellTiers,   tierBonus = 39, duration = 1800 },
    [6] = { cost = 100,  effect = xi.effect.HASTE,      power = 1000, duration = 1800 },
}
