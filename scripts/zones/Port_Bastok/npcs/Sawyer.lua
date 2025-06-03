-----------------------------------
-- Area: Port Bastok
--  NPC: Sawyer
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LOAF_OF_IRON_BREAD,         105, 3 },
        { xi.item.BRETZEL,                     25, 2 },
        { xi.item.LOAF_OF_PUMPERNICKEL,       166, 1 },
        { xi.item.BAKED_POPOTO,               336, 3 },
        { xi.item.SAUSAGE,                    163, 2 },
        { xi.item.BOWL_OF_PEBBLE_SOUP,        210, 3 },
        { xi.item.BOWL_OF_EGG_SOUP,          3432, 1 },
        { xi.item.FLASK_OF_DISTILLED_WATER,    12, 3 },
        { xi.item.BOTTLE_OF_MELON_JUICE,     1155, 2 },
        { xi.item.BOTTLE_OF_PINEAPPLE_JUICE,  416, 1 },
        { xi.item.SLICE_OF_ROAST_MUTTON,      756, 2 },
    }

    player:showText(npc, zones[xi.zone.PORT_BASTOK].text.SAWYER_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
