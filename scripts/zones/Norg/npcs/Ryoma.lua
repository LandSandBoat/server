-----------------------------------
-- Area: Norg
--  NPC: Ryoma
-- Start and Finish Quest: 20 in Pirate Years, I'll Take the Big Box, True Will, Bugi Soden
-- Involved in Quest: Ayame and Kaede
-- !pos -23 0 -9 252
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
require("scripts/globals/quests")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
