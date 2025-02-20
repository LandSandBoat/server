-----------------------------------
-- Area: Bastok Mines
--  NPC: Zemedars
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.BRONZE_SUBLIGAR,     216, 3,
        xi.item.BRASS_SUBLIGAR,     2080, 2,
        xi.item.IRON_SUBLIGAR,     26357, 1,
        xi.item.LEATHER_TROUSERS,    557, 2,
        xi.item.LIZARD_TROUSERS,    5656, 1,
        xi.item.CHAIN_HOSE,        13104, 3,
        xi.item.BRONZE_LEGGINGS,     133, 3,
        xi.item.BRASS_LEGGINGS,     1289, 2,
        xi.item.LEGGINGS,          16373, 1,
        xi.item.LEATHER_HIGHBOOTS,   349, 2,
        xi.item.LIZARD_LEDELSENS,   3575, 1,
        xi.item.GREAVES,            8049, 3,
        xi.item.MAPLE_SHIELD,        629, 3,
        xi.item.LAUAN_SHIELD,        124, 3,
        xi.item.TARGE,             12521, 2,
        xi.item.BUCKLER,           35658, 1,
    }

    player:showText(npc, ID.text.ZEMEDARS_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
