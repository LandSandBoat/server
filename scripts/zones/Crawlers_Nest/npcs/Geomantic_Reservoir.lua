-----------------------------------
-- Area: Crawler's Nest
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-STR
-- !pos -170.623 -1.376 347.089 197
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_STR)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_STR)
end

return entity
