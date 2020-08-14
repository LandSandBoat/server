---------------------------------------------
--  Stone Throw
--
--  Description: Damages a single target. Additional effect: Paralysis
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
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

    local numhits = 1
    local accmod = 0.8
    local dmgmod = 2.5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.BLUNT, info.hitslanded)

    local typeEffect = tpz.effect.PARALYSIS

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 20, 0, 60)

    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.BLUNT)
    return dmg
end
