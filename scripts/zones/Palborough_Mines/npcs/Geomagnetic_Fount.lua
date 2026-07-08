-----------------------------------
-- Area: Palborough Mines (143)
--  NPC: Geomagnetic Fount
-- !pos 294.324 -17.043 99.687
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
