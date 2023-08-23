-----------------------------------
-- Area: Bostaunieux Oubliette
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Languor
-- !pos -13.337 0.009 -333.022 167
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_LANGUOR)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_LANGUOR)
end

return entity
