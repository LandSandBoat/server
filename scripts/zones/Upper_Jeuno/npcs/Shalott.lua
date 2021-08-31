-----------------------------------
-- Area: Upper Jeuno
--  NPC: Shalott
-- Optional Involvement in Quest: Save My Son
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON) == QUEST_ACCEPTED) then
        player:startEvent(101)
    else
        player:startEvent(104)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
