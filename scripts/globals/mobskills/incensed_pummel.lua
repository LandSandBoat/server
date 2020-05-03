---------------------------------------------------
-- Incensed Pummel
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.0
    -- Random stat down
    local typeEffect = 136 + math.random(0,6) -- 136 is tpz.effect.STR_DOWN add 0 to 6 for all 7 of the possible attribute reductions

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_IGNORE_SHADOWS)

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 20, 3, 120)

    return dmg
end
