-----------------------------------
-- Area: Gusgen Mines (196)
--  NPC: Geomagnetic Fount
-- !pos -79.402 -27.000 439.369
-----------------------------------
local ID = require("scripts/zones/Gusgen_Mines/IDs")
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
