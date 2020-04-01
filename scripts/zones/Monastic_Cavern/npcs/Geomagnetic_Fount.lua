-----------------------------------
-- Area: Monastic Cavern (150)
--  NPC: Geomagnetic Fount
-- !pos 0.000 0.000 -312.000
-----------------------------------
local ID = require("scripts/zones/Monastic_Cavern/IDs")
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
