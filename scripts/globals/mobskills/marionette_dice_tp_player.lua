-----------------------------------
-- Marionette TP Boost
-- Description: Gives a random amount of TP to player
-- Notes: Used by Moblin Fantoccini in ENM: "Pulling the strings"
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:timer(5000, function(mobArg)
        target:setTP(target:getTP() + math.random(50, 1000))
    end)

    return target:getTP()
end

return mobskillObject
