-----------------------------------
-- Decollation
-- Description: Deals physical damage to all targets in a cone in front of the user. Chance of critical varies with TP.
-- Type: Physical
-- Utsusemi/Blink absorb: 3 shadows
-- Range: Frontal Cone
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod  = 1
    local ftp     = 2
    -- TODO: Need crit scaling captures
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1, 1)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    return dmg
end

return mobskillObject
