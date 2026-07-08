-----------------------------------
-- Area: Rolanberry Fields
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-MND
-- !pos 243.900 -31.194 -255.254 110
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_MND)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_MND)
end

return entity
