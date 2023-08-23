-----------------------------------
-- Area: Xarcabard
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Torpor
-- !pos -141.138 -34.642 127.197 112
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_TORPOR)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_TORPOR)
end

return entity
