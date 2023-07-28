-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Boncort
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/quests/flyers_for_regine")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 7) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.LOAF_OF_BLACK_BREAD,      124, 3,
        xi.items.LOAF_OF_WHITE_BREAD,      208, 2,
        xi.items.STRIP_OF_MEAT_JERKY,      124, 3,
        xi.items.SMOKED_SALMON,            228, 2,
        xi.items.FLASK_OF_DISTILLED_WATER,  12, 3,
        xi.items.BOTTLE_OF_GRAPE_JUICE,    967, 1,
        xi.items.BOTTLE_OF_APPLE_JUICE,    312, 2,
        xi.items.SCROLL_OF_SWORD_MADRIGAL, 189, 3,
    }

    player:showText(npc, ID.text.BONCORT_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
