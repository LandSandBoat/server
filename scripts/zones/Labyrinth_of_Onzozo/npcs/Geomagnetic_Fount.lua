-----------------------------------
-- Area: Labyrinth of Onzozo (213)
--  NPC: Geomagnetic Fount
-- !pos 136.955 14.892 185.412
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
