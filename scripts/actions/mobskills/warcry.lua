-----------------------------------
-- Warcry
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    action:setCategory(xi.action.category.JOBABILITY_FINISH)

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.WARCRY, 8, 0, 30))

    return xi.effect.WARCRY
end

return mobskillObject
