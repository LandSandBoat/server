-----------------------------------
-- Area: Foret de Hennetiel
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Gravity
-- !pos 232.687 -0.500 152.658 262
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_GRAVITY)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_GRAVITY)
end

return entity
