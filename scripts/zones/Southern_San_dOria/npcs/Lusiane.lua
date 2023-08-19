-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Lusiane
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        17389,  496, 1,    -- Bamboo Fishing Rod
        17395,    9, 2,    -- Lugworm
        17390,  217, 2,    -- Yew Fishing Rod
        17396,    3, 3,    -- Little Worm
        5068,   110, 3,    -- Scroll of Light Threnoldy
        5066,  1265, 3,    -- Scroll of Lightning Threnoldy
        17391,   66, 3,    -- Willow Fishing Rod
    }

    player:showText(npc, ID.text.LUSIANE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
