-----------------------------------
-- Area: Korroloka Tunnel (173)
--  NPC: Geomagnetic Fount
-- !pos -112.997 1.500 -103.864
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
