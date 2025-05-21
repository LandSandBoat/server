-----------------------------------
-- Area: Selbina
--  NPC: Quelpia
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_CURE_II,      676 },
        { xi.item.SCROLL_OF_CURE_III,    3768 },
        { xi.item.SCROLL_OF_CURAGA_II,  11648 },
        { xi.item.SCROLL_OF_RAISE,       5984 },
        { xi.item.SCROLL_OF_HOLY,       36400 },
        { xi.item.SCROLL_OF_DIA_II,     11648 },
        { xi.item.SCROLL_OF_BANISH_II,   9360 },
        { xi.item.SCROLL_OF_PROTECT_II,  7356 },
        { xi.item.SCROLL_OF_SHELL_II,   18304 },
        { xi.item.SCROLL_OF_HASTE,      20800 },
        { xi.item.SCROLL_OF_ENFIRE,      5366 },
        { xi.item.SCROLL_OF_ENBLIZZARD,  4261 },
        { xi.item.SCROLL_OF_ENAERO,      2600 },
        { xi.item.SCROLL_OF_ENSTONE,     2111 },
        { xi.item.SCROLL_OF_ENTHUNDER,   1575 },
        { xi.item.SCROLL_OF_ENWATER,     7356 },
    }

    player:showText(npc, zones[xi.zone.SELBINA].text.QUELPIA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
