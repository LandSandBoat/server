---------------------------------------------
--  Rime Spray
--
--  Description: Deals Ice damage to enemies within a fan-shaped area, inflicting them with Frost and All statuses down.
--  Type: Breath
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
--  Notes:
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.FROST

    MobStatusEffectMove(mob, target, tpz.effect.FROST, 15, 3, 120)
    MobStatusEffectMove(mob, target, tpz.effect.STR_DOWN, 20, 3, 60)
    MobStatusEffectMove(mob, target, tpz.effect.VIT_DOWN, 20, 3, 60)
    MobStatusEffectMove(mob, target, tpz.effect.DEX_DOWN, 20, 3, 60)
    MobStatusEffectMove(mob, target, tpz.effect.AGI_DOWN, 20, 3, 60)
    MobStatusEffectMove(mob, target, tpz.effect.MND_DOWN, 20, 3, 60)
    MobStatusEffectMove(mob, target, tpz.effect.INT_DOWN, 20, 3, 60)
    MobStatusEffectMove(mob, target, tpz.effect.CHR_DOWN, 20, 3, 60)

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*5, tpz.magic.ele.ICE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ICE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ICE)
    return dmg
end
