-----------------------------------
-- Area: Windurst Woods
--  NPC: Perih Vashai
-- Starts and Finishes Quest: The Fanged One, From Saplings Grow
-- !pos 117 -3 92 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
