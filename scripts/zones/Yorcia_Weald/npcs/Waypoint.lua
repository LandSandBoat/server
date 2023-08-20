-----------------------------------
-- Area: Yorcia Weald
--  NPC: Waypoint
-----------------------------------
-- Frontier Station : !pos 353.3 0.2 153.3 263
-- Bivouac #1       : !pos -40.5 0.367 296.367 263
-- Bivouac #2       : !pos 122.132 0.146 -287.731 263
-- Bivouac #3       : !pos -274.776 0.357 85.376 263
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
