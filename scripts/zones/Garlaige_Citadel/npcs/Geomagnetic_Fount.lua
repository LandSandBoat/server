-----------------------------------
-- Area: Garlaige Citadel (200)
--  NPC: Geomagnetic Fount
-- !pos -156.374 0.000 237.283
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
