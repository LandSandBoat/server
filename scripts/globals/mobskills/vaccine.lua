-----------------------------------
-- Vaccine - Removes Plague.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    target:delStatusEffect(xi.effect.PLAGUE)
    return 0
end

return mobskillObject
