-----------------------------------
-- Area: Selbina
--  NPC: Falgima
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4744,  5351,    -- Scroll of Invisible
        4745,  2325,    -- Scroll of Sneak
        4746,  1204,    -- Scroll of Deodorize
        5104, 30360,    -- Scroll of Flurry
    }

    player:showText(npc, ID.text.FALGIMA_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
