-----------------------------------
-- Mix: Dark Potion - Deals 666 damage to a single enemy.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    return 666
end

return mobskillObject
