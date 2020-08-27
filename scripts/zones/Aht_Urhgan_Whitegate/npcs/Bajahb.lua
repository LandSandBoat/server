-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Bajahb
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        12424, 10260,    -- Iron Mask
        12552, 15840,    -- Chainmail
        12680,  8460,    -- Chain Mittens
        12808, 12600,    -- Chain Hose
        12936,  7740     -- Greaves
    }

    player:showText(npc, ID.text.BAJAHB_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
