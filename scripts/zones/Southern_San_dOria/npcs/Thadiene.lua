-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Thadiene
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        17280,  1575, 1,    -- Boomerang
        17162, 19630, 1,    -- Great Bow
        17321,    16, 1,    -- Silver Arrow
        17154,  7128, 1,    -- Wrapped Bow
        17336,     5, 2,    -- Crossbow Bolt
        17322,   126, 2,    -- Fire Arrow
        17320,     7, 2,    -- Iron Arrow
        17153,   482, 2,    -- Self Bow
        17160,   442, 3,    -- Longbow
        17152,    38, 3,    -- Shortbow
        17318,     3, 3,    -- Wooden Arrow
        5029,   4320, 3,    -- Scroll of Battlefield Elegy
    }

    player:showText(npc, ID.text.ASH_THADI_ENE_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.SANDORIA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
