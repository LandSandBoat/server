-----------------------------------
-- Area: Windurst Waters
-- NPC: Ohbiru-Dohbiru
-- Involved in quest: Food For Thought, Say It with Flowers
-- Starts and finishes quests: Toraimarai Turmoil, Water Way to Go
-- !pos 23 -5 -193 238
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/titles")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
