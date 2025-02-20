-----------------------------------
-- Area: Bastok Mines
--  NPC: Griselda
-- !pos -25.749 -0.044 52.360 234
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.LOAF_OF_IRON_BREAD,         104, 3,
        xi.item.BRETZEL,                     24, 2,
        xi.item.STRIP_OF_MEAT_JERKY,        124, 3,
        xi.item.PICKLED_HERRING,            499, 2,
        xi.item.FLASK_OF_DISTILLED_WATER,    12, 3,
        xi.item.BOTTLE_OF_PINEAPPLE_JUICE,  416, 1,
        xi.item.BOTTLE_OF_MELON_JUICE,     1144, 2,
    }

    player:showText(npc, ID.text.GRISELDA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
