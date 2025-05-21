-----------------------------------
-- Area: La Theine Plateau
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Regen
-- !pos -5.052 54.625 -405.673 102
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_REFRESH)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_REFRESH)
end

return entity
