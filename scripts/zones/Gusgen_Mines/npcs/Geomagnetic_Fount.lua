-----------------------------------
-- Area: Gusgen Mines (196)
--  NPC: Geomagnetic Fount
-- !pos -79.402 -27.000 439.369
-----------------------------------
local ID = require("scripts/zones/Gusgen_Mines/IDs")
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
