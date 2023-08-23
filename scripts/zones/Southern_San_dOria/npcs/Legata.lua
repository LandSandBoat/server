-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Legata
-- Starts and Finishes Quest: Starting a Flame (R)
-- !pos 82 0 116 230
-----------------------------------
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
