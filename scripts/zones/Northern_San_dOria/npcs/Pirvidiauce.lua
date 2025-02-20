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
        xi.item.CERAMIC_FLOWERPOT,    1040, 3,
        xi.item.PILE_OF_RED_GRAVEL,   2293, 3,
        xi.item.ASH_CLOGS,             128, 3,
        xi.item.HOLLY_CLOGS,          1690, 2,
        xi.item.CHESTNUT_SABOTS,      9547, 1,
        xi.item.WOODEN_ARROW,            4, 3,
        xi.item.CROSSBOW_BOLT,           6, 2,
        xi.item.FLASK_OF_EYE_DROPS,   2698, 3,
        xi.item.ANTIDOTE,              328, 3,
        xi.item.FLASK_OF_ECHO_DROPS,   832, 2,
        xi.item.POTION,                946, 1,
        xi.item.ETHER,                5025, 1,
        xi.item.KINGDOM_WAYSTONE,    10400, 3,
    }

    player:showText(npc, ID.text.PIRVIDIAUCE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
