-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Mulnith
-- Standard Merchant NPC
-- TODO: Stock needs to be modified based on
--       status of Astral Candescence
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4410,  344,    -- Roast Mushroom
        5598, 2000,    -- Sis Kebabi (Requires Astral Candescence)
        5600, 3000     -- Balik Sis (Requires Astral Candescence)
    }

    player:showText(npc, ID.text.MULNITH_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
