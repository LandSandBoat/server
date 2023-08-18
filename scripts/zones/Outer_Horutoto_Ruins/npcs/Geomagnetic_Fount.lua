-----------------------------------
-- Area: Outer Horutoto Ruins (194)
--  NPC: Geomagnetic Fount
-- !pos 289.792 0.001 708.071
-----------------------------------
local ID = zones[xi.zone.OUTER_HORUTOTO_RUINS]
require("scripts/globals/geomagnetic_fount")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomagneticFount.checkFount(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
