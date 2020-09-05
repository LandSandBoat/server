-----------------------------------
-- Area: Lower Jeuno
--  NPC: Garnev
-- Starts and Finishes Quest: Deal with Tenshodo
-- !pos 30 4 -36 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.DEAL_WITH_TENSHODO) == QUEST_ACCEPTED and trade:hasItemQty(554, 1) == true and trade:getItemCount() == 1) then
        player:startEvent(166) -- Ending quest
    end
end

function onTrigger(player, npc)
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.A_CLOCK_MOST_DELICATE) == QUEST_ACCEPTED and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.DEAL_WITH_TENSHODO) == QUEST_AVAILABLE) then
        if (player:getFameLevel(NORG) >= 2) then
            player:startEvent(167) -- Start quest
        else
            player:startEvent(168) -- dialog without correct tenshodo/norg fame
        end
    else
        player:startEvent(207) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 167) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.DEAL_WITH_TENSHODO)
    elseif (csid == 166) then
        player:addTitle(tpz.title.TRADER_OF_RENOWN)
        player:addKeyItem(tpz.ki.CLOCK_TOWER_OIL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CLOCK_TOWER_OIL)
        player:addFame(JEUNO, 30)
        player:tradeComplete(trade)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.DEAL_WITH_TENSHODO)
    end
end
