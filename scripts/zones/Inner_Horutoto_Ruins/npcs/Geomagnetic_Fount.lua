-----------------------------------
-- Area: Inner Horutoto Ruins (192)
--  NPC: Geomagnetic Fount
-- !pos 41.312 0.001 81.860
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
