-----------------------------------
-- Area: Lower Jeuno
--  NPC: Yoskolo
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4509,    10,    -- Distilled Water
        4422,   184,    -- Orange Juice
        4423,   276,    -- Apple Juice
        4424,  1012,    -- Melon Juice
        4441,   855,    -- Grape Juice
        4442,   368,    -- Pineapple Juice
        4556,  5544,    -- Icecap Rolanberry
        5046,  6380,    -- Scroll of Fire Carol
        5047,  7440,    -- Scroll of Ice Carol
        5048,  5940,    -- Scroll of Wind Carol
        5049,  4600,    -- Scroll of Earth Carol
        5050,  7920,    -- Scroll of Lightning Carol
        5051,  5000,    -- Scroll of Water Carol
        5052,  4200,    -- Scroll of Light Carol
        5053,  8400,    -- Scroll of Dark Carol
        5078, 60000,    -- Scroll of Sentinel's Scherzo
    }

    player:showText(npc, ID.text.YOSKOLO_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
