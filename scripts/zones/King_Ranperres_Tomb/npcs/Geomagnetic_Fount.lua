-----------------------------------
-- Area: King Ranperres Tomb (190)
--  NPC: Geomagnetic Fount
-- !pos 223.311 -0.261 175.141
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
