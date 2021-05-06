-----------------------------------
-- Area: Windurst Walls
--  NPC: Orudoba-Sondeba
-- Type: Standard NPC
-- !pos 70.086 -3.503 -69.939 239
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE) == QUEST_ACCEPTED then
        player:startEvent(51)
    else
        player:startEvent(43)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
