-----------------------------------
-- Ability: Steal
-- Family : Humanoid Job Ability
-- Description : Removes a random piece of the players equipment.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    action:setCategory(xi.action.category.WEAPONSKILL_FINISH)

    xi.mobskills.unequipRandomSlots(target, 1)

    skill:setMsg(xi.msg.basic.USES)

    return 0
end

return mobskillObject
