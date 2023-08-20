-----------------------------------
-- Area: Western Adoulin
--  NPC: Waypoint
-----------------------------------
-- Platea Triumphus     : !pos 4.896 0 -4.789 256
-- Pioneer's Coalition  : !pos -110.5 3.85 -13.482 256
-- Mummer's Coalition   : !pos -20.982 -0.15 -79.891 256
-- Inventor's Coalition : !pos 91.451 -0.15 -49.013 256
-- Auction House        : !pos -68.099 4 -73.672 256
-- Rent-a-Room          : !pos 5.731 0 -123.043 256
-- Big Bridge           : !pos 174.783 3.85 -35.788 256
-- Airship Docks        : !pos 14.586 0 162.608 256
-- Adoulin Waterfront   : !pos 51.094 32 126.299 256
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
