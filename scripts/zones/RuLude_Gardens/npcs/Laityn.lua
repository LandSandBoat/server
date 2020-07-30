-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Laityn
-- Involved In Quest: Recollections
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.RECOLLECTIONS) == QUEST_ACCEPTED and player:getCharVar("recollectionsQuest") == 0) then
        player:startEvent(10003) -- Option CS for "Recollections"
    else
        player:startEvent(10006)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 10003) then
        player:setCharVar("recollectionsQuest", 1)
    end

end
