-----------------------------------
-- Area: Port Bastok
--  NPC: Qiji
-- Starts & Ends Quest: Forever to Hold
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (trade:hasItemQty(12497, 1) and trade:getItemCount() == 1) then -- Trade Brass Hairpin
        if (player:getCharVar("ForevertoHold_Event") == 1) then
            player:startEvent(124)
            player:setCharVar("ForevertoHold_Event", 2)
        end
    end

end

function onTrigger(player, npc)

    local ForevertoHold = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.FOREVER_TO_HOLD)

    if (player:getFameLevel(BASTOK) >= 2 and ForevertoHold == QUEST_AVAILABLE) then
        player:startEvent(123)
    elseif (ForevertoHold == QUEST_ACCEPTED and player:getCharVar("ForevertoHold_Event") == 3) then
        player:startEvent(126)
    else
        player:startEvent(33)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 123) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.FOREVER_TO_HOLD)
        player:setCharVar("ForevertoHold_Event", 1)
    elseif (csid == 126) then
        player:addTitle(tpz.title.QIJIS_FRIEND)
        player:addGil(GIL_RATE*300)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*300)
        player:addFame(BASTOK, 80)
        player:completeQuest(BASTOK, tpz.quest.id.bastok.FOREVER_TO_HOLD)
    end

end
