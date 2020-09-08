-----------------------------------
-- Area: Bastok Mines
--  NPC: Zemedars
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        12836, 23316, 1,    --Iron Subligar
        12825,  5003, 1,    --Lizard Trousers
        12962, 14484, 1,    --Leggins
        12953,  3162, 1,    --Lizard Ledelsens
        12301, 31544, 1,    --Buckler
        12833,  1840, 2,    --Brass Subligar
        12824,   493, 2,    --Leather Trousers
        12961,  1140, 2,    --Brass Leggins
        12952,   309, 2,    --Leather Highboots
        12300, 11076, 2,    --Targe
        12832,   191, 3,    --Bronze Subligar
        12808, 11592, 3,    --Chain Gose
        12960,   117, 3,    --Bronze Leggins
        12936,  7120, 3,    --Greaves
        12290,   556, 3,    --Maple Shield
        12289,   110, 3,    --Lauan Shield
    }

    player:showText(npc, ID.text.ZEMEDARS_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
