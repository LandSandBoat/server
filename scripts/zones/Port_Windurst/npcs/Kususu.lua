-----------------------------------
-- Area: Port Windurst
--  NPC: Kususu
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_CURE,        67, 3 },
        { xi.item.SCROLL_OF_CURE_II,    650, 2 },
        { xi.item.SCROLL_OF_CURAGA,    1515, 3 },
        { xi.item.SCROLL_OF_POISONA,    200, 3 },
        { xi.item.SCROLL_OF_PARALYNA,   360, 3 },
        { xi.item.SCROLL_OF_BLINDNA,   1100, 3 },
        { xi.item.SCROLL_OF_DIA,         92, 3 },
        { xi.item.SCROLL_OF_BANISH,     156, 2 },
        { xi.item.SCROLL_OF_DIAGA,     1295, 1 },
        { xi.item.SCROLL_OF_BANISHGA,  1295, 2 },
        { xi.item.SCROLL_OF_PROTECT,    244, 3 },
        { xi.item.SCROLL_OF_SHELL,     1760, 3 },
        { xi.item.SCROLL_OF_BLINK,     2330, 2 },
        { xi.item.SCROLL_OF_STONESKIN, 7806, 1 },
        { xi.item.SCROLL_OF_AQUAVEIL,   400, 3 },
        { xi.item.SCROLL_OF_SLOW,       930, 1 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.KUSUSU_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
