-----------------------------------
-- Area: Metalworks
--  NPC: Celebratory Chest
-- Type: Merchant NPC
-- !pos 88.029 -20.170 -11.086 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.shop.celebratory(player)
    player:messageSpecial(ID.text.CELEBRATORY_GOODS)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
