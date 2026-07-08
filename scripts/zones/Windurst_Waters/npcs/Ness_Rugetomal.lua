-----------------------------------
-- Area: Windurst Waters
--  NPC: Ness Rugetomal
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.ACORN_COOKIE,               24, 3 },
        { xi.item.CINNA_COOKIE,               16, 2 },
        { xi.item.GINGER_COOKIE,              12, 1 },
        { xi.item.STRIP_OF_MEAT_JERKY,       124, 3 },
        { xi.item.CARP_SUSHI,                748, 1 },
        { xi.item.FLASK_OF_DISTILLED_WATER,   12, 3 },
        { xi.item.BOTTLE_OF_ORANGE_JUICE,    208, 2 },
        { xi.item.BOTTLE_OF_TOMATO_JUICE,    332, 1 },
        { xi.item.ROAST_PIPIRA,              956, 3 },
        { xi.item.BOILED_CRAB,              2340, 2 },
        { xi.item.NEBIMONITE_BAKE,          1872, 1 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.NESSRUGETOMALL_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
