-----------------------------------
-- Area: Nashmau
--  NPC: Poporoon
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Nashmau/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12952,   336,    -- Leather Highboots
        12953,  3438,    -- Lizard Ledelsens
        12954, 11172,    -- Studded Boots
        12955, 20532,    -- Cuir Highboots
    }

    player:showText(npc, ID.text.POPOROON_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
