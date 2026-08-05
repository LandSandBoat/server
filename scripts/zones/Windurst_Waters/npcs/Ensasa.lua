-----------------------------------
-- Area: Windurst Waters
--  NPC: Ensasa
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.EARTHEN_FLOWERPOT,        1000, 3 },
        { xi.item.TARUTARU_STOOL,           984, 3 },
        { xi.item.YELLOW_JAR,                496, 2 },
        { xi.item.TARUTARU_FOLDING_SCREEN,  3843, 1 },
        { xi.item.WOODEN_ARROW,                4, 2 },
        { xi.item.BONE_ARROW,                  5, 3 },
        { xi.item.CROSSBOW_BOLT,               6, 2 },
        { xi.item.SCROLL_OF_EARTH_THRENODY,  308, 3 },
        { xi.item.SCROLL_OF_FIRE_THRENODY,   700, 3 },
        { xi.item.WHITE_JAR,                5190, 3 },
        { xi.item.BUNDLE_OF_RIVER_FOLIAGE,   640, 3 },
        { xi.item.BUNDLE_OF_SEA_FOLIAGE,     640, 3 },
        { xi.item.LUGWORM,                    12, 3 },
        { xi.item.LITTLE_WORM,                 4, 3 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.ENSASA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
