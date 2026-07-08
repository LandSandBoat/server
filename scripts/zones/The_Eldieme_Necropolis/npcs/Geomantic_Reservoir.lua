-----------------------------------
-- Area: The Eldieme Necropolis
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Slip
-- !pos 10.804 -0.031 -18.927 195
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_SLIP)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_SLIP)
end

return entity
