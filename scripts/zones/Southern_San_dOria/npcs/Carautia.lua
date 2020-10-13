-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Carautia
-- Standard Merchant NPC
-- !pos 70 0 39 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        12808, 11340, 1,    -- Chain Hose
        12936,  6966, 1,    -- Greaves
        12306, 10281, 1,    -- Kite Shield
        12292,  4482, 2,    -- Mahogany Shield
        12826, 16552, 2,    -- Studded Trousers
        12954, 10054, 2,    -- Studded Boots
        12289,   110, 3,    -- Lauan Shield
        12290,   544, 3,    -- Maple Shield
        12832,   187, 3,    -- Bronze Subligar
        12833,  1800, 3,    -- Brass Subligar
        12824,   482, 3,    -- Leather Trousers
        12960,   115, 3,    -- Bronze Leggings
        12961,  1116, 3,    -- Brass Leggings
        12952,   302, 3,    -- Leather Highboots
    }

    player:showText(npc, ID.text.CARAUTIA_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.SANDORIA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
