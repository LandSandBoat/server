-----------------------------------
-- Area: Port Bastok
--  NPC: Denvihr
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.ASH_LOG,                     99, 2,
        xi.items.CHESTNUT_LOG,              2939, 2,
        xi.items.OAK_LOG,                   6572, 1,
        xi.items.CHUNK_OF_COPPER_ORE,         12, 3,
        xi.items.CHUNK_OF_IRON_ORE,          936, 2,
        xi.items.CHUNK_OF_MYTHRIL_ORE,      2080, 1,
        xi.items.CLUMP_OF_MOKO_GRASS,         20, 2,
        xi.items.BIRD_EGG,                    58, 2,
        xi.items.FLAX_FLOWER,                260, 1,
        xi.items.SET_OF_KAISERIN_COSMETICS, 2080, 3,
    }

    player:showText(npc, ID.text.DENVIHR_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
