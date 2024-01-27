-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Arachagnon
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
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
    xi.shop.general(player, stock, xi.quest.fame_area.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
