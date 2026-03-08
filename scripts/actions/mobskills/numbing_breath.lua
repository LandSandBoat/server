-----------------------------------
-- Numbing Breath
-- Family: Scorpions
-- Description: Deals Ice damage to enemies within a fan-shaped area originating from the caster. Additional Effect: Paralysis.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.0625
    params.damageCap        = 500 -- TODO: Capture damage cap.
    params.bonusDamage      = 0
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.ICE
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.ICE
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)
    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 20, 0, math.random(120, 180))
    end

    return info.damage
end

return mobskillObject
