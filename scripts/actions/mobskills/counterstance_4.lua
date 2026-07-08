-----------------------------------
-- Ability: Counterstance
-- Family : Humanoid Job Ability
-- Description : Increases chance to counter but lowers defense.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    action:setCategory(xi.action.category.JOBABILITY_FINISH)

    xi.mobskills.mobBuffMove(mob, xi.effect.COUNTERSTANCE, 45, 0, 300)

    skill:setMsg(xi.msg.basic.NONE)

    return xi.effect.COUNTERSTANCE
end

return mobskillObject
