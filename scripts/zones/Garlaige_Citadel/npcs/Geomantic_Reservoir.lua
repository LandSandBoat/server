-----------------------------------
-- Area: Garlaige Citadel
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-VIT
-- !pos -83.898 5.568 139.600 200
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_VIT)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_VIT)
end

return entity
