-----------------------------------
-- Area: Bastok Markets
--  NPC: Charging Chocobo
-- Standard Merchant NPC
-- !pos -301.531 -10.319 -157.237 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.BRONZE_SUBLIGAR,    216, 3,
        xi.items.SCALE_CUISSES,     1861, 3,
        xi.items.BRASS_CUISSES,    16074, 2,
        xi.items.CUISSES,          39312, 2,
        xi.items.MYTHRIL_CUISSES,  66399, 1,
        xi.items.BRONZE_LEGGINGS,    133, 3,
        xi.items.SCALE_GREAVES,     1128, 3,
        xi.items.BRASS_GREAVES,     9518, 2,
        xi.items.PLATE_LEGGINGS,   24710, 2,
        xi.items.MYTHRIL_LEGGINGS, 41527, 1,
        xi.items.GORGET,           19094, 2,
        xi.items.LEATHER_BELT,       442, 3,
        xi.items.SILVER_BELT,      11880, 3,
        xi.items.SWORDBELT,        22651, 1,
    }

    player:showText(npc, ID.text.CHARGINGCHOCOBO_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
