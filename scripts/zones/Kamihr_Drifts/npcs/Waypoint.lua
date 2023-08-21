-----------------------------------
-- Area: Kamihr Drifts
--  NPC: Waypoint
-----------------------------------
-- Frontier Station : !pos 439.403 63 -272.554 267
-- Bivouac #1       : !pos -42.574 43 -71.319 267
-- Bivouac #2       : !pos 8.24 43 -283.017 267
-- Bivouac #3       : !pos 9.24 23 162.803 267
-- Bivouac #4       : !pos -228.942 3.567 364.512 267
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
