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
        { xi.item.BRONZE_KNUCKLES,  244, 3 },
        { xi.item.BRASS_KNUCKLES,   900, 3 },
        { xi.item.METAL_KNUCKLES,  5188, 1 },
        { xi.item.CESTI,            144, 3 },
        { xi.item.BRASS_BAGHNAKHS, 1690, 3 },
        { xi.item.CAT_BAGHNAKHS,    116, 3 },
        { xi.item.BRONZE_HAMMER,    340, 3 },
        { xi.item.BRASS_HAMMER,    2315, 3 },
        { xi.item.WARHAMMER,       6496, 1 },
        { xi.item.MAPLE_WAND,        51, 3 },
        { xi.item.ASH_CLUB,          71, 3 },
        { xi.item.BRONZE_ROD,       100, 3 },
        { xi.item.BRASS_ROD,        690, 3 },
        { xi.item.ASH_STAFF,         64, 3 },
        { xi.item.ASH_POLE,         420, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.CIQALA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
