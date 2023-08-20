-----------------------------------
-- Area: Dangruf Wadi (191)
--  NPC: Geomagnetic Fount
-- !pos -480.364 2.458 -58.355
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
