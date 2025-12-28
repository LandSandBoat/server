-----------------------------------
-- Call Beast
-- Call my pet.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return xi.pet.onMobSkillCheck(target, mob, skill)
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.pet.spawnPet(mob, nil, skill)

    return 0
end

return mobskillObject
