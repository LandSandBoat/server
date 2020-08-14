-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Yafaaf
-- Type: Standard Merchant
-- !pos 76.889 -7 -140.379 50
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        5577, 1500, -- Sutlac
        5592,  450, -- Imperial Coffee
    }

    player:showText(npc, ID.text.YAFAAF_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
