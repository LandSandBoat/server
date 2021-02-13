-----------------------------------
-- Area: Maze of Shakhrami (198)
--  NPC: Geomagnetic Fount
-- !pos 289.404 -6.741 -149.664
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
require("scripts/globals/geomagnetic_fount")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.geomagneticFount.checkFount(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
