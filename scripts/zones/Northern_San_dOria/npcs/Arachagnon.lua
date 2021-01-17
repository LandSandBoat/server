-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Arachagnon
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12633, 270,    -- Elvaan Jerkin
        12634, 270,    -- Elvaan Bodice
        12755, 162,    -- Elvaan Gloves
        12759, 162,    -- Elvaan Gauntlets
        12885, 234,    -- Elvaan M Chausses
        12889, 234,    -- Elvaan F Chausses
        13006, 162,    -- Elvaan M Ledelsens
        13011, 162,    -- Elvaan F Ledelsens
    }

    player:showText(npc, ID.text.ARACHAGNON_SHOP_DIALOG)
    tpz.shop.general(player, stock, SANDORIA)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
