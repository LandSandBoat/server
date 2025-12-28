-----------------------------------
-- Area: Lower Jeuno
--  NPC: Yoskolo
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_DISTILLED_WATER,       12 },
        { xi.item.BOTTLE_OF_ORANGE_JUICE,        200 },
        { xi.item.BOTTLE_OF_APPLE_JUICE,         300 },
        { xi.item.BOTTLE_OF_MELON_JUICE,        1100 },
        { xi.item.BOTTLE_OF_GRAPE_JUICE,         930 },
        { xi.item.BOTTLE_OF_PINEAPPLE_JUICE,     400 },
        { xi.item.SERVING_OF_ICECAP_ROLANBERRY, 5544 },
        { xi.item.SCROLL_OF_FIRE_CAROL,         6380 },
        { xi.item.SCROLL_OF_ICE_CAROL,          7440 },
        { xi.item.SCROLL_OF_WIND_CAROL,         5940 },
        { xi.item.SCROLL_OF_EARTH_CAROL,        4600 },
        { xi.item.SCROLL_OF_LIGHTNING_CAROL,    7920 },
        { xi.item.SCROLL_OF_WATER_CAROL,        5000 },
        { xi.item.SCROLL_OF_LIGHT_CAROL,        4200 },
        { xi.item.SCROLL_OF_DARK_CAROL,         8400 },
        { xi.item.SCROLL_OF_SENTINELS_SCHERZO, 60000 },
    }

    player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.YOSKOLO_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
