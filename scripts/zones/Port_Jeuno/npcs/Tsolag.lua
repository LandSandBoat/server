-----------------------------------
-- Area: Port Jeuno
--  NPC: Tsolag
-- Type: NPC
-- !pos -13 8 53 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.DEPARTURE_NPC)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
