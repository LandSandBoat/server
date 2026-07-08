-----------------------------------
-- Area: Port Windurst
--  NPC: Kususu
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_CURE,        70, 3 },
        { xi.item.SCROLL_OF_CURE_II,    676, 2 },
        { xi.item.SCROLL_OF_CURAGA,    1575, 3 },
        { xi.item.SCROLL_OF_POISONA,    208, 3 },
        { xi.item.SCROLL_OF_PARALYNA,   374, 3 },
        { xi.item.SCROLL_OF_BLINDNA,   1144, 3 },
        { xi.item.SCROLL_OF_DIA,         95, 3 },
        { xi.item.SCROLL_OF_BANISH,     162, 2 },
        { xi.item.SCROLL_OF_DIAGA,     1346, 1 },
        { xi.item.SCROLL_OF_BANISHGA,  1346, 2 },
        { xi.item.SCROLL_OF_PROTECT,    253, 3 },
        { xi.item.SCROLL_OF_SHELL,     1830, 3 },
        { xi.item.SCROLL_OF_BLINK,     2423, 2 },
        { xi.item.SCROLL_OF_STONESKIN, 8118, 1 },
        { xi.item.SCROLL_OF_AQUAVEIL,   416, 3 },
        { xi.item.SCROLL_OF_SLOW,       967, 1 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.KUSUSU_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
