-----------------------------------
-- Area: Western Adoulin
--  NPC: Preterig
-- Type: Shop NPC
-- !pos 6 0 -53 256
-----------------------------------
require("scripts/globals/shop")
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard shop
    player:showText(npc, ID.text.PRETERIG_SHOP_TEXT)
    local stock =
    {
        4423, 300,    -- Apple Juice
        5944, 125,    -- Frontier Soda
        4421, 1560,   -- Melon Pie
        4422, 200,    -- Orange Juice
    }
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
