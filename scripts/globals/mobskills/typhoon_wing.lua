---------------------------------------------
--  Hurricane Wing
--
--  Description: Deals hurricane-force wind damage to enemies within a very wide area of effect. Additional effect: Blind
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 30' radial.
--  Notes: Used only by Dragua, Fafnir, Nidhogg, Cynoprosopi, Wyrm, and Odzmanouk. The blinding effect does not last long
--                but is very harsh. The attack is wide enough to generally hit an entire alliance.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if (target:isBehind(mob, 48) == true) then
        return 1
    elseif (mob:AnimationSub() ~= 0) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BLINDNESS

    MobStatusEffectMove(mob, target, typeEffect, 60, 0, 30)

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*5, tpz.magic.ele.WIND, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    return dmg
end
