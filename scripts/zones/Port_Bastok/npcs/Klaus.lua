-----------------------------------
-- Area: Port Bastok
--  NPC: Klaus
-- Type: Standard NPC
-- !pos -89.355 -3.611 -15.256 236
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.DEPARTING_PASSENGER_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
