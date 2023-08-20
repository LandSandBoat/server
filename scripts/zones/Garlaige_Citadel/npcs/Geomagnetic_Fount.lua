-----------------------------------
-- Area: Garlaige Citadel (200)
--  NPC: Geomagnetic Fount
-- !pos -156.374 0.000 237.283
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
