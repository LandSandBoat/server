-----------------------------------
-- Area: Yughott Grotto (142)
--  NPC: Geomagnetic Fount
-- !pos 199.133 -11.515 110.606
-----------------------------------
local ID = require("scripts/zones/Yughott_Grotto/IDs")
require("scripts/globals/geomagnetic_fount")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
