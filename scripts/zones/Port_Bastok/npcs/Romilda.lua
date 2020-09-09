-----------------------------------
-- Area: Port Bastok
--  NPC: Romilda
-- Involved in Quest: Forever to Hold
-- Starts & Ends Quest: Till Death Do Us Part
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (trade:hasItemQty(12497, 1) and trade:getItemCount() == 1) then -- Trade Brass Hairpin
        if (player:getCharVar("ForevertoHold_Event") == 2) then
            player:tradeComplete()
            player:startEvent(125)
            player:setCharVar("ForevertoHold_Event", 3)
        end
    elseif (trade:hasItemQty(12721, 1) and trade:getItemCount() == 1) then -- Trade Cotton Gloves
        if (player:getCharVar("ForevertoHold_Event") == 3) then
            player:tradeComplete()
            player:startEvent(129)
            player:setCharVar("ForevertoHold_Event", 4)
        end
    end

end

function onTrigger(player, npc)

    local pFame = player:getFameLevel(BASTOK)
    local ForevertoHold = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.FOREVER_TO_HOLD)
    local TilldeathdousPart = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.TILL_DEATH_DO_US_PART)

    if (pFame >= 3 and ForevertoHold == QUEST_COMPLETED and TilldeathdousPart == QUEST_AVAILABLE and player:getCharVar("ForevertoHold_Event") == 3) then
        player:startEvent(128)
    else
        player:startEvent(34)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 128) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.TILL_DEATH_DO_US_PART)
    elseif (csid == 129) then
        player:addTitle(tpz.title.QIJIS_RIVAL)
        player:addGil(GIL_RATE*2000)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*2000)
        player:addFame(BASTOK, 160)
        player:completeQuest(BASTOK, tpz.quest.id.bastok.TILL_DEATH_DO_US_PART)
    end

end
