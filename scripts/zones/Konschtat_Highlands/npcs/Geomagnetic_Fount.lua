-----------------------------------
-- Area: Konschat Highlands (108)
--  NPC: Geomagnetic Fount
-- !pos 596.279 24.398 494.432
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

return entity
