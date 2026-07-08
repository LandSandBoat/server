-----------------------------------
-- Vaccine - Removes Plague.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    target:delStatusEffect(xi.effect.PLAGUE)
    return 0
end

return mobskillObject
