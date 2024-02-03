-----------------------------------
--  Hecatomb Wave
--  Description: Deals wind damage to enemies within a fan-shaped area originating from the caster. Additional effect: Blindness.
--  Type: Magical (Wind)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 15, 0, 180)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1.5, xi.element.WIND, 400)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WIND)
    return dmg
end

return mobskillObject
