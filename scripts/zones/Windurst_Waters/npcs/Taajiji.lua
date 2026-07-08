-----------------------------------
-- Area: Windurst Waters
--  NPC: Taajiji
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.TORTILLA,                        145, 3 },
        { xi.item.MUTTON_TORTILLA,                5896, 2 },
        { xi.item.DHALMEL_PIE,                     873, 1 },
        { xi.item.BOWL_OF_PULS,                    624, 3 },
        { xi.item.PLATE_OF_MUSHROOM_RISOTTO,      5200, 1 },
        { xi.item.BOWL_OF_DHALMEL_STEW,           2698, 3 },
        { xi.item.BOWL_OF_WHITEFISH_STEW,         6855, 2 },
        { xi.item.SERVING_OF_SHALLOPS_TROPICALE, 13141, 1 },
        { xi.item.SERVING_OF_BEAUGREEN_SAUTE,     1887, 2 },
        { xi.item.FLASK_OF_DISTILLED_WATER,         12, 3 },
        { xi.item.BOTTLE_OF_ORANGE_JUICE,          208, 2 },
        { xi.item.CUP_OF_WINDURSTIAN_TEA,          208, 3 },
        { xi.item.ORANGE_KUCHEN,                  1014, 1 },
        { xi.item.DHALMEL_STEAK,                  1497, 2 },
        { xi.item.WINDURST_SALAD,                 1934, 3 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.TAAJIJI_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
