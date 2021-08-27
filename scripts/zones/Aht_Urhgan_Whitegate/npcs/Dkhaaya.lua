-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Dkhaaya
-- Type: Standard NPC
-- !pos -73.212 -1 -5.842 50
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
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
