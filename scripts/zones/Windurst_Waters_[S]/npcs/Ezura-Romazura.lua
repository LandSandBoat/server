-----------------------------------
-- Area: Windurst Waters [S]
--  NPC: Ezura-Romazura
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4771, 123750,        -- Scroll of Stone V
        4781, 133110,        -- Scroll of Water V
        4766, 144875,        -- Scroll of Aero V
        4756, 162500,        -- Scroll of Fire V
        4761, 186375,        -- Scroll of Blizzard V
        4893, 168150,        -- Scroll of Stoneja
        4895, 176700,        -- Scroll of Waterja
        4890, 193800,        -- Scroll of Firaja
        4892, 185240,        -- Scroll of Aeroja
        4863, 126000,        -- Scroll of Break
    }

    player:showText(npc, ID.text.EZURAROMAZURA_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
