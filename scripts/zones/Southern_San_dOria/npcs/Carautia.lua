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
        { xi.item.LAUAN_SHIELD,        120, 3, },
        { xi.item.MAPLE_SHIELD,        605, 3, },
        { xi.item.MAHOGANY_SHIELD,    4980, 2, },
        { xi.item.KITE_SHIELD,       11424, 1, },
        { xi.item.BRONZE_SUBLIGAR,     208, 3, },
        { xi.item.BRASS_SUBLIGAR,     2000, 3, },
        { xi.item.LEATHER_TROUSERS,    536, 3, },
        { xi.item.STUDDED_TROUSERS,  18392, 2, },
        { xi.item.CHAIN_HOSE,        12600, 1, },
        { xi.item.BRONZE_LEGGINGS,     128, 3, },
        { xi.item.BRASS_LEGGINGS,     1240, 3, },
        { xi.item.LEATHER_HIGHBOOTS,   336, 3, },
        { xi.item.STUDDED_BOOTS,     11172, 2, },
        { xi.item.GREAVES,            7740, 1, },
    }

    player:showText(npc, ID.text.CARAUTIA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
