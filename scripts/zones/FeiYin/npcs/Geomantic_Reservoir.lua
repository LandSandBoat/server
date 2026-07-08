-----------------------------------
-- Area: Fei'Yin
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Paralysis
-- !pos 4.239 -0.009 255.206 204
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_PARALYSIS)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_PARALYSIS)
end

return entity
