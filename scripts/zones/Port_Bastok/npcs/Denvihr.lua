-----------------------------------
-- Area: Port Bastok
--  NPC: Denvihr
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        699, 5688, 1,    -- Oak Log
        644, 1800, 1,    -- Mythril Ore
        835,  225, 1,    -- Flax Flower
        698,   86, 2,    -- Ash Log
        694, 2543, 2,    -- Chestnut Log
        643,  810, 2,    -- Iron Ore
        833,   18, 2,    -- Moko Grass
        4570,  50, 2,    -- Bird Egg
        640,   10, 3,    -- Copper Ore
        136, 1800, 3,    -- Kaiserin Cosmetics
    }

    player:showText(npc, ID.text.DENVIHR_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
