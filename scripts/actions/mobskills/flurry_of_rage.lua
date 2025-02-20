-----------------------------------
-- Flurry of Rage
-- Deals multiple hits to a single target.
-- Only used by Eldritch Edge, Malefic Fencer, and Nightmare Weapon.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.ACC_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    return dmg
end

return mobskillObject
