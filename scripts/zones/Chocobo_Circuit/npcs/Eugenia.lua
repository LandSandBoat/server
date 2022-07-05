-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Eugenia
-- Spectator [Roams]
-- pos 
-- event 359 360 361 
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(359)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
