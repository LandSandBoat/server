-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Fayeewah
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        5570,   68,    -- Cup of Chai
        5572, 2075     -- Irmik Helvasi
    }

    player:showText(npc, ID.text.FAYEEWAH_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
