-----------------------------------
-- Name: Sensilla Blades
-- Description: Conal with knockback.
-- Type: Physical (Slashing)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1.1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
