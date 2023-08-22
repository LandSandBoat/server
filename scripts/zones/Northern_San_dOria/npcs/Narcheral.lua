-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Narcheral
-- Starts and Finishes Quest: Messenger from Beyond, Prelude of Black and White (Finish), Pieuje's Decision (Finish)
-- !pos 129 -11 126 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/shop")
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
