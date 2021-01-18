-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Silke
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
        6059, 29925,    -- Animus Augeo Schema
        6060, 29925,    -- Animus Minuo Schema
        6061, 36300     -- Adloquim Schema
    }

    player:showText(npc, ID.text.SILKE_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
