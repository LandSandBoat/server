-----------------------------------
--  Marionette Dice (Full Heal)
--  Description: Fully Heals HP and MP to the target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    target:setHP(target:getMaxHP())
    target:setMP(target:getMaxMP())

    skill:setMsg(xi.msg.basic.RECOVERS_HP_AND_MP)

    return 0
end

return mobskillObject
