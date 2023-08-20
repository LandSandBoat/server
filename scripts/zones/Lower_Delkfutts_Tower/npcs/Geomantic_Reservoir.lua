-----------------------------------
-- Area: Lower Delkfutt's Tower
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-CHR
-- !pos 340.285 -15.601 19.968 184
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_CHR)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_CHR)
end

return entity
