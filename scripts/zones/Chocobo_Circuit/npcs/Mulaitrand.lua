-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Mulaitrand
-- Chocobo Circuit Grandstand Attendant
-- pos -388.2694 -5.0000 -467.1629
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(264)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
