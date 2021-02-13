-----------------------------------
-- Area: Inner Horutoto Ruins (192)
--  NPC: Geomagnetic Fount
-- !pos 41.312 0.001 81.860
-----------------------------------
local ID = require("scripts/zones/Inner_Horutoto_Ruins/IDs")
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
