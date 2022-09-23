-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ekhu Pesshyadha
-- Type: Standard NPC
-- !pos -13.043 0.999 103.423 50
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
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
