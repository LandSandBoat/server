-----------------------------------
-- Area: Selbina
--  NPC: Zaldon
-- Involved in Quests: Under the sea, A Boy's Dream
-- Starts and Finishes: Inside the Belly
-- !pos -13 -7 -5 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
