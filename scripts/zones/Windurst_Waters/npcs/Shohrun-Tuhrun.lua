-----------------------------------
-- Area: Windurst Waters
--  NPC: Shohrun-Tuhrun
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_CURE_III,       3624, 3 },
        { xi.item.SCROLL_OF_RAISE,          5754, 2 },
        { xi.item.SCROLL_OF_DIA_II,        11200, 2 },
        { xi.item.SCROLL_OF_BANISH_II,      9000, 2 },
        { xi.item.SCROLL_OF_PROTECT_II,     7074, 2 },
        { xi.item.SCROLL_OF_PROTECT_IV,   100000, 3 },
        { xi.item.SCROLL_OF_PROTECTRA_IV,  95000, 3 },
        { xi.item.SCROLL_OF_DISPEL,        77600, 3 },
        { xi.item.SCROLL_OF_SHELL_II,      17600, 2 },
        { xi.item.SCROLL_OF_HASTE,         20000, 1 },
        { xi.item.SCROLL_OF_ENFIRE,         5160, 2 },
        { xi.item.SCROLL_OF_ENBLIZZARD,     4098, 2 },
        { xi.item.SCROLL_OF_ENAERO,         2500, 2 },
        { xi.item.SCROLL_OF_ENSTONE,        2030, 2 },
        { xi.item.SCROLL_OF_ENTHUNDER,      1515, 2 },
        { xi.item.SCROLL_OF_ENWATER,        7074, 2 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.SHOHRUNTUHRUN_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
