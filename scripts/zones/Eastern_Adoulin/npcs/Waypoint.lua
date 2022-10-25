-----------------------------------
-- Area: Eastern Adoulin
--  NPC: Waypoint
-----------------------------------
-- Peacekeeper's Coalition : !pos -101.274 -0.15 -10.726 257
-- Scout's Coalition       : !pos -77.944 -0.15 -63.926 257
-- Statue of the Goddess   : !pos -46.838 -0.075 -12.767 257
-- Yahse Wharf             : !pos -57.773 -0.15 85.237 257
-- Rent-a-Room             : !pos -61.865 -0.15 -120.81 257
-- Auction House           : !pos -42.065 -0.15 -89.979 257
-- Sverdhried Hillock      : !pos 11.681 -22.15 29.976 257
-- Coronal Esplanade       : !pos 27.124 -40.15 -60.844 257
-- Castle Gates            : !pos 95.994 -40.15 -74.541 257
-----------------------------------
require('scripts/globals/waypoint')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.waypoint.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.waypoint.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.waypoint.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.waypoint.onEventFinish(player, csid, option, npc)
end

return entity
