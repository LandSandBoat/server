-----------------------------------
-- Area: Eastern Altepa Desert
--  NPC: Lokpix
-- Starts Quest "Open Sesame"
-----------------------------------
local ID = require("scripts/zones/Eastern_Altepa_Desert/IDs")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.OPEN_SESAME) == QUEST_ACCEPTED) then
        if ((trade:hasItemQty(2796, 1) and trade:hasItemQty(582, 1) and trade:getItemCount() == 2) or (trade:hasItemQty(2796, 1) and trade:hasItemQty(3319, 1) and trade:getItemCount() == 2)
         or (trade:hasItemQty(2796, 1) and trade:hasItemQty(3300, 12) and trade:getItemCount() == 13)) then
            player:startEvent(22)
        end
    end
end

function onTrigger(player, npc)
    if (player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.OPEN_SESAME) == QUEST_AVAILABLE) then
        player:startEvent(20)
    elseif (player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.OPEN_SESAME) == QUEST_ACCEPTED) then
        player:startEvent(21)
    elseif (player:hasCompletedQuest(OUTLANDS, tpz.quest.id.outlands.OPEN_SESAME)) then
        player:startEvent(24)
    end
end

function onEventUpdate(player, csid, option)
    -- printf("OPTION: %u", option)
end

function onEventFinish(player, csid, option)
    -- printf("OPTION: %u", option)

    if (csid == 20 and option == 1) then
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.OPEN_SESAME)
    elseif (csid == 22) then
        player:tradeComplete()
        player:addKeyItem(tpz.ki.LOADSTONE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LOADSTONE)
        player:addFame(RABAO, 30)
        player:completeQuest(OUTLANDS, tpz.quest.id.outlands.OPEN_SESAME)
    end

end
