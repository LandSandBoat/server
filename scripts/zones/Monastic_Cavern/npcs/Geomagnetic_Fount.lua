-----------------------------------
-- Area: Monastic Cavern (150)
--  NPC: Geomagnetic Fount
-- !pos 0.000 0.000 -312.000
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
