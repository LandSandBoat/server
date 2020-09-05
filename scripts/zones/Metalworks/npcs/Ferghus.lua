-----------------------------------
-- Area: Metalworks
--  NPC: Ferghus
-- Starts Quest: Too Many Chefs (1, 86)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local TooManyChefs = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.TOO_MANY_CHEFS)
    local pFame = player:getFameLevel(BASTOK)

    if (TooManyChefs == QUEST_AVAILABLE and pFame >= 5) then
        player:startEvent(946) -- Start Quest "Too Many Chefs"
    elseif (player:getCharVar("TOO_MANY_CHEFS") == 4) then -- after trade to Leonhardt
        player:startEvent(947)
    else
        player:startEvent(420) -- Standard
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 946 and option == 0) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.TOO_MANY_CHEFS)
        player:setCharVar("TOO_MANY_CHEFS", 1)
    elseif (csid == 947) then
        player:setCharVar("TOO_MANY_CHEFS", 5)
    end
end
