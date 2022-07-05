-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Rhind Mhikkrol
-- Spectator [Roam? not stated]
-- pos 
-- event 365 366 367 
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(365)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity