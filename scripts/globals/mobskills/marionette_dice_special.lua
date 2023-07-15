-----------------------------------
-- Marionette Dice Special
-- Description: Forces Fantoccini to use an ability or cast a spell
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
    local ability = ID.jobTable[target:getMainJob()].ability
    local spells = ID.jobTable[target:getMainJob()].spellListID

    -- Fantoccini can use abilities and spells
    -- TODO: Fix mobMod SPELL_LIST
    mob:timer(5000, function(mobArg)
        mobArg:messageText(mobArg, ID.text.GO_GO)

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

        mobArg:timer(1000, function(mobArg1)
            target:setSpellList(0)
        end)
    end)

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
