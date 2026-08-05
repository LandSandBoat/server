-----------------------------------
-- Area: Port Bastok
--  NPC: Sawyer
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LOAF_OF_IRON_BREAD,         100, 3 },
        { xi.item.BRETZEL,                     25, 2 },
        { xi.item.LOAF_OF_PUMPERNICKEL,       159, 1 },
        { xi.item.BAKED_POPOTO,               320, 3 },
        { xi.item.SAUSAGE,                    156, 2 },
        { xi.item.BOWL_OF_PEBBLE_SOUP,        200, 3 },
        { xi.item.BOWL_OF_EGG_SOUP,          3269, 1 },
        { xi.item.FLASK_OF_DISTILLED_WATER,    12, 3 },
        { xi.item.BOTTLE_OF_MELON_JUICE,     1100, 2 },
        { xi.item.BOTTLE_OF_PINEAPPLE_JUICE,  397, 1 },
        { xi.item.SLICE_OF_ROAST_MUTTON,      720, 2 },
    }

    player:showText(npc, zones[xi.zone.PORT_BASTOK].text.SAWYER_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
