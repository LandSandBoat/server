-----------------------------------
-- Area: Windurst Waters
--  NPC: Maysoon
-- Starts and Finishes Quest: Hoist the Jelly, Roger
-- Involved in Quests: Cook's Pride
-- !pos -105 -2 69 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.HOIST_THE_JELLY_ROGER) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(4508, 1) == true and trade:getGil() == 0 and trade:getItemCount() == 1) then
            player:startEvent(10001) -- Finish quest "Hoist the Jelly, Roger"
        end
    end
end

function onTrigger(player, npc)
    CooksPride = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.COOK_S_PRIDE)
    HoistTheJelly = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.HOIST_THE_JELLY_ROGER)

    if (CooksPride == QUEST_ACCEPTED and HoistTheJelly == QUEST_AVAILABLE) then
        player:startEvent(10000) -- Start quest "Hoist the Jelly, Roger"
    else
        player:startEvent(266) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10000) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.HOIST_THE_JELLY_ROGER)
    elseif (csid == 10001) then
        player:completeQuest(WINDURST, tpz.quest.id.windurst.HOIST_THE_JELLY_ROGER)
        player:addKeyItem(tpz.ki.SUPER_SOUP_POT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SUPER_SOUP_POT)
        player:addFame(WINDURST, 30)
        player:tradeComplete()
    end
end
