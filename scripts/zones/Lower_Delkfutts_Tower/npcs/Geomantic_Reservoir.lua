-----------------------------------
-- Area: Lower Delkfutt's Tower
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-CHR
-- !pos 340.285 -15.601 19.968 184
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_CHR)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_CHR)
end

return entity
