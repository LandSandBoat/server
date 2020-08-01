-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Khaf Jhifanm
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        5567,   200,    -- Dried Date
        5576,   800,    -- Ayran
        5590,  3750,    -- Balik Sandvici
        2235,   320,    -- Wildgrass Seeds
        5075,  4400,    -- Scroll of Raptor Mazurka
        2872, 10000     -- Empire Waystone
    }

    player:showText(npc, ID.text.KHAFJHIFANM_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
