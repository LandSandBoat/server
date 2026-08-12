-----------------------------------
-- Beginnings (BLU AF1)
-- Restores the JST midnight wait before Waoud offers Omens.
-- The June 7, 2016 version update shortened the wait to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/50760-Jun.-7-2016-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_beginnings', xi.pre(xi.expansion.ROV))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/ahtUrhgan/BLU_AF1_Beginnings', function(quest)
        local whitegate = quest.sections[2][xi.zone.AHT_URHGAN_WHITEGATE]

        -- Copy of the base handler. Omens is offered at JST midnight.
        whitegate.onEventFinish[707] = function(player, csid, option, npc)
            if quest:complete(player) then
                xi.quest.setMustZone(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS)
                xi.quest.setVar(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS, 'Timer', JstMidnight()) -- Module change
            end
        end
    end)
end)
