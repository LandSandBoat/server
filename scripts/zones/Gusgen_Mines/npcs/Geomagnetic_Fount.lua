-----------------------------------
-- Area: Gusgen Mines (196)
--  NPC: Geomagnetic Fount
-- !pos -79.402 -27.000 439.369 196
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
