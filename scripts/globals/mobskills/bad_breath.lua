---------------------------------------------
--  Bad Breath
--
--  Description: Deals earth damage that inflicts multiple status ailments on enemies within a fan-shaped area originating from the caster.
--  Type: Magical (Earth)
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    MobStatusEffectMove(mob, target, tpz.effect.SLOW, 1250, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.POISON, mob:getMainLvl() / 10, 3, 60)
    MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.PARALYSIS, 15, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.BIND, 1, 0, 30)
    MobStatusEffectMove(mob, target, tpz.effect.BLINDNESS, 15, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.WEIGHT, 50, 0, 60)

    local dmgmod = MobBreathMove(mob, target, 0.15, 3, tpz.magic.ele.EARTH, 500)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.EARTH, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.EARTH)

    return dmg
end

return mobskill_object
