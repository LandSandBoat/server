-----------------------------------
-- Area: Marjami Ravine
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Haste
-- !pos 189.015 -40.000 241.025 266
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_HASTE)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_HASTE)
end

return entity
