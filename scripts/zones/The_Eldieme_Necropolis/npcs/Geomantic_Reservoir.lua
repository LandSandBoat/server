-----------------------------------
-- Area: The Eldieme Necropolis
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Slip
-- !pos 10.804 -0.031 -18.927 195
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_SLIP)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_SLIP)
end

return entity
