-----------------------------------
-- Area: Bastok Mines
--  NPC: Neigepance
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        17307,    9, 1,    --Dart
        845,   1150, 1,    --Black Chocobo Feather
        4545,    62, 3,    --Gysahl Greens
        840,      7, 3,    --Chocobo Feather
        17016,   11, 3,    --Pet Food Alpha Biscuit
        17017,   82, 3,    --Pet Food Beta Biscuit
        17860,   82, 3,    --Carrot Broth
        17862,  695, 3,    --Bug Broth
        17864,  126, 3,    --Herbal Broth
        17866,  695, 3,    --Carrion Broth
        5073, 50784, 3,    --Scroll of Chocobo Mazurka
    }

    player:showText(npc, ID.text.NEIGEPANCE_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
