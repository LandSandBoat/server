-----------------------------------
-- Area: Port Bastok
--  NPC: Carmelo
-- Start & Finishes Quest: A Test of True Love
-- Start Quest: Lovers in the Dusk
-- !pos -146.476 -7.48 -10.889 236
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
