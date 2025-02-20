-----------------------------------
-- Area: Bastok Markets
--  NPC: Peritrage
-- !pos -286.985 -10.319 -142.586 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.BRONZE_AXE,      328, 3,
        xi.item.BRASS_AXE,      1622, 3,
        xi.item.BATTLEAXE,     12757, 1,
        xi.item.BUTTERFLY_AXE,   698, 3,
        xi.item.GREATAXE,       4732, 3,
        xi.item.BRONZE_KNIFE,    170, 3,
        xi.item.KNIFE,          2522, 3,
        xi.item.KUKRI,          6458, 1,
        xi.item.BRONZE_DAGGER,   162, 3,
        xi.item.BRASS_DAGGER,    967, 3,
        xi.item.DAGGER,         2111, 3,
    }

    player:showText(npc, ID.text.PERITRAGE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
