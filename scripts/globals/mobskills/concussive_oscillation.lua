---------------------------------------------
-- Concussive Oscillation
-- Smacks around all nearby targets. Additional effect: Knockback + Weight
-- Utsusemi/Blink absorb: 2-3 shadows
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.3
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, MOBPARAM_3_SHADOW)
    local typeEffect = tpz.effect.WEIGHT

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 50, 0, 300)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    return dmg
end
