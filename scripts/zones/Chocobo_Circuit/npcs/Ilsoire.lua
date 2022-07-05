-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Ilsoire
-- Grandstand Entrance
-- pos -329.9156 -5.0000 -412.8696
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(262)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
