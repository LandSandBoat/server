-----------------------------------
-- Area: Bastok Markets
--  NPC: Peritrage
-- Standard Merchant NPC
-- !pos -286.985 -10.319 -142.586 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.BRONZE_AXE,      328, 3,
        xi.items.BRASS_AXE,      1622, 3,
        xi.items.BATTLEAXE,     12757, 1,
        xi.items.BUTTERFLY_AXE,   698, 3,
        xi.items.GREATAXE,       4732, 3,
        xi.items.BRONZE_KNIFE,    170, 3,
        xi.items.KNIFE,          2522, 3,
        xi.items.KUKRI,          6458, 1,
        xi.items.BRONZE_DAGGER,   162, 3,
        xi.items.BRASS_DAGGER,    967, 3,
        xi.items.DAGGER,         2111, 3,
    }

    player:showText(npc, ID.text.PERITRAGE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
