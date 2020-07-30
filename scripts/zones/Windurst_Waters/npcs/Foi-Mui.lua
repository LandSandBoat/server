-----------------------------------
-- Area: Windurst Waters
--  NPC: Foi-Mui
-- Involved in Quest: Making the Grade
-- !pos 126 -6 162 238
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_THE_GRADE) == QUEST_ACCEPTED) then
        player:startEvent(449) -- During Making the GRADE
    else
        player:startEvent(430) -- Standard conversation
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
