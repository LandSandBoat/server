-----------------------------------
-- Area: Port Jeuno
--  NPC: Karl
-- Starts and Finishes Quest: Child's Play
-- !pos -60 0.1 -8 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.CHILD_S_PLAY) == QUEST_ACCEPTED and trade:hasItemQty(776, 1) == true and trade:getItemCount() == 1) then
        player:startEvent(1) -- Finish quest
    end
end

function onTrigger(player, npc)
    local ChildsPlay = player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.CHILD_S_PLAY)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")

    if (player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatJeuno, 16)) then
        player:startEvent(316)
    elseif (player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_WONDER_MAGIC_SET) == QUEST_ACCEPTED and ChildsPlay == QUEST_AVAILABLE) then
        player:startEvent(0) -- Start quest
    elseif (ChildsPlay == QUEST_ACCEPTED) then
        player:startEvent(61) -- mid quest CS
    else
        player:startEvent(58) -- Standard dialog
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 0) then
        player:addQuest(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.CHILD_S_PLAY)
    elseif (csid == 1) then
        player:addTitle(tpz.title.TRADER_OF_MYSTERIES)
        player:addKeyItem(tpz.ki.WONDER_MAGIC_SET)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.WONDER_MAGIC_SET)
        player:addFame(JEUNO, 30)
        player:tradeComplete(trade)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.CHILD_S_PLAY)
    elseif (csid == 316) then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 16, true))
    end
end
