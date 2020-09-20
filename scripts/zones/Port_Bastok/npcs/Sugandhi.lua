-----------------------------------
-- Area: Port Bastok
--  NPC: Sugandhi
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        16473,  5589, 1,    -- Kukri
        16545, 21067, 1,    -- Broadsword
        16513, 11588, 1,    -- Tuck
        16558, 61200, 1,    -- Falchion
        16466,  2182, 2,    -- Knife
        16537, 30960, 2,    -- Mythril Sword
        16552,  4072, 2,    -- Scimitar
        16465,   147, 3,    -- Bronze Knife
        16405,   104, 3,    -- Cat Baghnakhs
        16535,   241, 3,    -- Bronze Sword
        16536,  7128, 3,    -- Iron Sword
        16517,  9201, 3,    -- Degen
        16551,   698, 3,    -- Sapara
    }

    player:showText(npc, ID.text.SUGANDHI_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
