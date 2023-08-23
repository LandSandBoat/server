-----------------------------------
-- Area: Bastok Markets
--  NPC: Ciqala
-- Type: Merchant
-- !pos -283.147 -11.319 -143.680 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.BRONZE_KNUCKLES,  253, 3,
        xi.item.BRASS_KNUCKLES,   936, 3,
        xi.item.METAL_KNUCKLES,  5447, 1,
        xi.item.CESTI,            149, 3,
        xi.item.BRASS_BAGHNAKHS, 1757, 3,
        xi.item.CAT_BAGHNAKHS,    120, 3,
        xi.item.BRONZE_HAMMER,    353, 3,
        xi.item.BRASS_HAMMER,    2407, 3,
        xi.item.WARHAMMER,       6820, 1,
        xi.item.MAPLE_WAND,        54, 3,
        xi.item.ASH_CLUB,          74, 3,
        xi.item.BRONZE_ROD,       104, 3,
        xi.item.BRASS_ROD,        717, 3,
        xi.item.ASH_STAFF,         66, 3,
        xi.item.ASH_POLE,         436, 3,
    }

    player:showText(npc, ID.text.CIQALA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
