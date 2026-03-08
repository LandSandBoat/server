-----------------------------------
-- Hecatomb Wave
-- Family: Demons
-- Description: Deals Wind damage to enemies within a fan-shaped area originating from the caster. Additional Effect: Blindness.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.0476
    params.damageCap        = 260
    params.bonusDamage      = 0
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.WIND
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.WIND
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 30, 0, math.random(60, 120))
    end

    return info.damage
end

return mobskillObject
