-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ryo
-- Type: ZNM assistant
-- !pos -127.086 0.999 22.693 50
-----------------------------------
require("scripts/globals/besieged")
require("scripts/globals/znm")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.znm.ryo.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.znm.ryo.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.znm.ryo.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.znm.ryo.onEventFinish(player, csid, option)
end

return entity
