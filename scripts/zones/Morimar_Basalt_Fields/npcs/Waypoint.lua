-----------------------------------
-- Area: Morimar Basalt Fields
--  NPC: Waypoint
-----------------------------------
-- Frontier Station : !pos 443.728 -16 -325.428 265
-- Bivouac #1       : !pos 368 -16 37.5 265
-- Bivouac #2       : !pos 112.8 -0.483 324.4 265
-- Bivouac #3       : !pos 175.5 -15.581 -318.2 265
-- Bivouac #4       : !pos -323 -32 2 265
-- Bivouac #5       : !pos -78.2 -47.284 303 265
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
