-----------------------------------
--  Sweet Breath
--
--  Description: Deals water damage to enemies within a fan-shaped area originating from the caster.
--  Type: Magical Water (Element)
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
    local typeEffect = tpz.effect.SLEEP_I
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)

    local dmgmod = MobBreathMove(mob, target, 0.125, 3, tpz.magic.ele.WATER, 500)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.WATER)

    return dmg
end

return mobskill_object
