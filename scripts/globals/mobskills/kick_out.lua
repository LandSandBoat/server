---------------------------------------------
-- Kick Out
--
-- Description: Deals heavy damage and inflicts blind to any target behind user.
-- Type: Physical
-- Utsusemi/Blink absorb: 2-3 shadows
-- Range: Unknown cone, backwards
-- Notes:  Only used when the Behemoth is attacking with its tail.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (target:isBehind(mob, 48) == false) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = 3
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.H2H, info.hitslanded)

    local typeEffect = tpz.effect.BLINDNESS

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 20, 0, 120)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.H2H)
    return dmg
end
