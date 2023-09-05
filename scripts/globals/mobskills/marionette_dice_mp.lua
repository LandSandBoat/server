-----------------------------------
-- Marionette Dice (4 & 10)
-- Description: Gives 150 MP to target
-- Type: Magical
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local amount = 150

    mob:timer(5000, function(mobArg)
        target:addMP(amount)
    end)

    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_MP)
    return amount
end

return mobskillObject
