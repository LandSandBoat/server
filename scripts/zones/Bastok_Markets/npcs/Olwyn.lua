-----------------------------------
-- Area: Bastok Markets
--  NPC: Olwyn
-- Standard Merchant NPC
-- !pos -322.123 -10.319 -169.418 235
-----------------------------------
require("scripts/globals/events/harvest_festivals")
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

function onTrigger(player, npc)
    local stock =
    {
        4128, 4445, 1,    -- Ether
        4151,  736, 2,    -- Echo Drops
        4112,  837, 2,    -- Potion
        4150, 2387, 3,    -- Eye Drops
        4148,  290, 3,    -- Antidote
    }

    player:showText(npc, ID.text.OLWYN_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end
