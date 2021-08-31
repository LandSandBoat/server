-----------------------------------
--  Bad Breath
--
--  Description: Deals earth damage that inflicts multiple status ailments on enemies within a fan-shaped area originating from the caster.
--  Type: Magical (Earth)
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

    MobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, 60)
    MobStatusEffectMove(mob, target, xi.effect.POISON, mob:getMainLvl() / 10, 3, 60)
    MobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)
    MobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 15, 0, 60)
    MobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30)
    MobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 15, 0, 60)
    MobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 60)

    local dmgmod = MobBreathMove(mob, target, 0.15, 3, xi.magic.ele.EARTH, 500)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.EARTH)

    return dmg
end

return mobskill_object
