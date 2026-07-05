-----------------------------------
--  Marionette Dice (Restores HP)
--  Description: Rolls the dice and restores 400 to 600 HP to the target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local healAmount = math.randomInt(400, 600)
    local missingHP = target:getMaxHP() - target:getHP()

    if missingHP < healAmount then
        healAmount = missingHP
    end

    target:addHP(healAmount)

    skill:setMsg(xi.msg.basic.SELF_HEAL_SECONDARY)

    return healAmount
end

return mobskillObject
