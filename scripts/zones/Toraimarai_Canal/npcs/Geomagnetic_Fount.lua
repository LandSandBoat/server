-----------------------------------
-- Area: Toraimarai Canal (169)
--  NPC: Geomagnetic Fount
-- !pos -60.004 21.503 194.314
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
