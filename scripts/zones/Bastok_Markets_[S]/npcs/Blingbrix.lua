-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Blingbrix
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4116,  4500,    --Hi-Potion
        4132, 28000,    --Hi-Ether
        605,    200,    --Pickaxe
        1020,   300     --Sickle
    }

    player:showText(npc, ID.text.BLINGBRIX_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
