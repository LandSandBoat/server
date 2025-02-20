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
        xi.item.LOAF_OF_BLACK_BREAD,       124, 3,
        xi.item.LOAF_OF_WHITE_BREAD,       208, 2,
        xi.item.BOWL_OF_PEBBLE_SOUP,       208, 3,
        xi.item.BOWL_OF_VEGETABLE_SOUP,   1566, 2,
        xi.item.BOWL_OF_MUSHROOM_SOUP,    7280, 1,
        xi.item.FLASK_OF_DISTILLED_WATER,   12, 3,
        xi.item.BOTTLE_OF_APPLE_JUICE,     312, 2,
        xi.item.BOTTLE_OF_GRAPE_JUICE,     967, 1,
        xi.item.BOILED_CRAYFISH,           416, 3,
        xi.item.ROAST_CARP,                540, 2,
        xi.item.ROAST_TROUT,               624, 1,
    }

    player:showText(npc, ID.text.CROUMANGUE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
