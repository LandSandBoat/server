-----------------------------------
-- Area: Windurst Waters
--  NPC: Shohrun-Tuhrun
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_CURE_III,       3768, 3 },
        { xi.item.SCROLL_OF_RAISE,          5984, 2 },
        { xi.item.SCROLL_OF_DIA_II,        11648, 2 },
        { xi.item.SCROLL_OF_BANISH_II,      9360, 2 },
        { xi.item.SCROLL_OF_PROTECT_II,     7356, 2 },
        { xi.item.SCROLL_OF_PROTECT_IV,   104000, 3 },
        { xi.item.SCROLL_OF_PROTECTRA_IV,  98800, 3 },
        { xi.item.SCROLL_OF_DISPEL,        80704, 3 },
        { xi.item.SCROLL_OF_SHELL_II,      18304, 2 },
        { xi.item.SCROLL_OF_HASTE,         20800, 1 },
        { xi.item.SCROLL_OF_ENFIRE,         5366, 2 },
        { xi.item.SCROLL_OF_ENBLIZZARD,     4261, 2 },
        { xi.item.SCROLL_OF_ENAERO,         2600, 2 },
        { xi.item.SCROLL_OF_ENSTONE,        2111, 2 },
        { xi.item.SCROLL_OF_ENTHUNDER,      1575, 2 },
        { xi.item.SCROLL_OF_ENWATER,        7356, 2 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.SHOHRUNTUHRUN_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
