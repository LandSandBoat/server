-----------------------------------
-- Area: Lower Jeuno (245)
--  NPC: Mertaire
-- Starts and Finishes Quest: The Old Monument (start only), A Minstrel in Despair, Painful Memory (BARD AF1)
-- !pos -17 0 -61 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
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
