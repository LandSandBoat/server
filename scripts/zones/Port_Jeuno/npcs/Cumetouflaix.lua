-----------------------------------
-- Area: Port Jeuno
--  NPC: Cumetouflaix
-- Standard NPC
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    player:messageSpecial(ID.text.CUMETOUFLAIX_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
