-----------------------------------
-- Area: Outer Horutoto Ruins (194)
--  NPC: Geomagnetic Fount
-- !pos 289.792 0.001 708.071
-----------------------------------
local ID = require("scripts/zones/Outer_Horutoto_Ruins/IDs")
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
