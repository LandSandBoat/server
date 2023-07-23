-----------------------------------
-- Area: Port Jeuno
--  NPC: Zona Shodhun
-- Starts and Finishes Quest: Pretty Little Things
-- !pos -175 -5 -4 246
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10023, 0, 246, 10)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
