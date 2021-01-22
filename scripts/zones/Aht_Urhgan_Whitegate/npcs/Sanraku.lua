-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Sanraku
-- Type: Zeni NM pop item and trophy management.
-- !pos -125.724 0.999 22.136 50
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/besieged")
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
