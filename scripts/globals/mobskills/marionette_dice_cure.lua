-----------------------------------
-- Marionette Dice (4 & 10)
-- Description: Cure to target
-- Type: Magical
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local heal = math.min(math.floor(target:getMaxHP() / 8), target:getMaxHP() - target:getHP())

    target:addHP(heal)
    target:wakeUp()

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return heal
end

return mobskill_object
