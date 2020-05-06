-----------------------------------
-- Area: Garlaige Citadel (200)
--  NPC: Geomagnetic Fount
-- !pos -156.374 0.000 237.283
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
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
