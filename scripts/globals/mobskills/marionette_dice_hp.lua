-----------------------------------
-- Marionette Dice (4 & 10)
-- Description: Cures player
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
        target:wakeUp()
    end)

    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_HP)
    return amount
end

return mobskillObject
