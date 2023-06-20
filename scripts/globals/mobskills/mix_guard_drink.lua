-----------------------------------
-- Mix: Guard Drink - Applies Protect (+220 Defense) and Shell to all party members for 5 minutes.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    return 0
end

return mobskillObject
