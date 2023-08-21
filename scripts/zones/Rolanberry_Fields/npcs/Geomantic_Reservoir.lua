-----------------------------------
-- Area: Rolanberry Fields
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-MND
-- !pos 243.900 -31.194 -255.254 110
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_MND)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_MND)
end

return entity
