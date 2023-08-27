-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Vamorcote
-- Starts and Finishes Quest: The Setting Sun
-- !pos -137.070 10.999 161.855 231
-----------------------------------
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
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
