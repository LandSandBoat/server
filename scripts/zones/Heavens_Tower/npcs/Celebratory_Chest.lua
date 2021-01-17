-----------------------------------
-- Area: Heavens Tower
--  NPC: Celebratory Chest
-- Type: Merchant NPC
-- !pos -7.600 0.249 25.239 242
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
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
