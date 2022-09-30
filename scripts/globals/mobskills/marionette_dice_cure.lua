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
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local heal = math.min(math.floor(target:getMaxHP() / 8), target:getMaxHP() - target:getHP())

    if target:isPC() then
        mob:showText(mob, ID.text.DICE_LIKE_YOU)
    else
        mob:showText(mob, ID.text.DICE_LIKE_ME)
    end

    target:addHP(heal)
    target:wakeUp()

    return heal
end

return mobskill_object
