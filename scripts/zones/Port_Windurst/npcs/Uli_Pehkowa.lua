-----------------------------------
-- Area: Port Windurst
--  NPC: Uli Pehkowa
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.ASH_LOG,                99, 2 },
        { xi.item.CHESTNUT_LOG,         2939, 2 },
        { xi.item.OAK_LOG,              6572, 1 },
        { xi.item.CHUNK_OF_COPPER_ORE,    12, 2 },
        { xi.item.CHUNK_OF_IRON_ORE,     936, 2 },
        { xi.item.CHUNK_OF_MYTHRIL_ORE, 2080, 1 },
        { xi.item.CLUMP_OF_MOKO_GRASS,    20, 3 },
        { xi.item.BIRD_EGG,               58, 2 },
        { xi.item.FLAX_FLOWER,           260, 1 },
        { xi.item.MY_FIRST_MAGIC_KIT,   2080, 3 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.ULIPEHKOWA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
