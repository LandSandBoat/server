-----------------------------------
-- Area: Qufim Island
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Attunement
-- !pos 185.136 20.528 -208.424 126
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_ATTUNEMENT)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_ATTUNEMENT)
end

return entity
