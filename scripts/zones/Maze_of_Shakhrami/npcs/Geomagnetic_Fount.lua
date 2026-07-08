-----------------------------------
-- Area: Maze of Shakhrami (198)
--  NPC: Geomagnetic Fount
-- !pos 289.404 -6.741 -149.664
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
