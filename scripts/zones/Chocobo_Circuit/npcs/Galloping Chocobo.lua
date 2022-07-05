-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Galloping Chocobo
-- Chocobo Breeder [Roams] 
-- pos -105.4596 -13.2781 -118.5870
-- event 383 384 385
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(383)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
