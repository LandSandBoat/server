-----------------------------------
-- Area: King Ranperres Tomb (190)
--  NPC: Geomagnetic Fount
-- !pos 223.311 -0.261 175.141
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
