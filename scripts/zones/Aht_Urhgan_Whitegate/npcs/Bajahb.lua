-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Bajahb
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12424, 10260,    -- Iron Mask
        12552, 15840,    -- Chainmail
        12680,  8460,    -- Chain Mittens
        12808, 12600,    -- Chain Hose
        12936,  7740     -- Greaves
    }

    player:showText(npc, ID.text.BAJAHB_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
