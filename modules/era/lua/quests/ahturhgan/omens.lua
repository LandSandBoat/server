-----------------------------------
-- Omens (BLU AF2)
-- Restores the JST midnight wait before Waoud offers Transformations.
-- The June 7, 2016 version update shortened the wait to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/50760-Jun.-7-2016-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_omens', xi.pre(xi.expansion.ROV))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/ahtUrhgan/BLU_AF2_Omens', function(quest)
        local whitegate = quest.sections[2][xi.zone.AHT_URHGAN_WHITEGATE]

        -- Copy of the base handler. Transformations is offered at JST midnight.
        whitegate.onEventFinish[716] = function(player, csid, option, npc)
            if quest:complete(player) then
                player:delKeyItem(xi.ki.SEALED_IMMORTAL_ENVELOPE)

                xi.quest.setMustZone(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.TRANSFORMATIONS)
                xi.quest.setVar(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.TRANSFORMATIONS, 'Timer', JstMidnight()) -- Module change
            end
        end
    end)
end)
