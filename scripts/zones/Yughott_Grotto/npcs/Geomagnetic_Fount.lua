-----------------------------------
-- Area: Yughott Grotto (142)
--  NPC: Geomagnetic Fount
-- !pos 199.133 -11.515 110.606
-----------------------------------
local ID = require("scripts/zones/Yughott_Grotto/IDs")
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
