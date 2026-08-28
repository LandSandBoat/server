-----------------------------------
-- Vanishing Act
-- Restores the JST midnight wait before A Taste of Honey opens.
-- The September 9, 2014 version update shortened the wait to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/44090-Sep-9-2014-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_vanishing_act', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/ahtUrhgan/Vanishing_Act', function(quest)
        local whitegate = quest.sections[2][xi.zone.AHT_URHGAN_WHITEGATE]

        -- Copy of the base handler. A Taste of Honey opens at JST midnight.
        whitegate.onEventFinish[45] = function(player, csid, option, npc)
            if quest:complete(player) then
                player:needToZone(true)
                player:delKeyItem(xi.ki.RAINBOW_BERRY)
                xi.quest.setVar(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.A_TASTE_OF_HONEY, 'Stage', JstMidnight()) -- Module change
            end
        end
    end)
end)
