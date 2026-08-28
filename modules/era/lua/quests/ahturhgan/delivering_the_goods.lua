-----------------------------------
-- Delivering the Goods
-- Restores the JST midnight wait before Vanishing Act opens.
-- The September 9, 2014 version update shortened the wait to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/44090-Sep-9-2014-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_delivering_the_goods', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/ahtUrhgan/Delivering_the_Goods', function(quest)
        local whitegate = quest.sections[3][xi.zone.AHT_URHGAN_WHITEGATE]

        -- Copy of the base handler. Vanishing Act opens at JST midnight.
        whitegate.onEventFinish[41] = function(player, csid, option, npc)
            if quest:complete(player) then
                xi.quest.setVar(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.VANISHING_ACT, 'Stage', JstMidnight()) -- Module change

                -- Player must zone before being able to flag the next quest
                player:needToZone(true)
            end
        end
    end)
end)
