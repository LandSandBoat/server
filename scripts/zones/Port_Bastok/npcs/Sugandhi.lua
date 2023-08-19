-----------------------------------
-- Area: Port Bastok
--  NPC: Sugandhi
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.BRONZE_KNIFE,    170, 3,
        xi.items.KNIFE,          2522, 2,
        xi.items.KUKRI,          6458, 1,
        xi.items.CAT_BAGHNAKHS,   120, 3,
        xi.items.BRONZE_SWORD,    278, 3,
        xi.items.IRON_SWORD,     8236, 3,
        xi.items.MYTHRIL_SWORD, 35776, 2,
        xi.items.BROADSWORD,    24344, 1,
        xi.items.DEGEN,         10632, 3,
        xi.items.TUCK,          13391, 1,
        xi.items.SAPARA,          807, 3,
        xi.items.SCIMITAR,       4706, 2,
        xi.items.FALCHION,      70720, 1,
    }

    player:showText(npc, ID.text.SUGANDHI_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
