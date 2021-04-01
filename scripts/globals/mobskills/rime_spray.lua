-----------------------------------
--  Rime Spray
--
--  Description: Deals Ice damage to enemies within a fan-shaped area, inflicting them with Frost and All statuses down.
--  Type: Breath
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
--  Notes:
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
    local typeEffect = xi.effect.FROST

    MobStatusEffectMove(mob, target, xi.effect.FROST, 15, 3, 120)
    MobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 20, 3, 60)
    MobStatusEffectMove(mob, target, xi.effect.VIT_DOWN, 20, 3, 60)
    MobStatusEffectMove(mob, target, xi.effect.DEX_DOWN, 20, 3, 60)
    MobStatusEffectMove(mob, target, xi.effect.AGI_DOWN, 20, 3, 60)
    MobStatusEffectMove(mob, target, xi.effect.MND_DOWN, 20, 3, 60)
    MobStatusEffectMove(mob, target, xi.effect.INT_DOWN, 20, 3, 60)
    MobStatusEffectMove(mob, target, xi.effect.CHR_DOWN, 20, 3, 60)

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*5, xi.magic.ele.ICE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end

return mobskill_object
