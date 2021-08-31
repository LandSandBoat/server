-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Blingbrix
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4116,  4500,    --Hi-Potion
        4132, 28000,    --Hi-Ether
        605,    200,    --Pickaxe
        1020,   300     --Sickle
    }

    player:showText(npc, ID.text.BLINGBRIX_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
