-----------------------------------
-- Area: Ranguemont Pass
--  NPC: Waters of Oblivion
-- Finish Quest: Painful Memory (BARD AF1)
-- !pos -284 -45 210 166
-----------------------------------
local ID = require("scripts/zones/Ranguemont_Pass/IDs")
require("scripts/globals/npc_util")
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
