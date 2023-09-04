-----------------------------------
-- Corsair Job Utilities
-----------------------------------
require('scripts/globals/ability')
require('scripts/globals/jobpoints')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.corsair = xi.job_utils.corsair or {}
-----------------------------------

-- rollModifiers format: Effect Powers table, phantomBase, roll bonus increase, Effect, Mod, Optimal Job
-- NOTE: nil items below are nil values on purpose.  This might break if parameters are added to various bindings
-- TODO: replace 'nil' pet values with tables, handle multiple effects in case of pet roll. Will need core changes.
-- TODO: quantify Courser's Roll, no wiki seems to know what it is.
-- TODO: verify Corsair's Roll for subjob: see http://wiki.ffo.jp/html/6052.html
local corsairRollMods =
{
    [xi.jobAbility.CORSAIRS_ROLL   ] = { {  10,  11,   11,  12,   20,   13,  15,   16,    8,   17,   24,   6 },   2,   0, xi.effect.CORSAIRS_ROLL,    xi.mod.EXP_BONUS,          xi.job.COR  },
    [xi.jobAbility.NINJA_ROLL      ] = { {   4,   5,    5,  14,    6,    7,   9,    2,   10,   11,   18,   6 },   2,   6, xi.effect.NINJA_ROLL,       xi.mod.EVA,                xi.job.NIN  },
    [xi.jobAbility.HUNTERS_ROLL    ] = { {  10,  13,   15,  40,   18,   20,  25,    5,   27,   30,   50,   5 },   5,  15, xi.effect.HUNTERS_ROLL,     xi.mod.ACC,                xi.job.RNG  },
    [xi.jobAbility.CHAOS_ROLL      ] = { {   6,   8,    9,  25,   11,   13,  16,    3,   17,   19,   31,  10 },   3,  10, xi.effect.CHAOS_ROLL,       xi.mod.ATTP,               xi.job.DRK  },
    [xi.jobAbility.MAGUSS_ROLL     ] = { {   5,  20,    6,   8,    9,    3,  10,   13,   14,   15,   25,   5 },   2,   8, xi.effect.MAGUSS_ROLL,      xi.mod.MDEF,               xi.job.BLU  },
    [xi.jobAbility.HEALERS_ROLL    ] = { {   3,   4,   12,   5,    6,    7,   1,    8,    9,   10,   16,   4 },   3,   4, xi.effect.HEALERS_ROLL,     xi.mod.CURE_POTENCY_RCVD,  xi.job.WHM  },
    [xi.jobAbility.DRACHEN_ROLL    ] = { {  10,  13,   15,  40,   18,   20,  25,    5,   28,   30,   50,  15 },   5,  15, xi.effect.DRACHEN_ROLL,     nil,                       xi.job.DRG  },
    [xi.jobAbility.CHORAL_ROLL     ] = { {  13,  55,   17,  20,   25,    8,  30,   35,   40,   45,   65,  25 },   4,  25, xi.effect.CHORAL_ROLL,      xi.mod.SPELLINTERRUPT,     xi.job.BRD  },
    [xi.jobAbility.MONKS_ROLL      ] = { {   8,  10,   32,  12,   14,   16,   4,   20,   22,   24,   40,  11 },   4,  10, xi.effect.MONKS_ROLL,       xi.mod.SUBTLE_BLOW,        xi.job.MNK  },
    [xi.jobAbility.BEAST_ROLL      ] = { {   4,   5,    7,  19,    8,    9,  11,    2,   13,   14,   23,   7 },   3,  10, xi.effect.BEAST_ROLL,       nil,                       xi.job.BST  },
    [xi.jobAbility.SAMURAI_ROLL    ] = { {   8,  32,   10,  12,   14,    4,  16,   20,   22,   24,   40,   5 },   4,  10, xi.effect.SAMURAI_ROLL,     xi.mod.STORETP,            xi.job.SAM  },
    [xi.jobAbility.EVOKERS_ROLL    ] = { {   1,   1,    1,   1,    3,    2,   2,    2,    1,    3,    4,   1 },   1,   1, xi.effect.EVOKERS_ROLL,     xi.mod.REFRESH,            xi.job.SMN  },
    [xi.jobAbility.ROGUES_ROLL     ] = { {   2,   2,    3,   4,   12,    5,   6,    6,    1,    8,   19,   6 },   1,   6, xi.effect.ROGUES_ROLL,      xi.mod.CRITHITRATE,        xi.job.THF  },
    [xi.jobAbility.WARLOCKS_ROLL   ] = { {   2,   3,    4,  12,    5,    6,   7,    1,    8,    9,   15,   5 },   1,   5, xi.effect.WARLOCKS_ROLL,    xi.mod.MACC,               xi.job.RDM  },
    [xi.jobAbility.FIGHTERS_ROLL   ] = { {   2,   2,    3,   4,   12,    5,   6,    7,    1,    9,   18,   6 },   1,   6, xi.effect.FIGHTERS_ROLL,    xi.mod.DOUBLE_ATTACK,      xi.job.WAR  },
    [xi.jobAbility.PUPPET_ROLL     ] = { {   4,   5,   18,   7,    9,   10,   2,   11,   13,   15,   22,   8 },   3,   8, xi.effect.PUPPET_ROLL,      nil,                       xi.job.PUP  },
    [xi.jobAbility.GALLANTS_ROLL   ] = { { 600, 800, 2400, 900, 1100, 1200, 300, 1500, 1700, 1800, 3000, 500 }, 234, 500, xi.effect.GALLANTS_ROLL,    xi.mod.DMG,                xi.job.PLD  },
    [xi.jobAbility.WIZARDS_ROLL    ] = { {   4,   6,    8,  10,   25,   12,  14,   17,    2,   20,   30,  10 },   2,  10, xi.effect.WIZARDS_ROLL,     xi.mod.MATT,               xi.job.BLM  },
    [xi.jobAbility.DANCERS_ROLL    ] = { {   3,   4,   12,   5,    6,    7,   1,    8,    9,   10,   16,   4 },   2,   4, xi.effect.DANCERS_ROLL,     xi.mod.REGEN,              xi.job.DNC  },
    [xi.jobAbility.SCHOLARS_ROLL   ] = { {   2,   9,    3,   4,    5,    2,   6,    6,    7,    9,   14,   4 },   1,   4, xi.effect.SCHOLARS_ROLL,    xi.mod.CONSERVE_MP,        xi.job.SCH  },
    [xi.jobAbility.NATURALISTS_ROLL] = { {   6,   7,   15,   8,    9,   10,   5,   11,   12,   13,   20,  -5 },   1,   5, xi.effect.NATURALISTS_ROLL, xi.mod.ENH_MAGIC_DURATION, xi.job.GEO  },
    [xi.jobAbility.RUNEISTS_ROLL   ] = { {   4,   6,    8,  25,   10,   12,  14,    2,   17,   20,   30, -10 },   2,   7, xi.effect.RUNEISTS_ROLL,    xi.mod.MEVA,               xi.job.RUN  },
    [xi.jobAbility.BOLTERS_ROLL    ] = { {   6,   6,   16,   8,    8,   10,  10,   12,    4,   14,   20,   0 },   4,   0, xi.effect.BOLTERS_ROLL,     xi.mod.MOVE,               xi.job.NONE },
    [xi.jobAbility.CASTERS_ROLL    ] = { {   6,  15,    7,   8,    9,   10,   5,   11,   12,   13,   20, -10 },   3,  10, xi.effect.CASTERS_ROLL,     xi.mod.FASTCAST,           xi.job.NONE },
    [xi.jobAbility.COURSERS_ROLL   ] = { {   2,   3,   11,   4,    5,    6,   7,    8,    1,   10,   12,  -5 },   1,   3, xi.effect.COURSERS_ROLL,    nil,                       xi.job.NONE },
    [xi.jobAbility.BLITZERS_ROLL   ] = { {  -2,  -3,   -4, -11,   -5,   -6,  -7,   -8,   -1,  -10,  -12,   3 },  -1,  -3, xi.effect.BLITZERS_ROLL,    xi.mod.DELAYP,             xi.job.NONE },
    [xi.jobAbility.TACTICIANS_ROLL ] = { {  10,  10,   10,  10,   30,   10,  10,    0,   20,   20,   40, -10 },   2,  10, xi.effect.TACTICIANS_ROLL,  xi.mod.REGAIN,             xi.job.NONE },
    [xi.jobAbility.ALLIES_ROLL     ] = { {   2,   3,   20,   5,    7,    9,  11,   13,   15,    1,   25,  -5 },   1,   5, xi.effect.ALLIES_ROLL,      xi.mod.SKILLCHAINBONUS,    xi.job.NONE },
    [xi.jobAbility.MISERS_ROLL     ] = { {  30,  50,   70,  90,  200,  110,  20,  130,  150,  170,  250,   0 },  15,   0, xi.effect.MISERS_ROLL,      xi.mod.SAVETP,             xi.job.NONE },
    [xi.jobAbility.COMPANIONS_ROLL ] = { {   1,   2,    3,   4,    5,    6,   7,    8,    9,   10,   11,   0 },  10,   0, xi.effect.COMPANIONS_ROLL,  nil,                       xi.job.NONE },
    [xi.jobAbility.AVENGERS_ROLL   ] = { {   2,   2,    3,  12,    4,    5,   6,    1,    7,    9,   18,   6 },   1,   0, xi.effect.AVENGERS_ROLL,    xi.mod.COUNTER,            xi.job.NONE },
}

-- Check for xi.mod.PHANTOM_ROLL Value and apply non-stack logic.
local function phantombuffMultiple(caster)
    local phantomValue = caster:getMod(xi.mod.PHANTOM_ROLL)
    local phantomBuffMultiplier = 0

    if phantomValue == 3 then
        phantomBuffMultiplier = 3
    elseif
        phantomValue == 5 or
        phantomValue == 8
    then
        phantomBuffMultiplier = 5
    elseif
        phantomValue == 7 or
        phantomValue == 10 or
        phantomValue == 12 or
        phantomValue == 15
    then
        phantomBuffMultiplier = 7
    end

    return phantomBuffMultiplier
end

-- Sets local var if party contains specified job
local function checkForJobBonus(caster, job)
    local jobBonus = 0

    if
        job ~= xi.job.NONE and
        (
            caster:hasPartyJob(job) or
            math.random(0, 99) < caster:getMod(xi.mod.JOB_BONUS_CHANCE)
        )
    then
        jobBonus = 1
    end

    caster:setLocalVar('corsairRollBonus', jobBonus)
end

-- The following functions determine enhancement based on random vs effects
local function getRandomEnhancementRoll(caster, abilityId)
    local modValue = nil
    local randChance = math.random(0, 99)

    if abilityId == xi.jobAbility.CASTERS_ROLL then
        modValue = caster:getMod(xi.mod.ENHANCES_CASTERS_ROLL)
    elseif abilityId == xi.jobAbility.COURSERS_ROLL then
        modValue = caster:getMod(xi.mod.ENHANCES_COURSERS_ROLL)
    elseif abilityId == xi.jobAbility.BLITZERS_ROLL then
        modValue = caster:getMod(xi.mod.ENHANCES_BLITZERS_ROLL)
    elseif abilityId == xi.jobAbility.TACTICIANS_ROLL then
        modValue = caster:getMod(xi.mod.ENHANCES_TACTICIANS_ROLL)
    end

    return modValue ~= nil and randChance < modValue
end

local function checkForElevenRoll(caster)
    local effects = caster:getStatusEffects()

    for _, effect in pairs(effects) do
        if
            effect:getEffectType() >= xi.effect.FIGHTERS_ROLL and
            effect:getEffectType() <= xi.effect.NATURALISTS_ROLL and
            effect:getSubPower() == 11
        then
            return true
        end

        if
            effect:getEffectType() == xi.effect.RUNEISTS_ROLL and
            effect:getSubPower() == 11
        then
            return true
        end
    end

    return false
end

local function atMaxCorsairBusts(caster)
    local numBusts = caster:numBustEffects()
    return (numBusts >= 2 and caster:getMainJob() == xi.job.COR) or
        (numBusts >= 1 and caster:getMainJob() ~= xi.job.COR)
end

local function corsairSetup(caster, ability, action, effect, job)
    local roll = math.random(1, 6)
    caster:delStatusEffectSilent(xi.effect.DOUBLE_UP_CHANCE)
    caster:addStatusEffectEx(xi.effect.DOUBLE_UP_CHANCE,
        xi.effect.DOUBLE_UP_CHANCE,
        roll,
        0,
        45,
        ability:getID(),
        effect,
        job,
        true
    )
    caster:setLocalVar('corsairRollTotal', roll)
    action:speceffect(caster:getID(), roll)

    local numBustEffects = caster:numBustEffects()
    local recastReduction = caster:getMerit(xi.merit.PHANTOM_ROLL_RECAST) + caster:getMod(xi.mod.PHANTOM_RECAST)
    if checkForElevenRoll(caster) and numBustEffects == 0 then
        action:setRecast((ability:getRecast() / 2) - recastReduction) -- halves phantom roll recast timer for all rolls while under the effects of an 11 without bust (upon first hitting 11, phantom roll cooldown is reset in double-up.lua)
    else
        action:setRecast(ability:getRecast() - recastReduction) -- Corsair Recast merits + Phantom Roll Recast Reduction
    end

    checkForJobBonus(caster, job)
end

-- in_ability == current_ability if not using doubleup. current_ability is used to set the message whether you're using a doubleup or not.
local function applyRoll(caster, target, inAbility, action, total, isDoubleup, currentAbility)
    local abilityId = inAbility:getID()
    local duration = 300 + caster:getMerit(xi.merit.WINNING_STREAK) + caster:getMod(xi.mod.PHANTOM_DURATION) + (caster:getJobPointLevel(xi.jp.PHANTOM_ROLL_DURATION) * 2)
    local effectpowers = corsairRollMods[abilityId][1]
    local effectpower = effectpowers[total]
    local doBonus = getRandomEnhancementRoll(caster, abilityId)
    local bonusJob = corsairRollMods[abilityId][6]

    if bonusJob == xi.job.NONE and doBonus then
        effectpower = effectpower + corsairRollMods[abilityId][3]
    end

    if caster:getLocalVar('corsairRollBonus') == 1 and total < 12 then
        effectpower = effectpower + corsairRollMods[abilityId][3]
    end

    -- Apply Additional Phantom Roll+ Buff
    local phantomBase = corsairRollMods[abilityId][2] -- Base increment buff
    effectpower = effectpower + (phantomBase * phantombuffMultiple(caster))

    -- Effect Power varies depending on COR level (Main vs Sub)
    local actorLevel  = utils.getActiveJobLevel(caster, xi.job.COR)
    local targetLevel = target:getMainLvl()

    if actorLevel < targetLevel then
        effectpower = effectpower * actorLevel / targetLevel
    end

    if not target:addCorsairRoll(caster:getMainJob(), caster:getMerit(xi.merit.BUST_DURATION), corsairRollMods[abilityId][4], effectpower, 0, duration, caster:getID(), total, corsairRollMods[abilityId][5]) then
        -- no effect or otherwise prevented
        if caster:getID() == target:getID() then                  -- dead code? you can't roll if the same roll is already active. There is no known buff that would prevent a corsair roll.
            currentAbility:setMsg(xi.msg.basic.ROLL_MAIN_FAIL)    -- no effect for the COR rolling if they had the buff already
        else
            currentAbility:setMsg(xi.msg.basic.NO_EFFECT)         -- no effect for the target if they had the buff already. Testing in retail shows it's _not_ xi.msg.basic.ROLL_SUB_FAIL if the roll is already active. There is no known buff that would prevent a corsair roll, so maybe this would be used there if there were one?
        end
    elseif total > 11 then
        -- bust
        if caster:getID() == target:getID() then
            currentAbility:setMsg(xi.msg.basic.DOUBLEUP_BUST)     -- bust message for the COR rolling
        else
            currentAbility:setMsg(xi.msg.basic.DOUBLEUP_BUST_SUB) -- bust message for the target getting the roll
        end
    else
        -- success
        if caster:getID() == target:getID() then
            if isDoubleup then
                currentAbility:setMsg(xi.msg.basic.DOUBLEUP)      -- success on doubleup for COR has different message than from just using Phantom Roll
            else
                currentAbility:setMsg(xi.msg.basic.ROLL_MAIN)     -- success message for the COR rolling the first time
            end
        else
            currentAbility:setMsg(xi.msg.basic.ROLL_SUB)          -- message for the target getting the roll. Always the same, even if it's the COR's first roll.
        end
    end

    return total
end

-- TODO: Binding does not exist, implement this (old code remains)
xi.job_utils.corsair.useCuttingCards = function(caster, target, ability, action)
    if caster:getID() == target:getID() then
        local roll = math.random(1, 6)
        caster:setLocalVar('corsairRollTotal', roll)
        action:speceffect(caster:getID(), roll)
    end

    local total = caster:getLocalVar('corsairRollTotal')

    -- TODO: Implement
    -- caster:doCuttingCards(target, total)
    print('WARNING: doCuttingCards is not implemented')

    ability:setMsg(435 + math.floor((total - 1) / 2) * 2)
    action:setAnimation(target:getID(), 132 + (total) - 1)

    return total
end

xi.job_utils.corsair.useDoubleUp = function(caster, target, ability, action)
    if caster:getID() == target:getID() then -- the COR handles all the calculations
        local duEffect = caster:getStatusEffect(xi.effect.DOUBLE_UP_CHANCE)
        local prevRoll = caster:getStatusEffect(duEffect:getSubPower())
        local roll     = prevRoll:getSubPower()
        local job      = duEffect:getTier()

        caster:setLocalVar('corsairActiveRoll', duEffect:getSubType())
        local snakeEye = caster:getStatusEffect(xi.effect.SNAKE_EYE)
        if snakeEye then
            if prevRoll:getPower() >= 5 and math.random(100) < snakeEye:getPower() then
                roll = 11
            else
                roll = roll + 1
            end

            caster:delStatusEffect(xi.effect.SNAKE_EYE)
        else
            roll = roll + math.random(1, 6)
        end

        if roll >= 12 then -- bust
            roll = 12
            caster:delStatusEffectSilent(xi.effect.DOUBLE_UP_CHANCE)
        end

        if roll == 11 then
            caster:resetRecast(xi.recast.ABILITY, 193)
        end

        caster:setLocalVar('corsairRollTotal', roll)
        action:speceffect(caster:getID(), roll - prevRoll:getSubPower())
        checkForJobBonus(caster, job)
    end

    local total       = caster:getLocalVar('corsairRollTotal')
    local activeRoll  = caster:getLocalVar('corsairActiveRoll')
    local prevAbility = GetAbility(activeRoll)

    if prevAbility then -- Apply rolls to target(s), including the COR
        action:actionID(prevAbility:getID())

        total = applyRoll(caster, target, prevAbility, action, total, true, ability)

        if total > 11 then
            action:setAnimation(target:getID(), 98) -- 98 is bust anim for all rolls
        else
            action:setAnimation(target:getID(), prevAbility:getAnimation())
        end

        return total
    end
end

xi.job_utils.corsair.useWildCard = function(caster, target, ability, action)
    if caster:getID() == target:getID() then
        local roll = math.random(1, 6)
        caster:setLocalVar('corsairRollTotal', roll)
        action:speceffect(caster:getID(), roll)
    end

    local total = caster:getLocalVar('corsairRollTotal')
    caster:doWildCard(target, total)
    ability:setMsg(435 + math.floor((total - 1) / 2) * 2)
    action:setAnimation(target:getID(), 132 + (total) - 1)
    return total
end

-- Called by Phantom Rolls' onAbilityCheck
xi.job_utils.corsair.onRollAbilityCheck = function(player, target, ability)
    local abilityId = ability:getID()
    local effectId = corsairRollMods[abilityId][4]

    ability:setRange(ability:getRange() + player:getMod(xi.mod.ROLL_RANGE))
    if player:hasStatusEffect(effectId) then
        return xi.msg.basic.ROLL_ALREADY_ACTIVE, 0
    elseif atMaxCorsairBusts(player) then
        return xi.msg.basic.CANNOT_PERFORM, 0
    else
        return 0, 0
    end
end

-- Called by Phantom Rolls' onUseAbility
xi.job_utils.corsair.onRollUseAbility = function(caster, target, ability, action)
    local abilityId = ability:getID()
    local effectId = corsairRollMods[abilityId][4]
    local bonusJob = corsairRollMods[abilityId][6]

    if caster:getID() == target:getID() then
        corsairSetup(caster, ability, action, effectId, bonusJob)
    end

    local total = caster:getLocalVar('corsairRollTotal')
    return applyRoll(caster, target, ability, action, total, false, ability)
end

-- Called by Double Up ability onAbilityCheck
xi.job_utils.corsair.onDoubleUpAbilityCheck = function(player, target, ability)
    ability:setRange(ability:getRange() + player:getMod(xi.mod.ROLL_RANGE))

    if not player:hasStatusEffect(xi.effect.DOUBLE_UP_CHANCE) then
        return xi.msg.basic.NO_ELIGIBLE_ROLL, 0
    else
        return 0, 0
    end
end
