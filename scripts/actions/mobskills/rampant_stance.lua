-----------------------------------
-- Rampant Stance
-- Physical area of effect damage that inflicts stun.
-- Utsusemi/Blink absorb: 1-4 shadows, wipes Third Eye
-- Range: 7.0 (add 0.1-4 depending on terrain elevation)
-- Notes: Takes roughly three seconds to charge the TP move up, enough time for anyone within range to easily back out and run back in directly after the animation begins.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- parameters for AE
    local typeEffect = xi.effect.STUN
    local power      = 1
    local duration   = xi.mobskills.calculateDuration(3, 5)

    -- perform physical attack
    local numhits    = 3
    local accmod     = 2
    local ftp        = 1
    local info       = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0)
    local dmg        = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    -- if skill hit, apply dmg and AE
    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.BLUNT)

        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 0, duration)
    end

    return dmg
end

return mobskillObject
