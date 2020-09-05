-----------------------------------
-- Area: Fort Karugo-Narugo
--  NPC: Spondulix
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Fort_Karugo-Narugo_[S]/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4116,  4500,    -- Hi-Potion
        4132, 28000,    -- Hi-Ether
        2563,  3035,    -- Karugo Clay
    }

    player:showText(npc, ID.text.SPONDULIX_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
