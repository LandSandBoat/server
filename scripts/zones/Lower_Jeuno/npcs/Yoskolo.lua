-----------------------------------
-- Area: Lower Jeuno
--  NPC: Yoskolo
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    priceMultiplier = (1 + (0.13 * (9 - player:getFameLevel(xi.quest.fame_area.JEUNO)) / 8)) * xi.settings.main.SHOP_PRICE
    local stock =
    {
        -- Scrolls are not effected by fame
        4509,    10 * priceMultiplier, -- Distilled Water
        4422,   184 * priceMultiplier, -- Orange Juice
        4423,   276 * priceMultiplier, -- Apple Juice
        4424,  1012 * priceMultiplier, -- Melon Juice
        4441,   855 * priceMultiplier, -- Grape Juice
        4442,   368 * priceMultiplier, -- Pineapple Juice
        4556,  5544 * priceMultiplier, -- Icecap Rolanberry
        5046,  6380, -- Scroll of Fire Carol
        5047,  7440, -- Scroll of Ice Carol
        5048,  5940, -- Scroll of Wind Carol
        5049,  4600, -- Scroll of Earth Carol
        5050,  7920, -- Scroll of Lightning Carol
        5051,  5000, -- Scroll of Water Carol
        5052,  4200, -- Scroll of Light Carol
        5053,  8400, -- Scroll of Dark Carol
        -- 5078, 60000, -- Scroll of Sentinel's Scherzo (2010 Abyssea)
    }

    player:showText(npc, ID.text.YOSKOLO_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
