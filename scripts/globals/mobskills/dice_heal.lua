-----------------------------------
-- Goblin Dice
--
-- Description: Benediction for party members within area of effect.
-- Type: Magical (Wind)
--
--
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local heal = target:getMaxHP() - target:getHP()

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    target:addHP(heal)
    target:wakeUp()

    return heal
end

return mobskillObject
