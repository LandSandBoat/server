-----------------------------------
-- Area: Windurst Walls
--  NPC: Koru-Moru
-- Starts & Ends Quest: Star Struck
-- Involved in Quest: Making the Grade, Riding on the Clouds
-- !pos -120 -6 124 239
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
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
