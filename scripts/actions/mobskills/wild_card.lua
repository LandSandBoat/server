-----------------------------------
-- Wild Card (Mob Skill)
-- Description : Has a random effect on all targets within range.
-- TODO : Research what Wild Card does for mobs, this is just a blank effect application for now so the ability can be used.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.USES)

    return 0
end

return mobskillObject
