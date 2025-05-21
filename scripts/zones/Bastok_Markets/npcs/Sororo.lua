-----------------------------------
-- Area: Bastok Markets
--  NPC: Sororo
-- !pos -220.217 -2.824 51.542 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_CURE,         71, 3 },
        { xi.item.SCROLL_OF_CURE_II,     682, 2 },
        { xi.item.SCROLL_OF_CURAGA,     1590, 3 },
        { xi.item.SCROLL_OF_POISONA,     210, 3 },
        { xi.item.SCROLL_OF_PARALYNA,    378, 3 },
        { xi.item.SCROLL_OF_BLINDNA,    1155, 3 },
        { xi.item.SCROLL_OF_DIA,          96, 3 },
        { xi.item.SCROLL_OF_BANISH,      163, 2 },
        { xi.item.SCROLL_OF_DIAGA,      1359, 1 },
        { xi.item.SCROLL_OF_BANISHGA,   1359, 2 },
        { xi.item.SCROLL_OF_PROTECT,     256, 3 },
        { xi.item.SCROLL_OF_SHELL,      1848, 3 },
        { xi.item.SCROLL_OF_BLINK,      2446, 2 },
        { xi.item.SCROLL_OF_STONESKIN,  8118, 1 },
        { xi.item.SCROLL_OF_REPOSE,    34650, 3 },
        { xi.item.SCROLL_OF_SLOW,        967, 1 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.SORORO_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
