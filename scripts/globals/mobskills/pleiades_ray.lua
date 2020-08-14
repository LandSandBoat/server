---------------------------------------------
--  Pleiades Ray
--  Description: Fires a magical ray at nearby targets. Additional effects: Paralysis + Blind + Poison + Plague + Bind + Silence + Slow
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Unknown
--  Notes: Only used by Gurfurlur the Menacing with health below 20%.
---------------------------------------------

require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobhp = mob:getHPP()

    if (mobhp <= 20) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 7, tpz.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
    local duration = 120

    MobStatusEffectMove(mob, target, tpz.effect.PARALYSIS, 40, 3, duration)
    MobStatusEffectMove(mob, target, tpz.effect.BLINDNESS, 40, 3, duration)
    MobStatusEffectMove(mob, target, tpz.effect.POISON, 10, 3, duration)
    MobStatusEffectMove(mob, target, tpz.effect.PLAGUE, 5, 3, duration)
    MobStatusEffectMove(mob, target, tpz.effect.BIND, 1, 0, duration)
    MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, duration)
    MobStatusEffectMove(mob, target, tpz.effect.SLOW, 1250, 0, duration)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    return dmg
end
