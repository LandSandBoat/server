-----------------------------------
-- Marionette TP Boost
-- Description: Gives a random amount of TP to player
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
    target:setTP(target:getTP() + math.random(50, 1000))

    return target:getTP()
end

return mobskill_object
