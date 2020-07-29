-----------------------------------
-- Area: Port Bastok
--  NPC: Dehlner
-- Standard Info NPC
-- Invlolved in Quest: A Foreman's Best Friend
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

ForemansBestFriend = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.A_FOREMAN_S_BEST_FRIEND)

    if (ForemansBestFriend == QUEST_ACCEPTED) then
        player:startEvent(111)
    else
        player:startEvent(46)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
