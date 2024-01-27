-----------------------------------
-- Area: Marjami Ravine
--  NPC: Waypoint
-----------------------------------
-- Frontier Station : !pos 358 -60 165 266
-- Bivouac #1       : !pos 323 -20 -79 266
-- Bivouac #2       : !pos 6.808 0 78.437 266
-- Bivouac #3       : !pos -318.708 -20 -127.275 266
-- Bivouac #4       : !pos -326.022 -40.023 201.096 266
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
