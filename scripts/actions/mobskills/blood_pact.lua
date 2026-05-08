-----------------------------------
-- Blood Pact
-- Family : Humanoid Job Ability
-- Description : Orders avatar to use an ability
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    action:setCategory(xi.action.category.JOBABILITY_FINISH)

    skill:setMsg(xi.msg.basic.USES)

    return 0
end

return mobskillObject
