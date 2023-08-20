-----------------------------------
-- Area: La Theine Plateau
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Regen
-- !pos -5.052 54.625 -405.673 102
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_REFRESH)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_REFRESH)
end

return entity
