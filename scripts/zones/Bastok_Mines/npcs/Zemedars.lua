-----------------------------------
-- Area: Bastok Mines
--  NPC: Zemedars
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BRONZE_SUBLIGAR,     208, 3 },
        { xi.item.BRASS_SUBLIGAR,     2000, 2 },
        { xi.item.IRON_SUBLIGAR,     25102, 1 },
        { xi.item.LEATHER_TROUSERS,    536, 2 },
        { xi.item.LIZARD_TROUSERS,    5387, 1 },
        { xi.item.CHAIN_HOSE,        12600, 3 },
        { xi.item.BRONZE_LEGGINGS,     128, 3 },
        { xi.item.BRASS_LEGGINGS,     1240, 2 },
        { xi.item.LEGGINGS,          15594, 1 },
        { xi.item.LEATHER_HIGHBOOTS,   336, 2 },
        { xi.item.LIZARD_LEDELSENS,   3405, 1 },
        { xi.item.GREAVES,            7740, 3 },
        { xi.item.MAPLE_SHIELD,        605, 3 },
        { xi.item.LAUAN_SHIELD,        120, 3 },
        { xi.item.TARGE,             12040, 2 },
        { xi.item.BUCKLER,           33960, 1 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MINES].text.ZEMEDARS_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
