-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Piana
-- Chocobobet Center Clerk
-- pos -372.0645 -4.0000 -453.0401
-- event 308 312 316
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(308)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
