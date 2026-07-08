-----------------------------------
-- Area: Gusgen Mines (196)
--  NPC: Geomagnetic Fount
-- !pos -79.402 -27.000 439.369 196
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
