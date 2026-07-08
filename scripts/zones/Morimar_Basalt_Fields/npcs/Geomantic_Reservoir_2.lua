-----------------------------------
-- Area: Morimar Basalt Fields
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Fade
-- !pos 337.643 -16.745 305.544 265
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_FADE)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_FADE)
end

return entity
