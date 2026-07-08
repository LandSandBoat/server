-----------------------------------
-- Area: Konschtat Highlands
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Precision
-- !pos -246.883 40.168 301.159 108
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_PRECISION)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_PRECISION)
end

return entity
