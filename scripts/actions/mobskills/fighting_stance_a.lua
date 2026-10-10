-----------------------------------
-- Fighting Stance α
-- Description: Changes a Monipulator's form. The form change itself is in src/map/monstrosity.cpp.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.msg.basic.USES)

    return 0
end

return mobskillObject
