-----------------------------------
-- Area: Behemoth's Dominion
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-DEX
-- !pos -232.162 -20.199 4.927 127
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_DEX)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_DEX)
end

return entity
