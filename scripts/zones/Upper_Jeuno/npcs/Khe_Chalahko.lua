-----------------------------------
-- Area: Upper Jeuno
--  NPC: Khe Chalahko
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12416, 29311,    -- Sallet
        12544, 45208,    -- Breastplate
        12800, 34776,    -- Cuisses
        12928, 21859,    -- Plate Leggins
        12810, 53130,    -- Breeches
        12938, 32637,    -- Sollerets
    }

    player:showText(npc, ID.text.KHECHALAHKO_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
