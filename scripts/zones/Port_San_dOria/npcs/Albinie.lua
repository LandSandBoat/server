-----------------------------------
-- Area: Port San d'Oria
--  NPC: Albinie
-----------------------------------
local ID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.ASH_LOG,                   99, 3,
        xi.item.CHESTNUT_LOG,            2939, 2,
        xi.item.OAK_LOG,                 6572, 1,
        xi.item.CHUNK_OF_COPPER_ORE,       12, 2,
        xi.item.CHUNK_OF_IRON_ORE,        936, 2,
        xi.item.CHUNK_OF_MYTHRIL_ORE,    2080, 1,
        xi.item.CLUMP_OF_MOKO_GRASS,       20, 2,
        xi.item.BIRD_EGG,                  58, 2,
        xi.item.FLAX_FLOWER,              260, 1,
        xi.item.PILE_OF_CHOCOBO_BEDDING, 2080, 3,
    }

    player:showText(npc, ID.text.ALBINIE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
