-----------------------------------
-- Marionette Dice Special
-- Description: Forces Fantoccini to use an ability or cast a spell
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
    local ability = ID.jobTable[target:getMainJob()].ability
    local spells = ID.jobTable[target:getMainJob()].spellListID

    -- Fantoccini can use abilities and spells
    -- TODO: Fix mobMod SPELL_LIST
    mob:timer(5000, function(mobArg)
        mob:messageText(mob, ID.text.GO_GO)

        if ability > 0 and spells > 0 then
            if math.random() > 0.5 then
                target:useMobAbility(ability)
            else
                target:setSpellList(spells)
            end
        elseif ability > 0 and spells == 0 then
            target:useMobAbility(ability)
        else
            target:setSpellList(spells)
        end

        mob:timer(1000, function(mobArg)
            target:setSpellList(0)
        end)
    end)

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskill_object
