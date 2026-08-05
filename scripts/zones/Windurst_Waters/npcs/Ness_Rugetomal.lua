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
        { xi.item.CINNA_COOKIE,               15, 2 },
        { xi.item.GINGER_COOKIE,              12, 1 },
        { xi.item.STRIP_OF_MEAT_JERKY,       120, 3 },
        { xi.item.CARP_SUSHI,                720, 1 },
        { xi.item.FLASK_OF_DISTILLED_WATER,   12, 3 },
        { xi.item.BOTTLE_OF_ORANGE_JUICE,    200, 2 },
        { xi.item.BOTTLE_OF_TOMATO_JUICE,    320, 1 },
        { xi.item.ROAST_PIPIRA,              920, 3 },
        { xi.item.BOILED_CRAB,              2250, 2 },
        { xi.item.NEBIMONITE_BAKE,          1800, 1 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.NESSRUGETOMALL_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
