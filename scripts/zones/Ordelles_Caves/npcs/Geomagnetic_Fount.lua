-----------------------------------
-- Area: Ordelles Caves (193)
--  NPC: Geomagnetic Fount
-- !pos -182.376 28.415 -139.829
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
