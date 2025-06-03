-----------------------------------
-- Area: Gustav Tunnel (212)
--  NPC: Geomagnetic Fount
-- !pos -71.932 -8.897 -209.707
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
