-----------------------------------
-- Area: Port Windurst
--  NPC: Uli Pehkowa
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        644, 1840, 1,    -- Mythril Ore
        835,  230, 1,    -- Flax Flower
        699, 5814, 1,    -- Oak Log
        698,   87, 2,    -- Ash Log
        694, 2599, 2,    -- Chestnut Log
        640,   11, 2,    -- Copper Ore
        643,  828, 2,    -- Iron Ore
        4570,  51, 2,    -- Bird Egg
        833,   18, 3,    -- Moko Grass
        114, 1840, 3,    -- My First Magic Kit
    }

    player:showText(npc, ID.text.ULIPEHKOWA_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.WINDURST)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
