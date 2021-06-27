-----------------------------------
-- Area: Western Adoulin
--  NPC: Berghent
-- Type: Standard NPC and Quest NPC
-- Starts, Involved with, and Finishes Quest: 'Flavors of our Lives'
-- !pos 95 0 -28 256
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
local ID = require("scripts/zones/Western_Adoulin/IDs")
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
