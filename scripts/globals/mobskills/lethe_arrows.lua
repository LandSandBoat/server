---------------------------------------------
-- Lethe Arrows
--
-- Description: Deals a ranged attack to target. Additional effect: Knockback, Bind, and Amnesia
-- Type: Ranged
-- Utsusemi/Blink absorb: Ignores Utsusemi
-- Range: Unknown
-- Notes:
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
    local accmod = 3
    local dmgmod = 4
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.PIERCING, MOBPARAM_IGNORE_SHADOWS)

    MobStatusEffectMove(mob, target, tpz.effect.BIND, 1, 0, 120)
    MobStatusEffectMove(mob, target, tpz.effect.AMNESIA, 1, 0, 120)

    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.PIERCING)
    return dmg
end
