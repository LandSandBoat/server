-----------------------------------
-- Area: Western Adoulin
--  NPC: Tevigogo
-- Type: Shop NPC
-- !pos -151 3 -36 256
-----------------------------------
require("scripts/globals/shop")
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard shop
    player:showText(npc, ID.text.TEVIGOGO_SHOP_TEXT)
    local stock =
    {
        605, 200,    -- Pickaxe
        1021, 500,    -- Hatchet
        1020, 300,    -- Sickle
        17307, 10,     -- Dart
        17308, 60,     -- Hawkeye
        17320, 8,      -- Iron Arrow
    }
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
