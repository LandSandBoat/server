-----------------------------------
-- Area: Yahse Hunting Grounds
--  NPC: Waypoint
-----------------------------------
-- Frontier Station : !pos 321 0 -199.8 260
-- Bivouac #1       : !pos 86.5 0 1.5 260
-- Bivouac #2       : !pos -286.5 0 43.5 260
-- Bivouac #3       : !pos -162.4 0 -272.8 260
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.waypoint.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.waypoint.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.waypoint.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.waypoint.onEventFinish(player, csid, option, npc)
end

return entity
