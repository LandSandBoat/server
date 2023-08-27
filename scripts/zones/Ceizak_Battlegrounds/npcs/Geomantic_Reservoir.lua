-----------------------------------
-- Area: Ceizak Battlegrounds
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Frailty
-- !pos -450.391 0.001 -0.491 261
-----------------------------------
require("scripts/globals/geomantic_reservoir")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_FRAILTY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_FRAILTY)
end

return entity
