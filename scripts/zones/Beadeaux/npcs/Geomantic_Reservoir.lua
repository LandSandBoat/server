-----------------------------------
-- Area: Beadeaux
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Slow
-- !pos 162.194 -3.250 38.661 147
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_SLOW)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_SLOW)
end

return entity
