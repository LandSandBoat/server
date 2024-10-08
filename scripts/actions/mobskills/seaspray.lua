-----------------------------------
-- Seaspray
-- Description: Deals Water damage to targets in a fan-shaped area of effect. Additional effect: Slow
-- Type: Breath
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 30, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 3500, 0, duration)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, skill, 0.125, 1, xi.element.WATER, 500)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)

    return dmg
end

return mobskillObject
