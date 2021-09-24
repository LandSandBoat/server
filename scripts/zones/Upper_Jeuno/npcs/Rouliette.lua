-----------------------------------
-- Area: Upper Jeuno
--  NPC: Rouliette
-- Starts and Finishes Quest: Candle-making
-- !pos -24 -2 11 244
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Upper_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CANDLE_MAKING) == QUEST_ACCEPTED and trade:hasItemQty(531, 1) == true and trade:getItemCount() == 1) then
        player:startEvent(37)
    end
end

entity.onTrigger = function(player, npc)
    --Prerequisites for this quest : A_CANDLELIGHT_VIGIL ACCEPTED

    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CANDLE_MAKING) ~= QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_CANDLELIGHT_VIGIL) == QUEST_ACCEPTED
    then
        player:startEvent(36)  -- Start Quest Candle-making
    else
        player:startEvent(30)  --Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 36 and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CANDLE_MAKING) == QUEST_AVAILABLE) then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CANDLE_MAKING)
    elseif (csid == 37) then
        player:addTitle(xi.title.BELIEVER_OF_ALTANA)
        player:addKeyItem(xi.ki.HOLY_CANDLE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.HOLY_CANDLE)
        player:addFame(JEUNO, 30)
        player:tradeComplete()
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CANDLE_MAKING)
    end
end

return entity
