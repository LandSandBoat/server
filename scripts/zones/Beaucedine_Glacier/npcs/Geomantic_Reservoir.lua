-----------------------------------
-- Area: Beaucedine Glacier
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-INT
-- !pos 8.527 -59.729 -104.909 111
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_INT)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_INT)
end

return entity
