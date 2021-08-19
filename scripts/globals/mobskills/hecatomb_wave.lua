-----------------------------------
--  Hecatomb Wave
--
--  Description: Deals wind damage to enemies within a fan-shaped area originating from the caster. Additional effect: Blindness.
--  Type: Magical (Wind)
--
--
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BLINDNESS
    MobStatusEffectMove(mob, target, typeEffect, 15, 0, 180)

    local dmgmod = MobBreathMove(mob, target, 0.1, 1.5, xi.magic.ele.WIND, 400)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WIND)
    return dmg
end

return mobskill_object
