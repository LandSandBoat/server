-----------------------------------
-- Area: Southern San dOria
--  NPC: Shilah
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.LOAF_OF_BLACK_BREAD,         124, 3,
        xi.item.LOAF_OF_WHITE_BREAD,         208, 2,
        xi.item.BOWL_OF_PULS,                624, 3,
        xi.item.BOWL_OF_DELICIOUS_PULS,     1248, 2,
        xi.item.PLATE_OF_MUSHROOM_RISOTTO,  5200, 1,
        xi.item.BOWL_OF_PEBBLE_SOUP,         208, 3,
        xi.item.BOWL_OF_VEGETABLE_SOUP,     1566, 2,
        xi.item.BOWL_OF_MUSHROOM_SOUP,      7280, 1,
        xi.item.SERVING_OF_BEAUGREEN_SAUTE, 1887, 2,
        xi.item.FLASK_OF_DISTILLED_WATER,     12, 3,
        xi.item.BOTTLE_OF_GRAPE_JUICE,       967, 2,
        xi.item.POT_OF_SAN_DORIAN_TEA,      2882, 1,
        xi.item.BUNCH_OF_ROYAL_GRAPES,      1456, 3,
    }

    player:showText(npc, ID.text.SHILAH_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
