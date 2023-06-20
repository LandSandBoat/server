-----------------------------------
-- Mix: Para-b-gone - Removes Paralysis.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    target:delStatusEffect(xi.effect.PARALYSIS)
    return 0
end

return mobskillObject
