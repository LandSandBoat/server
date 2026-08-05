-----------------------------------
-- Area: Bastok Mines
--  NPC: Griselda
-- !pos -25.749 -0.044 52.360 234
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LOAF_OF_IRON_BREAD,         100, 3 },
        { xi.item.BRETZEL,                     25, 2 },
        { xi.item.STRIP_OF_MEAT_JERKY,        120, 3 },
        { xi.item.PICKLED_HERRING,            480, 2 },
        { xi.item.FLASK_OF_DISTILLED_WATER,    12, 3 },
        { xi.item.BOTTLE_OF_PINEAPPLE_JUICE,  397, 1 },
        { xi.item.BOTTLE_OF_MELON_JUICE,     1100, 2 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MINES].text.GRISELDA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
