-----------------------------------
-- Marionette Dice (7)
-- Description: Forces target to use special ability
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
    if not target:isPC() then
        if ID.jobTable[target:getLocalVar("job")].ability == 0 then
            return 1
        end
    end
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    if target:isPC() then
        mob:showText(mob, ID.text.NOT_HOW)
        target:resetRecasts()
        skill:setMsg(xi.msg.basic.ABILITIES_RECHARGED)
    else
        mob:showText(mob, ID.text.GO_GO)
        target:useMobAbility(ID.jobTable[target:getLocalVar("job")].ability)
    end

    return 1
end

return mobskill_object
