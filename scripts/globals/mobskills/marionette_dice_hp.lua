-----------------------------------
-- Marionette Dice (4 & 10)
-- Description: Cures player
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
    local amount = 150
    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_HP)
    target:addHP(amount)
    target:wakeUp()
    return amount
end

return mobskill_object
