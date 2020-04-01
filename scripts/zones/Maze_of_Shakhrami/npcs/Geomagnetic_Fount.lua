-----------------------------------
-- Area: Maze of Shakhrami (198)
--  NPC: Geomagnetic Fount
-- !pos 289.404 -6.741 -149.664
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
require("scripts/globals/geomagnetic_fount")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.geomagneticFount.checkFount(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
