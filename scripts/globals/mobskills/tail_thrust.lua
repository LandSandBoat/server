---------------------------------------------
--  Tail Thrust
--  Family: Hpemde
--  Description: Strikes a single target with its tail.
--  Type: Physical
--  Utsusemi/Blink absorb: One shadow
--  Range: Unknown
--  Notes: Additional effect - paralyze
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.4
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, info.hitslanded)

    local typeEffect = tpz.effect.PARALYSIS
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 15, 0, 120)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
    return dmg
end
