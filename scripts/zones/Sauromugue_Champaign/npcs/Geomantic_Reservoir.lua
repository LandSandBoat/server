-----------------------------------
-- Area: Sauromugue Champaign
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Fury
-- !pos 384.047 45.466 384.224 120
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_FURY)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_FURY)
end

return entity
