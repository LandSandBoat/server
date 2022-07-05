-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Goccilo
-- Commentator
-- pos 
-- event 100 115 210 427 458 469 479 488 497
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(100)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity