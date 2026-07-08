-----------------------------------
-- Area: East Ronfaure
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Poison
-- !pos 379.572 -39.057 57.502 101
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_POISON)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_POISON)
end

return entity
