-----------------------------------
-- Global file for mobskills that apply status effects.
-----------------------------------
require('scripts/globals/combat/damage_multipliers')
require('scripts/globals/combat/magic_hit_rate')
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.action = xi.combat.action or {}
-----------------------------------

-- Define each step where the process can end.
local step =
{
    CANT_GAIN           = 1,
    IMMUNE_CHECK        = 2,
    RESIST_TRAIT_CHECK  = 3,
    NULLIFY_CHECK       = 4,
    RESIST_RATE_CHECK   = 5,
    APPLICATION_FAIL    = 6,
    APPLICATION_SUCCESS = 7,
}

-- Validate the parameters of an specific entry of the status effect table.
local function validateEffectParameters(fedData)
    local params = {}

    -- Status effect application parameters.
    params.effectId   = fedData.effectId or 0
    params.power      = fedData.power or 0
    params.tick       = fedData.tick or 0
    params.duration   = fedData.duration or 0
    params.subType    = fedData.subType or 0
    params.subPower   = fedData.subPower or 0
    params.tier       = fedData.tier or 0

    -- Calculation parameters.
    params.element    = fedData.element or xi.data.statusEffect.getAssociatedElement(params.effectId, xi.element.NONE)
    params.rank       = fedData.rank or xi.skillRank.A_PLUS -- The skill rank used for macc.
    params.stat       = fedData.stat or xi.mod.INT          -- Stat used for macc.
    params.macc       = fedData.macc or 0                   -- Flat macc bonus addition.
    params.resistRate = fedData.resistRate or 0

    return params
end

-- Validate the parameters of the skill messaging.
local function validateMessageParameters(fedData)
    local params = {}

    -- Action messages per step.
    params.messageBypass          = fedData.messageBypass or false
    params.messageCantGain        = fedData.messageCantGain or xi.msg.basic.SKILL_NO_EFFECT
    params.messageIsImmune        = fedData.messageIsImmune or xi.msg.basic.SKILL_MISS
    params.messageIsTraitResisted = fedData.messageIsTraitResisted or xi.msg.basic.SKILL_MISS
    params.messageIsIncompatible  = fedData.messageIsIncompatible or xi.msg.basic.SKILL_MISS
    params.messageIsResisted      = fedData.messageIsResisted or xi.msg.basic.SKILL_MISS
    params.messageIsNotSuccessful = fedData.messageIsNotSuccessful or xi.msg.basic.SKILL_MISS
    params.messageIsSuccessful    = fedData.messageIsSuccessful or xi.msg.basic.SKILL_ENFEEB_IS

    return params
end

-- Handle (and apply) the action status effect.
local function handleStatusEffect(actor, target, params)
    -- Check if can gain.
    if not target:canGainStatusEffect(params.effectId, params.power) then
        return step.CANT_GAIN
    end

    -- Check immunity.
    if xi.data.statusEffect.isTargetImmune(target, params.effectId, params.element) then
        return step.IMMUNE_CHECK

    -- Check resist traits.
    elseif xi.data.statusEffect.isTargetResistant(actor, target, params.effectId) then
        return step.RESIST_TRAIT_CHECK

    -- Check effect incompatibilities.
    elseif xi.data.statusEffect.isEffectNullified(target, params.effectId, params.tier) then
        return step.NULLIFY_CHECK
    end

    -- Calculate resist state.
    local resistanceRate = xi.combat.magicHitRate.calculateResistRate(actor, target, 0, 0, params.rank, params.element, params.stat, params.effectId, params.macc)
    if not xi.data.statusEffect.isResistRateSuccessfull(params.effectId, resistanceRate, params.resistRate) then
        return step.RESIST_RATE_CHECK
    end

    -- Calculate duration.
    local totalDuration = math.floor(params.duration * resistanceRate)

    -- Apply effect.
    if target:addStatusEffect(params.effectId, { power = params.power, duration = totalDuration, origin = actor, tick = params.tick, subType = params.subType, subPower = params.subPower, tier = params.tier }) then
        return step.APPLICATION_SUCCESS
    end

    return step.APPLICATION_FAIL
end

-- Handle (set) the action message Id.
local function handleActionMessage(skill, bestResult, messageParams)
    if messageParams.messageBypass then
        return
    end

    switch(bestResult): caseof
    {
        [step.CANT_GAIN] = function()
            skill:setMsg(messageParams.messageCantGain)
        end,

        [step.IMMUNE_CHECK] = function()
            skill:setMsg(messageParams.messageIsImmune)
        end,

        [step.RESIST_TRAIT_CHECK] = function()
            skill:setMsg(messageParams.messageIsTraitResisted)
        end,

        [step.NULLIFY_CHECK] = function()
            skill:setMsg(messageParams.messageIsIncompatible)
        end,

        [step.RESIST_RATE_CHECK] = function()
            skill:setMsg(messageParams.messageIsResisted)
        end,

        [step.APPLICATION_FAIL] = function()
            skill:setMsg(messageParams.messageIsNotSuccessful)
        end,

        [step.APPLICATION_SUCCESS] = function()
            skill:setMsg(messageParams.messageIsSuccessful)
        end,
    }
end

xi.combat.action.executeMobskillStatusEffect = function(actor, target, skill, effectData, messageData)
    -- Cycle over all effects. Apply (or not) and save the result in a table.
    local dTableEffectResults = {}
    for i = 1, #effectData do
        local effectParams = validateEffectParameters(effectData[i])
        local result       = handleStatusEffect(actor, target, effectParams)
        table.insert(dTableEffectResults, i, { effectParams.effectId, result })
    end

    -- Decide best effect outcome, for the message and the effect Id to return.
    local bestResult = 0
    local bestIndex  = 0

    for j = 1, #dTableEffectResults do
        local currentResult = dTableEffectResults[j][2]
        if currentResult > bestResult then
            bestResult = currentResult
            bestIndex  = j
        end
    end

    -- Fetch best effect Id.
    local effectId = dTableEffectResults[bestIndex][1]

    -- Handle messaging.
    local messageParams = validateMessageParameters(messageData)
    handleActionMessage(skill, bestResult, messageParams)

    -- Return best effect Id.
    return effectId
end
