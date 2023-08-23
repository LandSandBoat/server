-----------------------------------
-- Area: Morimar Basalt Fields
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Malaise
-- !pos -166.764 -1.377 -49.194 265
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_MALAISE)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_MALAISE)
end

return entity
