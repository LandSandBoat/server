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
        { xi.item.EARTHEN_FLOWERPOT,        1040, 3 },
        { xi.item.TARUTARU_STOOL,           1023, 3 },
        { xi.item.YELLOW_JAR,                515, 2 },
        { xi.item.TARUTARU_FOLDING_SCREEN,  3996, 1 },
        { xi.item.WOODEN_ARROW,                4, 2 },
        { xi.item.BONE_ARROW,                  5, 3 },
        { xi.item.CROSSBOW_BOLT,               6, 2 },
        { xi.item.SCROLL_OF_EARTH_THRENODY,  320, 3 },
        { xi.item.SCROLL_OF_FIRE_THRENODY,   728, 3 },
        { xi.item.WHITE_JAR,                5397, 3 },
        { xi.item.BUNDLE_OF_RIVER_FOLIAGE,   665, 3 },
        { xi.item.BUNDLE_OF_SEA_FOLIAGE,     665, 3 },
        { xi.item.LUGWORM,                    12, 3 },
        { xi.item.LITTLE_WORM,                 4, 3 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.ENSASA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
