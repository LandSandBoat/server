-----------------------------------
-- Area: Port Windurst
--  NPC: Ryan
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        16640,  290,    -- Bronze Axe
        16535,  246,    -- Bronze Sword
        17336,    5,    -- Crossbow Bolt
        12576,  235,    -- Bronze Harness
        12577, 2286,    -- Brass Harness
        12704,  128,    -- Bronze Mittens
        12705, 1255,    -- Brass Mittens
        12832,  191,    -- Bronze Subligar
        12833, 1840,    -- Brass Subligar
        12960,  117,    -- Bronze Leggings
        12961, 1140,    -- Brass Leggings
        12584, 1145,    -- Kenpogi
        12712,  630,    -- Tekko
        12840,  915,    -- Sitabaki
        12968,  584,    -- Kyahan
    }

    player:showText(npc, ID.text.RYAN_SHOP_DIALOG)
    tpz.shop.general(player, stock, WINDURST)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
