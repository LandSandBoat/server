-----------------------------------
-- Area: Ship Bound for Mhaura
--  NPC: Chhaya
-- Standard Merchant NPC
-- !pos -1.139 -2.101 -9.000 221
-----------------------------------
local ID = require("scripts/zones/Ship_bound_for_Mhaura/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4112,  910,    -- Potion
        4128, 4832,    -- Ether
        4148,  316,    -- Antidote
        4150, 2595,    -- Eye Drops
        4151,  800,    -- Echo Drops
    }

    player:showText(npc, ID.text.CHHAYA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
