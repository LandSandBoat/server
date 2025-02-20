-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Carautia
-- !pos 70 0 39 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.LAUAN_SHIELD,        124, 3,
        xi.item.MAPLE_SHIELD,        629, 3,
        xi.item.MAHOGANY_SHIELD,    5179, 2,
        xi.item.KITE_SHIELD,       11880, 1,
        xi.item.BRONZE_SUBLIGAR,     216, 3,
        xi.item.BRASS_SUBLIGAR,     2080, 3,
        xi.item.LEATHER_TROUSERS,    557, 3,
        xi.item.STUDDED_TROUSERS,  19127, 2,
        xi.item.CHAIN_HOSE,        13104, 1,
        xi.item.BRONZE_LEGGINGS,     133, 3,
        xi.item.BRASS_LEGGINGS,     1289, 3,
        xi.item.LEATHER_HIGHBOOTS,   349, 3,
        xi.item.STUDDED_BOOTS,     11618, 2,
        xi.item.GREAVES,            8049, 1,
    }

    player:showText(npc, ID.text.CARAUTIA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
