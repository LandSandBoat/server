-----------------------------------
-- Area: Windurst Waters
--  NPC: Maysoon
-- Starts and Finishes Quest: Hoist the Jelly, Roger
-- Involved in Quests: Cook's Pride
-- !pos -105 -2 69 238
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.HOIST_THE_JELLY_ROGER) == QUEST_ACCEPTED then
        if
            trade:hasItemQty(xi.item.SERVING_OF_ROYAL_JELLY, 1) and
            trade:getGil() == 0 and
            trade:getItemCount() == 1
        then
            player:startEvent(10001) -- Finish quest "Hoist the Jelly, Roger"
        end
    end
end

entity.onTrigger = function(player, npc)
    local cooksPride = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.COOK_S_PRIDE)
    local hoistTheJelly = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.HOIST_THE_JELLY_ROGER)

    if cooksPride == QUEST_ACCEPTED and hoistTheJelly == QUEST_AVAILABLE then
        player:startEvent(10000) -- Start quest "Hoist the Jelly, Roger"
    else
        player:startEvent(266) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10000 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.HOIST_THE_JELLY_ROGER)
    elseif csid == 10001 then
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.HOIST_THE_JELLY_ROGER)
        player:addKeyItem(xi.ki.SUPER_SOUP_POT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SUPER_SOUP_POT)
        player:addFame(xi.quest.fame_area.WINDURST, 30)
        player:tradeComplete()
    end
end

return entity
