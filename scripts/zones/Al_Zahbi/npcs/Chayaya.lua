-----------------------------------
-- Area: Al Zahbi
--  NPC: Chayaya
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Al_Zahbi/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        17307,    10,    -- Dart
        17308,    60,    -- Hawkeye
        17313,  1204,    -- Grenade
        17320,     8,    -- Iron Arrow
        5477,  68000,    -- Warrior Die
        5478,  22400,    -- Monk Die
        5479,   5000,    -- White Mage Die
        5480, 108000,    -- Black Mage Die
        5481,  62000,    -- Red Mage Die
        5482,  50400,    -- Thief Die
        5483,  90750,    -- Paladin Die
        5484,   2205,    -- Dark Knight Die
        5485,  26600,    -- Beastmaster Die
        5486,  12780,    -- Bard Die
        5487,   1300,    -- Ranger Die
        5495,  63375,    -- Dancer Die
        5496,  68250     -- Scholar Die
    }

    player:showText(npc, ID.text.CHAYAYA_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
