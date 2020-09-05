---------------------------------------------
--  Impact Stream
--
--  Description: 50% Defense Down, Stun
--  Type: Magical
--  Wipe Shadows
--  Range: 10.0' AoE
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
    local typeEffect1 = tpz.effect.STUN
    local typeEffect2 = tpz.effect.DEFENSE_DOWN

    MobStatusEffectMove(mob, target, typeEffect1, 1, 0, 4)
    MobStatusEffectMove(mob, target, typeEffect2, 50, 0, 60)

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*2.5, tpz.magic.ele.LIGHT, dmgmod, 0, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.EARTH, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.EARTH)
    return dmg
end
