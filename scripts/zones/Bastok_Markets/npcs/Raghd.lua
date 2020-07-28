-----------------------------------
-- Area: Bastok Markets
--  NPC: Raghd
-- Standard Merchant NPC
-- !pos -149.200 -4.819 -74.939 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")

function onTrigger(player, npc)
    local stock =
    {
        13456, 1150, 1,    -- Silver Ring
        13327, 1150, 1,    -- Silver Earring
        13465,  184, 2,    -- Brass Ring
        13454,   69, 3,    -- Copper Ring
    }

    player:showText(npc, ID.text.RAGHD_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end
