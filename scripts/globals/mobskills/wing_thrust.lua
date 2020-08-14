---------------------------------------------
--  Wing Thrust
--  Family: Aern
--  Type: Physical
--  Can be dispelled: N/A
--  Utsusemi/Blink absorb: 4 Shadows
--  Range: Single Target 7.0'
---------------------------------------------
require("scripts/globals/monstertpmoves")

require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLOW

    local numhits = 4
    local accmod = 1
    local dmgmod = 1
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.NONE, info.hitslanded)

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1250, 0, 60)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.NONE)
    return dmg
end
