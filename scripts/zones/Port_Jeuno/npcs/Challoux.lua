-----------------------------------
-- Area: Port Jeuno
--  NPC: Challoux
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4545, 62,    -- Gysahl Greens
        840,   4,    -- Chocobo Feather
        17307, 9,    -- Dart
    }

    player:showText(npc, ID.text.CHALLOUX_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
