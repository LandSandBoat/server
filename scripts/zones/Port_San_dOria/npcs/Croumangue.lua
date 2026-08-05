-----------------------------------
-- Area: Port San d'Oria
--  NPC: Croumangue
-----------------------------------
local ID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LOAF_OF_BLACK_BREAD,       120, 3, },
        { xi.item.LOAF_OF_WHITE_BREAD,       200, 2, },
        { xi.item.BOWL_OF_PEBBLE_SOUP,       200, 3, },
        { xi.item.BOWL_OF_VEGETABLE_SOUP,   1506, 2, },
        { xi.item.BOWL_OF_MUSHROOM_SOUP,    7000, 1, },
        { xi.item.FLASK_OF_DISTILLED_WATER,   12, 3, },
        { xi.item.BOTTLE_OF_APPLE_JUICE,     300, 2, },
        { xi.item.BOTTLE_OF_GRAPE_JUICE,     930, 1, },
        { xi.item.BOILED_CRAYFISH,           400, 3, },
        { xi.item.ROAST_CARP,                520, 2, },
        { xi.item.ROAST_TROUT,               600, 1, },
    }

    player:showText(npc, ID.text.CROUMANGUE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
