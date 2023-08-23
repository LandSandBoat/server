-----------------------------------
-- Area: Upper Delkfutt's Tower
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Vex
-- !pos -358.799 -175.425 82.985 158
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_VEX)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_VEX)
end

return entity
