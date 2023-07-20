-----------------------------------
-- Area: Marjami Ravine
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Haste
-- !pos 189.015 -40.000 241.025 266
-----------------------------------
require("scripts/globals/geomantic_reservoir")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_HASTE)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_HASTE)
end

return entity
