-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Song Runes
--  Finishes Quest: The Old Monument
-- !pos -244 16 -280 118
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/quests")
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
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
