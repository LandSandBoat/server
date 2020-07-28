-----------------------------------
-- Area: Kazham
--  NPC: Khifo Ryuhkowa
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Kazham/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        16473,   5713,    -- Kukri
        16595, 153014,    -- Ram-Dao
        16833,    809,    -- Bronze Spear
        16835,  16228,    -- Spear
        16839,  75541,    -- Partisan
        17025,   1600,    -- Chestnut Club
        17026,   4945,    -- Bone Cudgel
        17052,   5255,    -- Chestnut Wand
        17092,  29752,    -- Mahogany Staff
        17099,  99176,    -- Mahogany Pole
        17163,  39744,    -- Battle Bow
        17308,     55,    -- Hawkeye
        17280,   1610,    -- Boomerang
        17318,      3,    -- Woden Arrow
    }

    player:showText(npc, ID.text.KHIFORYUHKOWA_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
