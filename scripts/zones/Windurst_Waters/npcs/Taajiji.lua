-----------------------------------
-- Area: Windurst Waters
--  NPC: Taajiji
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.TORTILLA,                        140, 3 },
        { xi.item.MUTTON_TORTILLA,                5670, 2 },
        { xi.item.DHALMEL_PIE,                     840, 1 },
        { xi.item.BOWL_OF_PULS,                    600, 3 },
        { xi.item.PLATE_OF_MUSHROOM_RISOTTO,      5000, 1 },
        { xi.item.BOWL_OF_DHALMEL_STEW,           2595, 3 },
        { xi.item.BOWL_OF_WHITEFISH_STEW,         6592, 2 },
        { xi.item.SERVING_OF_SHALLOPS_TROPICALE, 12636, 1 },
        { xi.item.SERVING_OF_BEAUGREEN_SAUTE,     1815, 2 },
        { xi.item.FLASK_OF_DISTILLED_WATER,         12, 3 },
        { xi.item.BOTTLE_OF_ORANGE_JUICE,          200, 2 },
        { xi.item.CUP_OF_WINDURSTIAN_TEA,          200, 3 },
        { xi.item.ORANGE_KUCHEN,                  975, 1 },
        { xi.item.DHALMEL_STEAK,                  1440, 2 },
        { xi.item.WINDURST_SALAD,                 1860, 3 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.TAAJIJI_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
