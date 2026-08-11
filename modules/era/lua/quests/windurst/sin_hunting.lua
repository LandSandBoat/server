-----------------------------------
-- Sin Hunting
-- Restores the full moon requirement to examine the ??? in Jugner Forest.
-- The June 17, 2014 version update changed the event to occur regardless
-- of Vana'diel time and phase of the moon.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/42614-Jun-17-2014-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_sin_hunting', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/windurst/RNG_AF1_Sin_Hunting', function(quest)
        local jugnerForest  = quest.sections[2][xi.zone.JUGNER_FOREST]
        local baseOnTrigger = jugnerForest['qm2'].onTrigger

        jugnerForest['qm2'].onTrigger = function(player, npc)
            if getVanadielMoonCycle() == xi.moonCycle.FULL_MOON then
                return baseOnTrigger(player, npc)
            end
        end
    end)
end)
