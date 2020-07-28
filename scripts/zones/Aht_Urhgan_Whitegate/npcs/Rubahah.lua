-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Rubahah
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
        629,   48,    -- Millioncorn
        2237,  60,    -- Imperial Flour (Requires Astral Candescence)
        2214,  68,    -- Imperial Rice (Requires Astral Candescence)
        2271, 316     -- Coffee Beans (Requires Astral Candescence)
    }

    player:showText(npc, ID.text.RUBAHAH_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
