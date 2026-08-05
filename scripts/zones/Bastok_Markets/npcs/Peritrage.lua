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
        { xi.item.BRONZE_AXE,      316, 3 },
        { xi.item.BRASS_AXE,      1560, 3 },
        { xi.item.BATTLEAXE,     12150, 1 },
        { xi.item.BUTTERFLY_AXE,   672, 3 },
        { xi.item.GREATAXE,       4550, 3 },
        { xi.item.BRONZE_KNIFE,    164, 3 },
        { xi.item.KNIFE,          2425, 3 },
        { xi.item.KUKRI,          6151, 1 },
        { xi.item.BRONZE_DAGGER,   156, 3 },
        { xi.item.BRASS_DAGGER,    930, 3 },
        { xi.item.DAGGER,         2030, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.PERITRAGE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
