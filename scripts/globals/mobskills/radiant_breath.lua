-----------------------------------
--  Radiant Breath
--
--  Description: Deals light damage to enemies within a fan-shaped area of effect originating from the caster. Additional effect: Slow and Silence.
--  Type: Magical (Light)
--
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffectOne = xi.effect.SLOW
    local typeEffectTwo = xi.effect.SILENCE

    MobStatusEffectMove(mob, target, typeEffectOne, 1250, 0, 120)
    MobStatusEffectMove(mob, target, typeEffectTwo, 1, 0, 120)

    local dmgmod = MobBreathMove(mob, target, 0.2, 0.75, xi.magic.ele.LIGHT, 700)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.LIGHT)
    return dmg
end

return mobskill_object
