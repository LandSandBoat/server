-----------------------------------
-- Area: Selbina
--  NPC: Quelpia
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_CURE_II,      650 },
        { xi.item.SCROLL_OF_CURE_III,    3624 },
        { xi.item.SCROLL_OF_CURAGA_II,  11200 },
        { xi.item.SCROLL_OF_RAISE,       5754 },
        { xi.item.SCROLL_OF_HOLY,       35000 },
        { xi.item.SCROLL_OF_DIA_II,     11200 },
        { xi.item.SCROLL_OF_BANISH_II,   9000 },
        { xi.item.SCROLL_OF_PROTECT_II,  7074 },
        { xi.item.SCROLL_OF_SHELL_II,   17600 },
        { xi.item.SCROLL_OF_HASTE,      20000 },
        { xi.item.SCROLL_OF_ENFIRE,      5160 },
        { xi.item.SCROLL_OF_ENBLIZZARD,  4098 },
        { xi.item.SCROLL_OF_ENAERO,      2500 },
        { xi.item.SCROLL_OF_ENSTONE,     2030 },
        { xi.item.SCROLL_OF_ENTHUNDER,   1515 },
        { xi.item.SCROLL_OF_ENWATER,     7074 },
    }

    player:showText(npc, zones[xi.zone.SELBINA].text.QUELPIA_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.SELBINA_RABAO)
end

return entity
