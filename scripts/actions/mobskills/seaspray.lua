-----------------------------------
-- Seaspray
-- Family: Orobon
-- Description: Deals Water breath damage to targets in a fan-shaped area of effect. Additional Effect: Slow
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.125
    params.damageCap        = 500
    params.bonusDamage      = 0
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.WATER
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.WATER
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local duration = math.random(30, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 3500, 0, duration)
    end

    return info.damage
end

return mobskillObject
