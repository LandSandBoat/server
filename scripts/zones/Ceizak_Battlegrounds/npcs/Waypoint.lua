-----------------------------------
-- Area: Ceizak Battlegrounds
--  NPC: Waypoint
-----------------------------------
-- Frontier Station : !pos 365 0.448 190 261
-- Bivouac #1       : !pos -6.879 0 -117.511 261
-- Bivouac #2       : !pos -42 0 155 261
-- Bivouac #3       : !pos -442 0 -247 261
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
