-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Pelftrix
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4116, 4500,  -- Hi-Potion
        4132, 28000, -- Hi-Ether
        1020, 300,   -- Sickle
        1021, 500,   -- Hatchet
    }

    player:showText(npc, ID.text.PELFTRIX_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
