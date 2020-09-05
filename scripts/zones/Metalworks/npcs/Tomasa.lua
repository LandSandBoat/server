-----------------------------------
-- Area: Metalworks
--  NPC: Tomasa
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4396,  257, 1,    -- Sausage Roll
        4409,   73, 1,    -- Hard-Boiled Egg
        4417, 3036, 1,    -- Egg Soup
        4442,  368, 1,    -- Pineapple Juice
        4391,   22, 2,    -- Bretzel
        4578,  143, 2,    -- Sausage
        4424, 1012, 2,    -- Melon Juice
        4499,   92, 3,    -- Iron Bread
        4436,  294, 3,    -- Baked Popoto
        4455,  184, 3,    -- Pebble Soup
        4509,   10, 3,    -- Distilled Water
    }

    player:showText(npc, ID.text.TOMASA_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
