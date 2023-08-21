-----------------------------------
-- Area: Labyrinth of Onzozo (213)
--  NPC: Geomagnetic Fount
-- !pos 136.955 14.892 185.412
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
