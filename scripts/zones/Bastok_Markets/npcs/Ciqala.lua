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
        xi.items.BRONZE_KNUCKLES,  253, 3,
        xi.items.BRASS_KNUCKLES,   936, 3,
        xi.items.METAL_KNUCKLES,  5447, 1,
        xi.items.CESTI,            149, 3,
        xi.items.BRASS_BAGHNAKHS, 1757, 3,
        xi.items.CAT_BAGHNAKHS,    120, 3,
        xi.items.BRONZE_HAMMER,    353, 3,
        xi.items.BRASS_HAMMER,    2407, 3,
        xi.items.WARHAMMER,       6820, 1,
        xi.items.MAPLE_WAND,        54, 3,
        xi.items.ASH_CLUB,          74, 3,
        xi.items.BRONZE_ROD,       104, 3,
        xi.items.BRASS_ROD,        717, 3,
        xi.items.ASH_STAFF,         66, 3,
        xi.items.ASH_POLE,         436, 3,
    }

    player:showText(npc, ID.text.CIQALA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
