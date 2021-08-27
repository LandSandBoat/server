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
        4441, 837, 1,    --Grape Juice
        4356, 180, 2,    --White Bread
        4380, 198, 2,    --Smoked Salmon
        4423, 270, 2,    --Apple Juice
        4364, 108, 3,    --Black Bread
        4376, 108, 3,    --Meat Jerky
        4509,  10, 3,    --Distilled Water
        5007, 163, 3,    --Scroll of Sword Madrigal
    }

    player:showText(npc, ID.text.BONCORT_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
