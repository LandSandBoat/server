-----------------------------------
-- Contagion Transfer
-- Family: Cockatrice (Deadly Moa)
-- Description: Transfers all positive and negative effects from the target to the user.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numEffectsTransferred = 0
    local availableEffects = {}

    -- Get all effects from target and filter by flags
    local allEffects = target:getStatusEffects()
    for _, effect in pairs(allEffects) do
        local effectId = effect:getEffectType()
        local flags = effect:getEffectFlags()

        -- Check if effect has DISPELABLE, WALTZABLE, or ERASABLE flags
        if bit.band(flags, bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.WALTZABLE, xi.effectFlag.ERASABLE)) ~= 0 then
            table.insert(availableEffects, effectId)
        end
    end

    -- Add petrification if present
    if target:hasStatusEffect(xi.effect.PETRIFICATION) then
        table.insert(availableEffects, xi.effect.PETRIFICATION)
    end

    -- Transfer all available effects
    for i = 1, #availableEffects do
        local effectId = availableEffects[i]
        local effect = target:getStatusEffect(effectId)
        if effect and target:delStatusEffect(effectId) then
            mob:addStatusEffect(
                effectId,
                effect:getPower(),
                effect:getTick(),
                math.ceil(effect:getTimeRemaining() / 1000), -- Gets the effects remaining time and converts it from milliseconds to seconds
                effect:getSubType(),
                effect:getSubPower(),
                effect:getTier()
            )
            numEffectsTransferred = numEffectsTransferred + 1
        end
    end

    if numEffectsTransferred > 0 then
        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return numEffectsTransferred
end

return mobskillObject
