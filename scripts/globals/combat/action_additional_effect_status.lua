-----------------------------------
-- Global file for additional effects (Status Effects)
-----------------------------------
require('scripts/globals/combat/magic_hit_rate')
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.action = xi.combat.action or {}
-----------------------------------

local defaultsTable =
{
    [xi.effect.AMNESIA      ] = { xi.subEffect.AMNESIA,         xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.ATTACK_DOWN  ] = { xi.subEffect.ATTACK_DOWN,     xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.BIND         ] = { xi.subEffect.DARKNESS_DAMAGE, xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.BLINDNESS    ] = { xi.subEffect.BLIND,           xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.CURSE_I      ] = { xi.subEffect.CURSE,           xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.DEFENSE_DOWN ] = { xi.subEffect.DEFENSE_DOWN,    xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.EVASION_DOWN ] = { xi.subEffect.EVASION_DOWN,    xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.KO           ] = { xi.subEffect.DEATH,           xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.NONE         ] = { xi.subEffect.DARKNESS_DAMAGE, xi.msg.basic.ADD_EFFECT_DISPEL },
    [xi.effect.PARALYSIS    ] = { xi.subEffect.PARALYSIS,       xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.PETRIFICATION] = { xi.subEffect.PETRIFY,         xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.PLAGUE       ] = { xi.subEffect.PLAGUE,          xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.POISON       ] = { xi.subEffect.POISON,          xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.SILENCE      ] = { xi.subEffect.SILENCE,         xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.SLEEP_I      ] = { xi.subEffect.SLEEP,           xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.SLOW         ] = { xi.subEffect.SLOW,            xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.STUN         ] = { xi.subEffect.STUN,            xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.TERROR       ] = { xi.subEffect.PARALYSIS,       xi.msg.basic.ADD_EFFECT_STATUS },
    [xi.effect.WEIGHT       ] = { xi.subEffect.ATTACK_DOWN,     xi.msg.basic.ADD_EFFECT_STATUS },
}

-----------------------------------
-- Local functions to ensure defaults are set.
-----------------------------------
local function validateParameters(actor, target, fedData)
    local params = {}

    -- Additional effect target.
    params.aeTarget     = fedData.aeTarget or target -- Default to the current attack target.

    -- Chance.
    params.chance       = fedData.chance or 100 -- Default: Always proc.

    -- Status effect application parameters.
    params.effectId     = fedData.effectId or xi.effect.NONE
    params.power        = fedData.power or 0
    params.tick         = fedData.tick or 0
    params.duration     = fedData.duration or 120
    params.subType      = fedData.subType or 0
    params.subPower     = fedData.subPower or 0
    params.tier         = fedData.tier or 0

    -- Action properties.
    params.element      = fedData.element or xi.element.NONE
    params.actorStat    = fedData.actorStat or 0
    params.targetStat   = fedData.targetStat or params.actorStat -- Currently unused. For future use.
    params.macc         = fedData.macc or 0
    params.resistRate   = fedData.resistRate or 0

    -- Optional behavior.
    params.resetEmnity  = fedData.resetEmnity or false
    params.absorbEffect = fedData.absorbEffect or false

    -- Animations and messaging.
    params.animation    = fedData.animation or (defaultsTable[params.effectId][1] or 0)
    params.message      = fedData.message or (defaultsTable[params.effectId][2] or 0)

    return params
end

-----------------------------------
-- Global functions called from "emtity.onAdditionalEffect()"
-----------------------------------
xi.combat.action.executeAddEffectEnhancement = function(actor, target, fedData)
    local params = validateParameters(actor, target, fedData)

    -- Early return: Incorrect effect ID.
    if params.effectId == xi.effect.NONE then
        return 0, 0, 0
    end

    -- Early return: No proc.
    if math.random(1, 100) > params.chance then
        return 0, 0, 0
    end

    -- Early return: Target has an status effect that invalidates current (Outright incompatible or higher tier).
    if xi.data.statusEffect.isEffectNullified(params.aeTarget, params.effectId, params.tier) then
        return 0, 0, 0
    end

    -- Apply effect.
    if params.aeTarget:addStatusEffect(params.effectId, params.power, params.tick, params.duration, params.subType, params.subPower, params.tier) then
        return params.animation, params.message, params.effectId
    end

    return 0, 0, 0
end

xi.combat.action.executeAddEffectEnfeeblement = function(actor, target, fedData)
    local params = validateParameters(actor, target, fedData)

    -- Early return: Incorrect effect ID.
    if params.effectId == xi.effect.NONE then
        return 0, 0, 0
    end

    -- Early return: No proc.
    if math.random(1, 100) > params.chance then
        return 0, 0, 0
    end

    -- Early return: Target is immune.
    if xi.data.statusEffect.isTargetImmune(params.aeTarget, params.effectId, params.element) then
        return 0, 0, 0
    end

    -- Early return: Target triggers resist trait.
    if xi.data.statusEffect.isTargetResistant(actor, params.aeTarget, params.effectId) then
        return 0, 0, 0
    end

    -- Early return: Target has an status effect that invalidates current (Outright incompatible or higher tier).
    if xi.data.statusEffect.isEffectNullified(params.aeTarget, params.effectId, params.tier) then
        return 0, 0, 0
    end

    -- Early return: Resist rate too high.
    local resistanceRate = xi.combat.magicHitRate.calculateResistRate(actor, params.aeTarget, 0, 0, xi.skillRank.A_PLUS, params.element, params.actorStat, params.effectId, params.macc)
    if not xi.data.statusEffect.isResistRateSuccessfull(params.effectId, resistanceRate, params.resistRate) then
        return 0, 0, 0
    end

    -- Calculate duration.
    local totalDuration = math.floor(params.duration * resistanceRate)

    -- Apply effect.
    if params.aeTarget:addStatusEffect(params.effectId, params.power, params.tick, totalDuration, params.subType, params.subPower, params.tier) then
        return params.animation, params.message, params.effectId
    end

    return 0, 0, 0
end

xi.combat.action.executeAddEffectDispel = function(actor, target, fedData)
    local params = validateParameters(actor, target, fedData)

    -- Early return: Incorrect effect ID.
    if params.effectId ~= xi.effect.NONE then
        return 0, 0, 0
    end

    -- Early return: No proc.
    if math.random(1, 100) > params.chance then
        return 0, 0, 0
    end

    -- Early return: No dispelable effect.
    if not params.aeTarget:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) then
        return 0, 0, 0
    end

    -- Early return: Resist rate too high.
    local resistanceRate = xi.combat.magicHitRate.calculateResistRate(actor, params.aeTarget, 0, 0, xi.skillRank.A_PLUS, params.element, params.actorStat, params.effectId, params.macc)
    if not xi.data.statusEffect.isResistRateSuccessfull(params.effectId, resistanceRate, params.resistRate) then
        return 0, 0, 0
    end

    -- Attampt to dispel or steal an status effect.
    local dispelledEffect = 0
    if params.absorbEffect then
        dispelledEffect = actor:stealStatusEffect(params.aeTarget, xi.effectFlag.DISPELABLE, true)
    else
        dispelledEffect = params.aeTarget:dispelStatusEffect(xi.effectFlag.DISPELABLE)
    end

    if dispelledEffect == 0 then
        return 0, 0, 0
    end

    return params.animation, params.message, dispelledEffect
end
