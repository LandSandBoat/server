-----------------------------------
-- Area: Al Zahbi
--  NPC: Allard
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Al_Zahbi/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12466, 20000,    --Red Cap
        12594, 32500,    --Gambison
        12722, 16900,    --Bracers
        12850, 24500,    --Hose
        12978, 16000    --Socks
    }

    player:showText(npc, ID.text.ALLARD_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
