-----------------------------------
-- Area: The Eldieme Necropolis (195)
--  NPC: Geomagnetic Fount
-- !pos 51.805 -2.495 6.825
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
