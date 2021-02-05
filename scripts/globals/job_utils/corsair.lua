-----------------------------------
-- Corsair Job Utilities
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local corsair = {}

-- rollModifiers format: effectpowers table, phantomBase, roll bonus increase, effect, mod
local corsairRollMods =
{
    [tpz.jobAbility.CORSAIRS_ROLL    ] = { {10, 11, 11, 12, 20, 13, 15, 16, 8, 17, 24, 6},          2,     0, tpz.effect.CORSAIRS_ROLL,    tpz.mod.EXP_BONUS          },
    [tpz.jobAbility.NINJA_ROLL       ] = { {4, 5, 5, 14, 6, 7, 9, 2, 10, 11, 18, 6},                2,     6, tpz.effect.NINJA_ROLL,       tpz.mod.EVA                },
    [tpz.jobAbility.HUNTERS_ROLL     ] = { {10, 13, 15, 40, 18, 20, 25, 5, 27, 30, 50, 5},          5,    15, tpz.effect.HUNTERS_ROLL,     tpz.mod.ACC                },
    [tpz.jobAbility.CHAOS_ROLL       ] = { {6, 8, 9, 25, 11, 13, 16, 3, 17, 19, 31, 10},            3,    10, tpz.effect.CHAOS_ROLL,       tpz.mod.ATTP               },
    [tpz.jobAbility.MAGUSS_ROLL      ] = { {5, 20, 6, 8, 9, 3, 10, 13, 14, 15, 25, 5},              2,     8, tpz.effect.MAGUSS_ROLL,      tpz.mod.MDEF               },
    [tpz.jobAbility.HEALERS_ROLL     ] = { {3, 4, 12, 5, 6, 7, 1, 8, 9, 10, 16, 4},                 3,     4, tpz.effect.HEALERS_ROLL,     tpz.mod.CURE_POTENCY_RCVD  },
    [tpz.jobAbility.DRACHEN_ROLL     ] = { {10, 13, 15, 40, 18, 20, 25, 5, 28, 30, 50, 15},         5,    15, tpz.effect.DRACHEN_ROLL,     MOD_PET_ACC                },
    [tpz.jobAbility.CHORAL_ROLL      ] = { {13, 55, 17, 20, 25, 8, 30, 35, 40, 45, 65, 25},         4,    25, tpz.effect.CHORAL_ROLL,      tpz.mod.SPELLINTERRUPT     },
    [tpz.jobAbility.MONKS_ROLL       ] = { {8, 10, 32, 12, 14, 16, 4, 20, 22, 24, 40, 11},          4,    10, tpz.effect.MONKS_ROLL,       tpz.mod.SUBTLE_BLOW        },
    [tpz.jobAbility.BEAST_ROLL       ] = { {4, 5, 7, 19, 8, 9, 11, 2, 13, 14, 23, 7},               3,    10, tpz.effect.BEAST_ROLL,       MOD_PET_ATTP               },
    [tpz.jobAbility.SAMURAI_ROLL     ] = { {8, 32, 10, 12, 14, 4, 16, 20, 22, 24, 40, 5},           4,    10, tpz.effect.SAMURAI_ROLL,     tpz.mod.STORETP            },
    [tpz.jobAbility.EVOKERS_ROLL     ] = { {1, 1, 1, 1, 3, 2, 2, 2, 1, 3, 4, 1},                    1,     1, tpz.effect.EVOKERS_ROLL,     tpz.mod.REFRESH            },
    [tpz.jobAbility.ROGUES_ROLL      ] = { {2, 2, 3, 4, 12, 5, 6, 6, 1, 8, 19, 6},                  1,     6, tpz.effect.ROGUES_ROLL,      tpz.mod.CRITHITRATE        },
    [tpz.jobAbility.WARLOCKS_ROLL    ] = { {2, 3, 4, 12, 5, 6, 7, 1, 8, 9, 15, 5},                  1,     5, tpz.effect.WARLOCKS_ROLL,    tpz.mod.MACC               },
    [tpz.jobAbility.FIGHTERS_ROLL    ] = { {2, 2, 3, 4, 12, 5, 6, 7, 1, 9, 18, 6},                  1,     6, tpz.effect.FIGHTERS_ROLL,    tpz.mod.DOUBLE_ATTACK      },
    [tpz.jobAbility.PUPPET_ROLL      ] = { {4, 5, 18, 7, 9, 10, 2, 11, 13, 15, 22, 8},              3,     8, tpz.effect.PUPPET_ROLL,      MOD_PET_MACC               },
    [tpz.jobAbility.GALLANTS_ROLL    ] = { {6, 8, 24, 9, 11, 12, 3, 15, 17, 18, 30, 5},          2.34,     5, tpz.effect.GALLANTS_ROLL,    tpz.mod.DMG                },
    [tpz.jobAbility.WIZARDS_ROLL     ] = { {4, 6, 8, 10, 25, 12, 14, 17, 2, 20, 30, 10},            2,    10, tpz.effect.WIZARDS_ROLL,     tpz.mod.MATT               },
    [tpz.jobAbility.DANCERS_ROLL     ] = { {3, 4, 12, 5, 6, 7, 1, 8, 9, 10, 16, 4},                 2,     4, tpz.effect.DANCERS_ROLL,     tpz.mod.REGEN              },
    [tpz.jobAbility.SCHOLARS_ROLL    ] = { {2, 9, 3, 4, 5, 2, 6, 6, 7, 9, 14, 4},                   1,     4, tpz.effect.SCHOLARS_ROLL,    tpz.mod.CONSERVE_MP        },
    [tpz.jobAbility.NATURALISTS_ROLL ] = { {6, 7, 15, 8, 9, 10, 5, 11, 12, 13, 20, -5},             1,     5, tpz.effect.NATURALISTS_ROLL, tpz.mod.ENH_MAGIC_DURATION },
    [tpz.jobAbility.RUNEISTS_ROLL    ] = { {4, 6, 8, 25, 10, 12, 14, 2, 17, 20, 30, -10},           2,     7, tpz.effect.RUNEISTS_ROLL,    tpz.mod.MEVA               },
    [tpz.jobAbility.BOLTERS_ROLL     ] = { {6, 6, 16, 8, 8, 10, 10, 12, 4, 14, 20, 0},              4,     0, tpz.effect.BOLTERS_ROLL,     tpz.mod.MOVE               },
    [tpz.jobAbility.CASTERS_ROLL     ] = { {6, 15, 7, 8, 9, 10, 5, 11, 12, 13, 20, -10},            3,    10, tpz.effect.CASTERS_ROLL,     tpz.mod.FASTCAST           }, -- math.random mods start here
    [tpz.jobAbility.COURSERS_ROLL    ] = { {2, 3, 11, 4, 5, 6, 7, 8, 1, 10, 12, -5},                1,     3, tpz.effect.COURSERS_ROLL,    MOD_SNAPSHOT               },
    [tpz.jobAbility.BLITZERS_ROLL    ] = { {2, 3, 4, 11, 5, 6, 7, 8, 1, 10, 12, -5},                1,     3, tpz.effect.BLITZERS_ROLL,    tpz.mod.DELAY              },
    [tpz.jobAbility.TACTICIANS_ROLL  ] = { {10, 10, 10, 10, 30, 10, 10, 0, 20, 20, 40, -10},        2,    10, tpz.effect.TACTICIANS_ROLL,  tpz.mod.REGAIN             },
    [tpz.jobAbility.ALLIES_ROLL      ] = { {2, 3, 20, 5, 7, 9, 11, 13, 15, 1, 25, -5},              1,     5, tpz.effect.ALLIES_ROLL,      tpz.mod.SKILLCHAINBONUS    }, -- end math.random mods
    [tpz.jobAbility.MISERS_ROLL      ] = { {30, 50, 70, 90, 200, 110, 20, 130, 150, 170, 250, 0},  15,     0, tpz.effect.MISERS_ROLL,      tpz.mod.SAVETP             },
    [tpz.jobAbility.COMPANIONS_ROLL  ] = { {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0},                 10,     0, tpz.effect.COMPANIONS_ROLL,  MOD_PET_REGAIN             },
    [tpz.jobAbility.AVENGERS_ROLL    ] = { {2, 2, 3, 12, 4, 5, 6, 1, 7, 9, 18, 6},                  1,     0, tpz.effect.AVENGERS_ROLL,    tpz.mod.COUNTER            },
}

-- Check for tpz.mod.PHANTOM_ROLL Value and apply non-stack logic.
local function phantombuffMultiple(caster)
    local phantomValue = caster:getMod(tpz.mod.PHANTOM_ROLL)
    local phantombuffValue = 0

    if phantomValue == 3 then
        phantombuffMultiplier = 3
    elseif phantomValue == 5 or phantomValue == 8 then
        phantombuffMultiplier = 5
    elseif phantomValue == 7 or phantomValue == 10 or phantomValue == 12 or phantomValue == 15 then
        phantombuffMultiplier = 7
    else
        phantombuffMultiplier = 0
    end

    return phantombuffMultiplier
end

-- The following functions determine enhancement based on random vs effects
local function getRandomEnhancementRoll(caster, abilityId)
    local modValue = nil
    local randChance = math.random(0, 99)

    if abilityId == tpz.jobAbility.CASTERS_ROLL then
        modValue = caster:getMod(tpz.mod.ENHANCES_CASTERS_ROLL)
    elseif abilityId == tpz.jobAbility.COURSERS_ROLL then
        modValue = caster:getMod(tpz.mod.ENHANCES_COURSERS_ROLL)
    elseif abilityId == tpz.jobAbility.BLITZERS_ROLL then
        modValue = caster:getMod(tpz.mod.ENHANCES_BLITZERS_ROLL)
    elseif abilityId == tpz.jobAbility.TACTICIANS_ROLL then
        modValue = caster:getMod(tpz.mod.ENHANCES_TACTICIANS_ROLL)
    end

    return modValue ~= nil, randChance < modValue
end

local function checkForElevenRoll(caster)
    local effects = caster:getStatusEffects()

    for _, effect in pairs(effects) do
        if
            effect:getType() >= tpz.effect.FIGHTERS_ROLL and
            effect:getType() <= tpz.effect.NATURALISTS_ROLL and
            effect:getSubPower() == 11
        then
            return true
        end

        if
            effect:getType() == tpz.effect.RUNEISTS_ROLL and
            effect:getSubPower() == 11)
        then
            return true
        end
    end

    return false
end

corsair.doCuttingCards = function(caster, target, ability, action, total)
    caster:doCuttingCards(target, total)
    ability:setMsg(435 + math.floor((total - 1) / 2) * 2)
    action:setAnimation(target:getID(), 132 + (total) - 1)
    return total
end

corsair.doWildCard = function(caster, target, ability, action, total)
    caster:doWildCard(target, total)
    ability:setMsg(435 + math.floor((total - 1) / 2) * 2)
    action:setAnimation(target:getID(), 132 + (total) - 1)
    return total
end

corsair.corsairSetup - function(caster, ability, action, effect, job)
    local roll = math.random(1, 6)
    caster:delStatusEffectSilent(tpz.effect.DOUBLE_UP_CHANCE)
    caster:addStatusEffectEx(tpz.effect.DOUBLE_UP_CHANCE,
                             tpz.effect.DOUBLE_UP_CHANCE,
                             roll,
                             0,
                             45,
                             ability:getID(),
                             effect,
                             job,
                             true)
    caster:setLocalVar("corsairRollTotal", roll)
    action:speceffect(caster:getID(), roll)

    if checkForElevenRoll(caster) then
        action:recast(action:recast() / 2) -- halves phantom roll recast timer for all rolls while under the effects of an 11 (upon first hitting 11, phantom roll cooldown is reset in double-up.lua)
    end

    corsair.checkForJobBonus(caster, job)
end

corsair.checkForJobBonus = function(caster, job)
    local jobBonus = 0

    if caster:hasPartyJob(job) or math.random(0, 99) < caster:getMod(tpz.mod.JOB_BONUS_CHANCE) then
        jobBonus = 1
    end

    caster:setLocalVar("corsairRollBonus", jobBonus)
end

corsair.atMaxCorsairBusts = function(caster)
    local numBusts = caster:numBustEffects()
    return (numBusts >= 2 and caster:getMainJob() == tpz.job.COR) or (numBusts >= 1 and caster:getMainJob() ~= tpz.job.COR)
end

corsair.applyRoll = function(caster, target, ability, action, total)
    local abilityId = ability:getID()
    local duration = 300 + caster:getMerit(tpz.merit.WINNING_STREAK) + caster:getMod(tpz.mod.PHANTOM_DURATION)
    local effectpowers = corsairRollMods[abilityId][1]
    local effectpower = effectpowers[total]
    local isRandomEnhancement, doBonus = getRandomEnhancementRoll(caster, abilityId)

    if isRandomEnhancement then -- Broken out because these are mutually exclusive.  Prevent the elseif from executing unintentionally.
        if doBonus then
            effectpower = effectpower + corsairRollMods[abilityId][3]
        end
    elseif caster:getLocalVar("corsairRollBonus") == 1 and total < 12 then
        effectpower = effectpower + corsairRollMods[abilityId][3]
    end

    -- Apply Additional Phantom Roll+ Buff
    local phantomBase = corsairRollMods[abilityId][2] -- Base increment buff
    local effectpower = effectpower + (phantomBase * phantombuffMultiple(caster))

    -- Check if COR Main or Sub
    if caster:getMainJob() == tpz.job.COR and caster:getMainLvl() < target:getMainLvl() then
        effectpower = effectpower * (caster:getMainLvl() / target:getMainLvl())
    elseif caster:getSubJob() == tpz.job.COR and caster:getSubLvl() < target:getMainLvl() then
        effectpower = effectpower * (caster:getSubLvl() / target:getMainLvl())
    end

    if target:addCorsairRoll(caster:getMainJob(), caster:getMerit(tpz.merit.BUST_DURATION), corsairRollMods[abilityId][4], effectpower, 0, duration, caster:getID(), total, corsairRollMods[abilityId][5]) == false then
        ability:setMsg(tpz.msg.basic.ROLL_MAIN_FAIL)
    elseif total > 11 then
        ability:setMsg(tpz.msg.basic.DOUBLEUP_BUST)
    end

    return total
end

return corsair
