-----------------------------------
-- Area: Crawler's Nest
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-STR
-- !pos -170.623 -1.376 347.089 197
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_STR)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_STR)
end

return entity
