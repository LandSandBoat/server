-----------------------------------
-- Area: Windurst Walls
--  NPC: Polikal-Ramikal
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local turmoil = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)

    if turmoil == QUEST_ACCEPTED then
        player:startEvent(391)
    else
        player:startEvent(320)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
