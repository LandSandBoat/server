-----------------------------------
-- Area: Lower Jeuno
--  NPC: Morefie
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        13327, 1250,    -- Silver Earring
        13456, 1250,    -- Silver Ring
        13328, 4140,    -- Mythril Earring
    }

    player:showText(npc, ID.text.MOREFIE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
