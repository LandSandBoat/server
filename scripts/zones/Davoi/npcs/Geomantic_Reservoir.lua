-----------------------------------
-- Area: Davoi
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Fend
-- !pos 173.098 3.643 -386.962 149
-----------------------------------
require("scripts/globals/geomantic_reservoir")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_FEND)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_FEND)
end

return entity
