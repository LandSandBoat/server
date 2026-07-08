-----------------------------------
-- Area: Bastok Markets
--  NPC: Ciqala
-- Type: Merchant
-- !pos -283.147 -11.319 -143.680 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BRONZE_KNUCKLES,  256, 3 },
        { xi.item.BRASS_KNUCKLES,   945, 3 },
        { xi.item.METAL_KNUCKLES,  5447, 1 },
        { xi.item.CESTI,            151, 3 },
        { xi.item.BRASS_BAGHNAKHS, 1774, 3 },
        { xi.item.CAT_BAGHNAKHS,    121, 3 },
        { xi.item.BRONZE_HAMMER,    357, 3 },
        { xi.item.BRASS_HAMMER,    2430, 3 },
        { xi.item.WARHAMMER,       6820, 1 },
        { xi.item.MAPLE_WAND,        54, 3 },
        { xi.item.ASH_CLUB,          75, 3 },
        { xi.item.BRONZE_ROD,       105, 3 },
        { xi.item.BRASS_ROD,        724, 3 },
        { xi.item.ASH_STAFF,         67, 3 },
        { xi.item.ASH_POLE,         441, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.CIQALA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
