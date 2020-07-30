---------------------------------------------------
--  Corrosive Ooze
--  Family: Slugs
--  Description: Deals water damage to an enemy. Additional Effect: Attack Down and Defense Down.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Radial
--  Notes:
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffectOne = tpz.effect.ATTACK_DOWN
    local typeEffectTwo = tpz.effect.DEFENSE_DOWN
    local duration = 120

    MobStatusEffectMove(mob, target, typeEffectOne, 15, 0, duration)
    MobStatusEffectMove(mob, target, typeEffectTwo, 15, 0, duration)

    local dmgmod = 1
    local baseDamage = mob:getWeaponDmg()*4.2
    local info = MobMagicalMove(mob, target, skill, baseDamage, tpz.magic.ele.WATER, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WATER)
    return dmg
end
