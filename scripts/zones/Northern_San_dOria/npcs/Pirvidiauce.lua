-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Pirvidiauce
-- Conquest depending medicine seller
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.CERAMIC_FLOWERPOT,    1000, 3, },
        { xi.item.PILE_OF_RED_GRAVEL,   2205, 3, },
        { xi.item.ASH_CLOGS,             124, 3, },
        { xi.item.HOLLY_CLOGS,          1625, 2, },
        { xi.item.CHESTNUT_SABOTS,      9180, 1, },
        { xi.item.WOODEN_ARROW,            4, 3, },
        { xi.item.CROSSBOW_BOLT,           6, 2, },
        { xi.item.FLASK_OF_EYE_DROPS,   2595, 3, },
        { xi.item.ANTIDOTE,              316, 3, },
        { xi.item.FLASK_OF_ECHO_DROPS,   800, 2, },
        { xi.item.POTION,                910, 1, },
        { xi.item.ETHER,                4832, 1, },
        { xi.item.KINGDOM_WAYSTONE,    10000, 3, },
    }

    player:showText(npc, ID.text.PIRVIDIAUCE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
