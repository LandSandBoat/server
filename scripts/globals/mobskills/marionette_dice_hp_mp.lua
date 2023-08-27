-----------------------------------
-- Marionette Dice (4 & 10)
-- Description: Restores HP and MP to player
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
        target:addHP(amount)
        target:addMP(amount)
        target:wakeUp()
    end)

    skill:setMsg(xi.msg.basic.RECOVERS_HP_AND_MP)
    return amount
end

return mobskillObject
