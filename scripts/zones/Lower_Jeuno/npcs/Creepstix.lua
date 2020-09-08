-----------------------------------
-- Area: Lower Jeuno
--  NPC: Creepstix
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        5023,   8160,    -- Scroll of Goblin Gavotte
        4734,   7074,    -- Scroll of Protectra II
        4738,   1700,    -- Scroll of Shellra
        5089,  73740,    -- Scroll of Gain-VIT
        5092,  77500,    -- Scroll of Gain-MND
        5090,  85680,    -- Scroll of Gain-AGI
        5093,  81900,    -- Scroll of Gain-CHR
        5096,  73740,    -- Scroll of Boost-VIT
        5099,  77500,    -- Scroll of Boost-MND
        5097,  85680,    -- Scroll of Boost-AGI
        5100,  81900,    -- Scroll of Boost-CHR
        4849, 130378,    -- Scroll of Addle
    }

    player:showText(npc, ID.text.CREEPSTIX_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
