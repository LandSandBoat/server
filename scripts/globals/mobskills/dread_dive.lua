---------------------------------------------
-- Dread Dive
--
-- Description: Dives into a single target. Additional effect: Knockback + Stun
-- Type: Physical
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
-- Notes: Used instead of Gliding Spike by certain notorious monsters.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.4
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)

    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.STUN, 1, 0, 4)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    return dmg
end
