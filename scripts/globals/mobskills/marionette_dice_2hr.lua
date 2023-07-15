-----------------------------------
-- Marionette Dice 2hr
-- Description: Forces Fantoccini to use its respective 2hr
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
    local ability = ID.jobTable[target:getMainJob()].twoHour

    if ability > 0 then
        mob:timer(5000, function(mobArg)
            target:useMobAbility(ability)
            mobArg:messageText(mobArg, ID.text.NOT_YOUR_LUCKY_DAY)
        end)
    end
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
