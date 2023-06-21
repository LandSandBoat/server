-----------------------------------
--  Radiant Breath
--  Description: Deals light damage to enemies within a fan-shaped area of effect originating from the caster. Additional effect: Slow and Silence.
--  Type: Magical (Light)
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffectOne = xi.effect.SLOW
    local typeEffectTwo = xi.effect.SILENCE

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectOne, 1250, 0, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectTwo, 1, 0, 120)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.2, 0.75, xi.magic.ele.LIGHT, 700)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.LIGHT)
    return dmg
end

return mobskillObject
