-----------------------------------
--  Silence Gas
--
--  Description: Emits a noxious cloud in a fan-shaped area of effect, dealing Wind damage to all targets. Additional effect: silence
--  Type: Magical Wind (Element)
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
    local typeEffect = xi.effect.SILENCE

    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 60)


    local dmgmod = MobBreathMove(mob, target, 0.25, 2, xi.magic.ele.WIND, 800)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WIND)
    return dmg
end

return mobskill_object
