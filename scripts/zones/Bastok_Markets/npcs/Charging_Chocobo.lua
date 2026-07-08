-----------------------------------
-- Area: Bastok Markets
--  NPC: Charging Chocobo
-- !pos -301.531 -10.319 -157.237 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BRONZE_SUBLIGAR,    218, 3 },
        { xi.item.SCALE_CUISSES,     1879, 3 },
        { xi.item.BRASS_CUISSES,    16228, 2 },
        { xi.item.CUISSES,          39690, 2 },
        { xi.item.MYTHRIL_CUISSES,  66399, 1 },
        { xi.item.BRONZE_LEGGINGS,    134, 3 },
        { xi.item.SCALE_GREAVES,     1139, 3 },
        { xi.item.BRASS_GREAVES,     9609, 2 },
        { xi.item.PLATE_LEGGINGS,   24948, 2 },
        { xi.item.MYTHRIL_LEGGINGS, 41527, 1 },
        { xi.item.GORGET,           19278, 2 },
        { xi.item.LEATHER_BELT,       446, 3 },
        { xi.item.SILVER_BELT,      11995, 3 },
        { xi.item.SWORDBELT,        22651, 1 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.CHARGINGCHOCOBO_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
