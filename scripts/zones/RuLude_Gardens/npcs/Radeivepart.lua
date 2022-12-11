-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Radeivepart
-- Starts and Finishes Quest: Northward
-- Involved in Quests: Save the Clock Tower
-- !pos 5 9 -39 243
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.NORTHWARD) == QUEST_ACCEPTED then
        if
            trade:hasItemQty(16522, 1) and
            trade:getGil() == 0 and
            trade:getItemCount() == 1
        then
            player:startEvent(61) -- Finish quest "Northward"
        end
    end
end

entity.onTrigger = function(player, npc)
    local northward = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.NORTHWARD)

    if
        player:getFameLevel(xi.quest.fame_area.JEUNO) >= 4 and
        northward == QUEST_AVAILABLE
    then
        player:startEvent(159, 1, 0, 0, 0, 0, 0, 8)
    elseif northward == QUEST_ACCEPTED then
        player:startEvent(159, 2, 0, 0, 0, 0, 0, 8)
    elseif northward == QUEST_COMPLETED then
        player:startEvent(159, 3, 0, 0, 0, 0, 0, 8)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 159 and option == 1 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.NORTHWARD)
    elseif csid == 61 then
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.NORTHWARD)
        player:addTitle(xi.title.ENVOY_TO_THE_NORTH)
        if not player:hasKeyItem(xi.ki.MAP_OF_CASTLE_ZVAHL) then
            player:addKeyItem(xi.ki.MAP_OF_CASTLE_ZVAHL)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MAP_OF_CASTLE_ZVAHL)
        end

        player:addFame(xi.quest.fame_area.JEUNO, 30)
        player:tradeComplete()
    end
end

return entity
