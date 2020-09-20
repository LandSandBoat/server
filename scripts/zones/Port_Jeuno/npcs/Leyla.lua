-----------------------------------
-- Area: Port Jeuno
--  NPC: Leyla
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        17308,  55,    -- Hawkeye
        17320,   7,    -- Iron Arrow
        17336,   5,    -- Crossbow Bolt
        4509,   10,    -- Distilled Water
        5038, 1000,    -- Enchanting Etude
        5037, 1265,    -- Spirited Etude
        5036, 1567,    -- Learned Etude
        5035, 1913,    -- Quick Etude
        5034, 2208,    -- Vivacious Etude
        5033, 2815,    -- Dextrous Etude
        5032, 3146,    -- Sinewy Etude
    }

    player:showText(npc, ID.text.LEYLA_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
