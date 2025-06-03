-----------------------------------
-- Area: Crawlers Nest (197)
--  NPC: Geomagnetic Fount
-- !pos -137.728 -32.314 33.123
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
