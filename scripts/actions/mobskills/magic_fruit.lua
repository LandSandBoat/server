-----------------------------------
-- Magic Fruit
-- Description: Restores HP for the target party member.
-- Type: Magical (Light)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(target, 188 * mob:getMaxHP() / 1024)
end

return mobskillObject
