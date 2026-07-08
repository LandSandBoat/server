-----------------------------------
-- Area: Davoi
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Fend
-- !pos 173.098 3.643 -386.962 149
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_FEND)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_FEND)
end

return entity
