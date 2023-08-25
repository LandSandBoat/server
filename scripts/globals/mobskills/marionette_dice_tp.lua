-----------------------------------
-- Marionette Dice (6 & 8)
-- Description: Forces Fantoccini to use TP
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
    -- Force Fantoccini to use an ability
    local skillList = ID.jobTable[target:getLocalVar("job")].skillList
    target:setTP(3000)

    mob:timer(5000, function(mobArg)
        mobArg:showText(mobArg, ID.text.HA_HA)
        target:setMobMod(xi.mobMod.SKILL_LIST, skillList)

        mobArg:timer(1000, function(mobArg1)
            target:setMobMod(xi.mobMod.SKILL_LIST, 0)
        end)
    end)

    skill:setMsg(xi.msg.basic.TP_INCREASE)
    return target:getTP()
end

return mobskillObject
