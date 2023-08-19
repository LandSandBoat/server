-----------------------------------
-- Area: Bastok Mines
--  NPC: Zemedars
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.BRONZE_SUBLIGAR,     216, 3,
        xi.items.BRASS_SUBLIGAR,     2080, 2,
        xi.items.IRON_SUBLIGAR,     26357, 1,
        xi.items.LEATHER_TROUSERS,    557, 2,
        xi.items.LIZARD_TROUSERS,    5656, 1,
        xi.items.CHAIN_HOSE,        13104, 3,
        xi.items.BRONZE_LEGGINGS,     133, 3,
        xi.items.BRASS_LEGGINGS,     1289, 2,
        xi.items.LEGGINGS,          16373, 1,
        xi.items.LEATHER_HIGHBOOTS,   349, 2,
        xi.items.LIZARD_LEDELSENS,   3575, 1,
        xi.items.GREAVES,            8049, 3,
        xi.items.MAPLE_SHIELD,        629, 3,
        xi.items.LAUAN_SHIELD,        124, 3,
        xi.items.TARGE,             12521, 2,
        xi.items.BUCKLER,           35658, 1,
    }

    player:showText(npc, ID.text.ZEMEDARS_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
