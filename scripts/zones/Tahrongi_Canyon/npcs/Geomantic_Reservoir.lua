-----------------------------------
-- Area: Tahrongi Canyon
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Voidance
-- !pos 78.056 15.998 117.224 117
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_VOIDANCE)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_VOIDANCE)
end

return entity
