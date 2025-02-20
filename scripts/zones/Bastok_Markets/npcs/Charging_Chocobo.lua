-----------------------------------
-- Area: Bastok Markets
--  NPC: Charging Chocobo
-- !pos -301.531 -10.319 -157.237 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.BRONZE_SUBLIGAR,    216, 3,
        xi.item.SCALE_CUISSES,     1861, 3,
        xi.item.BRASS_CUISSES,    16074, 2,
        xi.item.CUISSES,          39312, 2,
        xi.item.MYTHRIL_CUISSES,  66399, 1,
        xi.item.BRONZE_LEGGINGS,    133, 3,
        xi.item.SCALE_GREAVES,     1128, 3,
        xi.item.BRASS_GREAVES,     9518, 2,
        xi.item.PLATE_LEGGINGS,   24710, 2,
        xi.item.MYTHRIL_LEGGINGS, 41527, 1,
        xi.item.GORGET,           19094, 2,
        xi.item.LEATHER_BELT,       442, 3,
        xi.item.SILVER_BELT,      11880, 3,
        xi.item.SWORDBELT,        22651, 1,
    }

    player:showText(npc, ID.text.CHARGINGCHOCOBO_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
