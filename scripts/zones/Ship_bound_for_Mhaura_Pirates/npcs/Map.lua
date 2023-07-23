-----------------------------------
-- Area: Ship bound for Mhaura Pirates
--  NPC: Map
-- !pos 0.28 -14.0 -1.411 221
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(1024)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
