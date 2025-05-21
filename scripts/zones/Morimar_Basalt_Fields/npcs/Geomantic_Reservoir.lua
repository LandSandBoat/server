-----------------------------------
-- Area: Morimar Basalt Fields
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Malaise
-- !pos -166.764 -1.377 -49.194 265
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_MALAISE)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_MALAISE)
end

return entity
