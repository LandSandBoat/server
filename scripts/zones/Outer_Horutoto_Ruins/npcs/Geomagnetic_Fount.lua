-----------------------------------
-- Area: Outer Horutoto Ruins (194)
--  NPC: Geomagnetic Fount
-- !pos 289.792 0.001 708.071
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
