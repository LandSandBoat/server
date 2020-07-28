-----------------------------------
-- Area: Port Bastok
--  NPC: Galvin
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4128, 4445, 1,    -- Ether
        4151,  736, 2,    -- Echo Drops
        4112,  837, 2,    -- Potion
        17318,   3, 2,    -- Wooden Arrow
        4150, 2387, 3,    -- Eye Drops
        4148,  290, 3,    -- Antidote
        17320,   7, 3,    -- Iron Arrow
        17336,   5, 3,    -- Crossbow Bolt
    }

    player:showText(npc, ID.text.GALVIN_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
