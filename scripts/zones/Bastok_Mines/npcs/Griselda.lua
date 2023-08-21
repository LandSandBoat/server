-----------------------------------
-- Area: Bastok Mines
--  NPC: Griselda
-- Standard Merchant NPC
-- !pos -25.749 -0.044 52.360 234
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.LOAF_OF_IRON_BREAD,         104, 3,
        xi.items.BRETZEL,                     24, 2,
        xi.items.STRIP_OF_MEAT_JERKY,        124, 3,
        xi.items.PICKLED_HERRING,            499, 2,
        xi.items.FLASK_OF_DISTILLED_WATER,    12, 3,
        xi.items.BOTTLE_OF_PINEAPPLE_JUICE,  416, 1,
        xi.items.BOTTLE_OF_MELON_JUICE,     1144, 2,
    }

    player:showText(npc, ID.text.GRISELDA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
