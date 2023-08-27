-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Paouala
-- Starts and Finishes Quest: Sleepless Nights
-- !pos 158 -6 17 230
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
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
