-----------------------------------
-- Area: Outer Horutoto Ruins (194)
--  NPC: Geomagnetic Fount
-- !pos 289.792 0.001 708.071
-----------------------------------
local ID = require("scripts/zones/Outer_Horutoto_Ruins/IDs")
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
