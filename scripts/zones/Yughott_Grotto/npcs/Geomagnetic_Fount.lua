-----------------------------------
-- Area: Yughott Grotto (142)
--  NPC: Geomagnetic Fount
-- !pos 199.133 -11.515 110.606
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
