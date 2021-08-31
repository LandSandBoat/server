-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ilita
--  Linkshell Merchant
-- !pos -142 -1 -25 236
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        512,  8000,    -- Linkshell
        16285, 375,    -- Pendant Compass
    }

    player:showText(npc, ID.text.PAUNELIE_SHOP_DIALOG, 513)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
