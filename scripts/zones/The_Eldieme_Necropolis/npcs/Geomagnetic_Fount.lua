-----------------------------------
-- Area: The Eldieme Necropolis (195)
--  NPC: Geomagnetic Fount
-- !pos 51.805 -2.495 6.825
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
