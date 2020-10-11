-----------------------------------
-- Area: Kazham
--  NPC: Pahya Lolohoiv
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Kazham/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4509,   10,    -- Distilled Water
        4150, 2387,    -- Eye Drops
        4148,  290,    -- Antidote
        4151,  736,    -- Echo Drops
        4112,  837,    -- Potion
        4128, 4445,    -- Ether
        924,   556,    -- Fiend Blood
        943,   294,    -- Poison Dust
    }

    player:showText(npc, ID.text.PAHYALOLOHOIV_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
