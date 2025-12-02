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

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local potency = 18

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(target, mob:getMaxHP() * potency)
end

return mobskillObject
