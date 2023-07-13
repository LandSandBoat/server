-----------------------------------
-- Area: Bostaunieux Oubliette
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Languor
-- !pos -13.337 0.009 -333.022 167
-----------------------------------
require("scripts/globals/geomantic_reservoir")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_LANGUOR)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_LANGUOR)
end

return entity
