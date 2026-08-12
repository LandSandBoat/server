-----------------------------------
-- Transformations (BLU AF3)
-- Restores the JST midnight wait before Waoud offers The Beast Within.
-- The June 7, 2016 version update shortened the wait to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/50760-Jun.-7-2016-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_transformations', xi.pre(xi.expansion.ROV))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/ahtUrhgan/BLU_AF3_Transformations', function(quest)
        local alzadaal = quest.sections[2][xi.zone.ALZADAAL_UNDERSEA_RUINS]

        -- Copy of the base handler. The Beast Within is offered at JST midnight.
        alzadaal.onEventFinish[5] = function(player, csid, option, npc)
            if quest:complete(player) then
                xi.quest.setVar(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_BEAST_WITHIN, 'Timer', JstMidnight()) -- Module change
            end
        end
    end)
end)
