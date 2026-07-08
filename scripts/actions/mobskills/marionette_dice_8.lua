-----------------------------------
--  Marionette Dice (Restore TP)
--  Description: Rolls the dice and restores up to 3000 TP to the pet. Orders them to use a weaponskill.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local tpAmount = 3000 - target:getTP()

    target:addTP(tpAmount)

    skill:setMsg(xi.msg.basic.TP_INCREASE)

    return tpAmount
end

return mobskillObject
