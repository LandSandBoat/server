-----------------------------------
-- Area: Upper Jeuno
--  NPC: Glyke
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LOAF_OF_IRON_BREAD,         100 },
        { xi.item.TORTILLA,                   140 },
        { xi.item.LOAF_OF_WHITE_BREAD,        200 },
        { xi.item.BOWL_OF_PEA_SOUP,          1400 },
        { xi.item.BOILED_CRAB,               2250 },
        { xi.item.SLICE_OF_ROAST_MUTTON,      720 },
        { xi.item.BAKED_APPLE,                440 },
        { xi.item.WINDURST_SALAD,            1860 },
        { xi.item.SERVING_OF_HERB_QUUS,      4984 },
        { xi.item.BOTTLE_OF_ORANGE_JUICE,     200 },
        { xi.item.BOTTLE_OF_APPLE_JUICE,      300 },
        { xi.item.BOTTLE_OF_PINEAPPLE_JUICE,  400 },
        { xi.item.BOTTLE_OF_MELON_JUICE,     1100 },
        { xi.item.BOTTLE_OF_GRAPE_JUICE,      930 },
    }

    player:showText(npc, zones[xi.zone.UPPER_JEUNO].text.GLYKE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
