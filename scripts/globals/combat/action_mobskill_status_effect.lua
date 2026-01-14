-----------------------------------
-- Global file for mobskills that apply status effects.
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.action = xi.combat.action or {}
-----------------------------------

local step =
{
    CANT_GAIN           = 1,
    IMMUNE_CHECK        = 2,
    RESIST_TRAIT_CHECK  = 3,
    NULLIFY_CHECK       = 4,
    RESIST_RATE_CHECK   = 5,
    APPLICATION_SUCCESS = 6,
    APPLICATION_FAIL    = 7,
}

local function validateParameters(effectData)
    local params = {}

    -- Status effect application parameters.
    params.effectId = effectData.effectId or 0
    params.power    = effectData.power or 0
    params.tick     = effectData.tick or 0
    params.duration = effectData.duration or 0
    params.subType  = effectData.subType or 0
    params.subPower = effectData.subPower or 0
    params.tier     = effectData.tier or 0

    -- Calculation parameters.
    params.resist = effectData.resist or 0.125             -- The amount of resists this effect allows. Example: Sleep can only resist once before failing, so value = 1/2 (No 1/4 nor 1/8)
    params.rank   = effectData.rank or xi.skillRank.A_PLUS -- The skill rank used for macc.
    params.stat   = effectData.stat or xi.mod.INT          -- Stat used for macc.
    params.macc   = effectData.macc or 0                   -- Flat macc bonus addition.

    return params
end

local function handleReturn(skill, setMessage, message, processStep)
    if not setMessage then
        return
    end

    -- TODO: Handle message modifiers with mobskills.
    -- if processStep == step.RESIST_TRAIT_CHECK then
    --     skill:setModifier(xi.msg.actionModifier.RESIST) -- Resist!
    -- end

    skill:setMsg(message)
end

xi.combat.action.executeMobskillStatusEffect = function(actor, target, skill, effectData, setMessage)
    -- Ensure all data fed is valid and initialized.
    local params = validateParameters(effectData)

    if not target:canGainStatusEffect(params.effectId, params.power) then
        return handleReturn(skill, setMessage, xi.msg.basic.SKILL_NO_EFFECT, step.CANT_GAIN)
    end

    local element = xi.data.statusEffect.getAssociatedElement(params.effectId, actor:getStatusEffectElement(params.effectId))

    -- Check immunity.
    if xi.data.statusEffect.isTargetImmune(target, params.effectId, element) then
        return handleReturn(skill, setMessage, xi.msg.basic.SKILL_MISS, step.IMMUNE_CHECK)

    -- Check resist traits.
    elseif xi.data.statusEffect.isTargetResistant(actor, target, params.effectId) then
        return handleReturn(skill, setMessage, xi.msg.basic.SKILL_MISS, step.RESIST_TRAIT_CHECK)

    -- Check effect incompatibilities.
    elseif xi.data.statusEffect.isEffectNullified(target, params.effectId, params.tier) then
        return handleReturn(skill, setMessage, xi.msg.basic.SKILL_MISS, step.NULLIFY_CHECK)
    end

    -- Calculate resist state.
    local resistRate = xi.combat.magicHitRate.calculateResistRate(actor, target, 0, 0, params.rank, element, params.stat, params.effectId, params.macc)
    if resistRate < params.resist then
        return handleReturn(skill, setMessage, xi.msg.basic.SKILL_MISS, step.RESIST_RATE_CHECK)
    end

    -- Calculate duration.
    local totalDuration = math.floor(params.duration * resistRate)

    -- Apply effect.
    if target:addStatusEffect(params.effectId, params.power, params.tick, totalDuration, params.subType, params.subPower, params.tier) then
        return handleReturn(skill, setMessage, xi.msg.basic.SKILL_ENFEEB_IS, step.APPLICATION_SUCCESS)
    end

    return handleReturn(skill, setMessage, xi.msg.basic.SKILL_MISS, step.APPLICATION_FAIL)
end
