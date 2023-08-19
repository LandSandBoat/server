-----------------------------------
-- Area: Port Bastok
--  NPC: Sawyer
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.LOAF_OF_IRON_BREAD,         104, 3,
        xi.items.BRETZEL,                     24, 2,
        xi.items.LOAF_OF_PUMPERNICKEL,       166, 1,
        xi.items.BAKED_POPOTO,               332, 3,
        xi.items.SAUSAGE,                    162, 2,
        xi.items.BOWL_OF_PEBBLE_SOUP,        208, 3,
        xi.items.BOWL_OF_EGG_SOUP,          3432, 1,
        xi.items.FLASK_OF_DISTILLED_WATER,    12, 3,
        xi.items.BOTTLE_OF_MELON_JUICE,     1144, 2,
        xi.items.BOTTLE_OF_PINEAPPLE_JUICE,  416, 1,
        xi.items.SLICE_OF_ROAST_MUTTON,      748, 2,
    }

    player:showText(npc, ID.text.SAWYER_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
