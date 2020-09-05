-----------------------------------
-- Area: Port Bastok
--  NPC: Corann
-- Start & Finishes Quest: The Quadav's Curse
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------

function onTrade(player, npc, trade)

TheQuadav = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_QUADAV_S_CURSE)

    if (TheQuadav == QUEST_ACCEPTED) then
        count = trade:getItemCount()
        QuadavBack = trade:hasItemQty(596, 1)

        if (count == 1 and QuadavBack == true) then
            player:startEvent(81)
        end
    end

end

function onTrigger(player, npc)

TheQuadav = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_QUADAV_S_CURSE)
OutOfOneShell = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.OUT_OF_ONE_S_SHELL)

    if (OutOfOneShell == QUEST_COMPLETED) then
        player:startEvent(88)
    elseif (TheQuadav == QUEST_COMPLETED) then
        player:startEvent(87)
    elseif (TheQuadav == QUEST_AVAILABLE) then
        player:startEvent(80)
    else
        player:startEvent(38)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 80) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.THE_QUADAV_S_CURSE)
    elseif (csid == 81) then
        player:tradeComplete()
        player:completeQuest(BASTOK, tpz.quest.id.bastok.THE_QUADAV_S_CURSE)
        player:addFame(BASTOK, 120)
        player:addItem(12832)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 12832)
    end

end
