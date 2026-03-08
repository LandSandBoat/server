-----------------------------------
-- Ascetics Fury
-- Description: Hand To Hand Weapon Skill
-- Type: Physical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local numhits = 1
    local accmod  = 1
    local ftp     = 2.6
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1.1, 1.3, 1.5)
    local dmg     = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)

    return dmg
end

return mobskillObject
