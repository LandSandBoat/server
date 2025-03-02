-----------------------------------
-- Mix: Dark Potion - Deals 666 damage to a single enemy.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local darkpot = 666
    local dmg     = xi.mobskills.mobFinalAdjustments(darkpot, mob, skill, target, xi.attackType.NONE, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.NONE, xi.damageType.NONE)

    return dmg
end

return mobskillObject
