-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Boncort
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
require('scripts/quests/flyers_for_regine')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 7) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LOAF_OF_BLACK_BREAD,      120, 3, },
        { xi.item.LOAF_OF_WHITE_BREAD,      200, 2, },
        { xi.item.STRIP_OF_MEAT_JERKY,      120, 3, },
        { xi.item.SMOKED_SALMON,            220, 2, },
        { xi.item.FLASK_OF_DISTILLED_WATER,  12, 3, },
        { xi.item.BOTTLE_OF_GRAPE_JUICE,    930, 1, },
        { xi.item.BOTTLE_OF_APPLE_JUICE,    300, 2, },
        { xi.item.SCROLL_OF_SWORD_MADRIGAL, 182, 3, },
    }

    player:showText(npc, ID.text.BONCORT_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
