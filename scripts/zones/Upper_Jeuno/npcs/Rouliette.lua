-----------------------------------
-- Area: Upper Jeuno
--  NPC: Rouliette
-- Starts and Finishes Quest: Candle-making
-- !pos -24 -2 11 244
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Upper_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.CANDLE_MAKING) == QUEST_ACCEPTED and trade:hasItemQty(531, 1) == true and trade:getItemCount() == 1) then
        player:startEvent(37)
    end
end

function onTrigger(player, npc)
    --Prerequisites for this quest : A_CANDLELIGHT_VIGIL ACCEPTED

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.CANDLE_MAKING) ~= QUEST_COMPLETED and
       player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.A_CANDLELIGHT_VIGIL) == QUEST_ACCEPTED) then
        player:startEvent(36)  -- Start Quest Candle-making
    else
        player:startEvent(30)  --Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 36 and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.CANDLE_MAKING) == QUEST_AVAILABLE) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.CANDLE_MAKING)
    elseif (csid == 37) then
        player:addTitle(tpz.title.BELIEVER_OF_ALTANA)
        player:addKeyItem(tpz.ki.HOLY_CANDLE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.HOLY_CANDLE)
        player:addFame(JEUNO, 30)
        player:tradeComplete(trade)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.CANDLE_MAKING)
    end
end
