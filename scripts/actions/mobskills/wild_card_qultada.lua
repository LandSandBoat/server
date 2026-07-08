-----------------------------------
-- Wild Card (Qultada) (Mob Skill)
-- Description : Has a random effect on all targets within range.
-- It is not clear if Qultada's Wild Card does anything at all.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.msg.basic.USES)
end

return mobskillObject
