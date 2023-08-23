-----------------------------------
-- Area: Port Bastok
--  NPC: Ensetsu
-- Finish Quest: Ayame and Kaede
-- Involved in Quest: 20 in Pirate Years, I'll Take the Big Box
-- !pos 33 -6 67 236
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
require('scripts/globals/npc_util')
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
