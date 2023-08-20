-----------------------------------
-- Area: Maze of Shakhrami (198)
--  NPC: Geomagnetic Fount
-- !pos 289.404 -6.741 -149.664
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
