-----------------------------------
--  Marionette Dice (Restore MP)
--  Description: Rolls the dice and restores 200 to 300 MP to the target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local mpAmount = math.randomInt(200, 300)
    local missingMP = target:getMaxMP() - target:getMP()

    if missingMP < mpAmount then
        mpAmount = missingMP
    end

    target:addMP(mpAmount)

    skill:setMsg(xi.msg.basic.RECOVERS_MP_SECONDARY)

    return mpAmount
end

return mobskillObject
