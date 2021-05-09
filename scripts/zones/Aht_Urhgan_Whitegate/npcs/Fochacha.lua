-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Fochacha
-- Type: Standard NPC
-- !pos 2.897 -1 -10.781 50
--  Quest: Delivering the Goods
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
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
