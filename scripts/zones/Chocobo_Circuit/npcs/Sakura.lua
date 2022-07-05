-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Sakura
-- Commentator
-- pos 
-- event 479 488 497 
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(479)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
