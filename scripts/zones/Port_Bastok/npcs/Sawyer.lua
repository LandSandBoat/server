-----------------------------------
-- Area: Port Bastok
--  NPC: Sawyer
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.LOAF_OF_IRON_BREAD,         104, 3,
        xi.item.BRETZEL,                     24, 2,
        xi.item.LOAF_OF_PUMPERNICKEL,       166, 1,
        xi.item.BAKED_POPOTO,               332, 3,
        xi.item.SAUSAGE,                    162, 2,
        xi.item.BOWL_OF_PEBBLE_SOUP,        208, 3,
        xi.item.BOWL_OF_EGG_SOUP,          3432, 1,
        xi.item.FLASK_OF_DISTILLED_WATER,    12, 3,
        xi.item.BOTTLE_OF_MELON_JUICE,     1144, 2,
        xi.item.BOTTLE_OF_PINEAPPLE_JUICE,  416, 1,
        xi.item.SLICE_OF_ROAST_MUTTON,      748, 2,
    }

    player:showText(npc, ID.text.SAWYER_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
