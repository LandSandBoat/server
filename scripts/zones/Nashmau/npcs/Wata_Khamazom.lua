-----------------------------------
-- Area: Nashmau
--  NPC: Wata Khamazom
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Nashmau/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        17152,    44,    -- Shortbow
        17153,   536,    -- Self Bow
        17154,  7920,    -- Wrapped Bow
        17160,   492,    -- Longbow
        17162, 21812,    -- Great Bow
        17318,     4,    -- Wooden Arrow
        17320,     8,    -- Iron Arrow
        17321,    18,    -- Silver Arrow
        17322,   140,    -- Fire Arrow
        17336,     6,    -- Crossbow Bolt
        18258,   248,    -- Throwing Tomahawk
    }

    player:showText(npc, ID.text.WATAKHAMAZOM_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
