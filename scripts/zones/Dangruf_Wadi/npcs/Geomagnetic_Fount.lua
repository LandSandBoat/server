-----------------------------------
-- Area: Dangruf Wadi (191)
--  NPC: Geomagnetic Fount
-- !pos -480.364 2.458 -58.355
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
