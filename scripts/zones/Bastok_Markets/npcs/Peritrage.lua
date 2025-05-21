-----------------------------------
-- Area: Bastok Markets
--  NPC: Peritrage
-- !pos -286.985 -10.319 -142.586 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BRONZE_AXE,      331, 3 },
        { xi.item.BRASS_AXE,      1638, 3 },
        { xi.item.BATTLEAXE,     12757, 1 },
        { xi.item.BUTTERFLY_AXE,   705, 3 },
        { xi.item.GREATAXE,       4777, 3 },
        { xi.item.BRONZE_KNIFE,    172, 3 },
        { xi.item.KNIFE,          2546, 3 },
        { xi.item.KUKRI,          6458, 1 },
        { xi.item.BRONZE_DAGGER,   163, 3 },
        { xi.item.BRASS_DAGGER,    976, 3 },
        { xi.item.DAGGER,         2131, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.PERITRAGE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
