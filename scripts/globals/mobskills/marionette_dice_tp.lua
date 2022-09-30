-----------------------------------
-- Marionette Dice (6 & 8)
-- Description: Gives 1000 TP to target
-- Type: Magical
-- Notes: Used by Moblin Fantoccini in ENM: "Pulling the strings"
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    target:addTP(math.random(1000,3000))

    if target:isPC() then
        mob:showText(mob, ID.text.DICE_LIKE_YOU)
    else
        mob:showText(mob, ID.text.HA_HA)
    end

    skill:setMsg(xi.msg.basic.TP_INCREASE)

    return target:getTP()
end

return mobskill_object
