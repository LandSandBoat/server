-----------------------------------
-- Dancing Edge
-- Delivers a fivefold attack
-- Type: Physical
-- Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local ftp    = 1.1875
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, 2, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    return dmg
end

return mobskillObject
