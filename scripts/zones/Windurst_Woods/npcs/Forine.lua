-----------------------------------
-- Area: Windurst Woods
--  NPC: Forine
-- Involved In Mission: Journey Abroad
-- !pos -52.677 -0.501 -26.299 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(445)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
