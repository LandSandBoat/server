-----------------------------------
-- Area: Windurst Woods
--  NPC: Mono Nchaa
-- Standard Merchant NPC
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock = {
        17318, 3,    2, -- Wooden Arrow
        17319, 4,    3, -- Bone Arrow
        17323, 131,  2, -- Ice Arrow
        17324, 131,  2, -- Lightning Arrow
        17336, 5,    3, -- Crossbow Bolt
        17308, 55,   2, -- Hawkeye
        17280, 1645, 2, -- Boomerang
        17152, 45,   2, -- Shortbow
        17153, 503,  2, -- Self Bow
        17154, 7444, 2, -- Wrapped Bow
        17216, 165,  2, -- Light Crossbow
        5009,  2649, 3  -- Scroll of Hunter's Prelude
    }

    player:showText(npc, ID.text.MONONCHAA_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.WINDURST)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
