-----------------------------------
-- Area: Ceizak Battlegrounds
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Frailty
-- !pos -450.391 0.001 -0.491 261
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_FRAILTY)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_FRAILTY)
end

return entity
