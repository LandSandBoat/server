-----------------------------------
-- Area: Ranguemont Pass (166)
--  NPC: Geomagnetic Fount
-- !pos 166.183 25.221 -191.464
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
