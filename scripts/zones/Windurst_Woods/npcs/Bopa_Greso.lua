-----------------------------------
-- Area: Windurst Woods
--  NPC: Bopa Greso
-- Type: Standard NPC
-- !pos 59.773 -6.249 216.766 241
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MIHGO_S_AMIGO) == QUEST_ACCEPTED then
        player:startEvent(84)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
