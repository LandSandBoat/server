-----------------------------------
-- Marionette Dice (7)
-- Description: Forces target to use special ability
-- Type: Magical
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
        mobArg:showText(mobArg, ID.text.NOT_HOW)
        target:resetRecasts()
    end)

    skill:setMsg(xi.msg.basic.ABILITIES_RECHARGED)
    return 0
end

return mobskillObject
