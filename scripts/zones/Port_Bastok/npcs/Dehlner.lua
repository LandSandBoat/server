-----------------------------------
-- Area: Port Bastok
--  NPC: Dehlner
-- Standard Info NPC
-- Invlolved in Quest: A Foreman's Best Friend
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

ForemansBestFriend = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_FOREMAN_S_BEST_FRIEND)

    if (ForemansBestFriend == QUEST_ACCEPTED) then
        player:startEvent(111)
    else
        player:startEvent(46)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
