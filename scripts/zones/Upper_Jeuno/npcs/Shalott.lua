-----------------------------------
-- Area: Upper Jeuno
--  NPC: Shalott
-- Optional Involvement in Quest: Save My Son
--------------------------------

require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.SAVE_MY_SON) == QUEST_ACCEPTED) then
        player:startEvent(101)
    else
        player:startEvent(104)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
