-----------------------------------
-- Area: Castle Oztroja
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-AGI
-- !pos -210.032 -16.000 95.255 151
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_AGI)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_AGI)
end

return entity
