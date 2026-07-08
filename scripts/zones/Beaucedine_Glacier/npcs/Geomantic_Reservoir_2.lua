-----------------------------------
-- Area: Beaucedine Glacier
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Acumen
-- !pos 275.620 -0.137 247.116 111
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_ACUMEN)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_ACUMEN)
end

return entity
