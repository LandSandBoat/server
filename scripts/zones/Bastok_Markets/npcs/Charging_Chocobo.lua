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
        { xi.item.BRONZE_SUBLIGAR,    208, 3 },
        { xi.item.SCALE_CUISSES,     1790, 3 },
        { xi.item.BRASS_CUISSES,    15456, 2 },
        { xi.item.CUISSES,          37800, 2 },
        { xi.item.MYTHRIL_CUISSES,  63238, 1 },
        { xi.item.BRONZE_LEGGINGS,    128, 3 },
        { xi.item.SCALE_GREAVES,     1085, 3 },
        { xi.item.BRASS_GREAVES,     9152, 2 },
        { xi.item.PLATE_LEGGINGS,   23760, 2 },
        { xi.item.MYTHRIL_LEGGINGS, 39550, 1 },
        { xi.item.GORGET,           18360, 2 },
        { xi.item.LEATHER_BELT,       425, 3 },
        { xi.item.SILVER_BELT,      11424, 3 },
        { xi.item.SWORDBELT,        21573, 1 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.CHARGINGCHOCOBO_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
