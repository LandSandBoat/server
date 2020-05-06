-----------------------------------
-- Area: Labyrinth of Onzozo (213)
--  NPC: Geomagnetic Fount
-- !pos 136.955 14.892 185.412
-----------------------------------
local ID = require("scripts/zones/Labyrinth_of_Onzozo/IDs")
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
