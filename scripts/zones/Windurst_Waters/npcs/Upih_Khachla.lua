-----------------------------------
-- Area: Windurst Waters
--  NPC: Upih Khachla
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.PINCH_OF_DRIED_MARJORAM,   48, 3 },
        { xi.item.CHAMOMILE,                130, 2 },
        { xi.item.WIJNRUIT,                 120, 1 },
        { xi.item.FLASK_OF_EYE_DROPS,      2595, 3 },
        { xi.item.ANTIDOTE,                 316, 3 },
        { xi.item.FLASK_OF_ECHO_DROPS,      800, 2 },
        { xi.item.POTION,                   910, 1 },
        { xi.item.ETHER,                   4832, 2 },
        { xi.item.GRENADE,                 1204, 1 },
        { xi.item.PINCH_OF_TWINKLE_POWDER,  385, 3 },
        { xi.item.ONZ_OF_DESALINATOR,      4400, 3 },
        { xi.item.ONZ_OF_SALINATOR,        4400, 3 },
        { xi.item.PICKAXE,                  200, 3 },
        { xi.item.SICKLE,                   300, 3 },
    }

    -- Thief's tools.
    if GetNationRank(player:getNation()) >= 2 then -- Player nation rank 2 or 3.
        table.insert(stock, { xi.item.SET_OF_THIEFS_TOOLS, 3999, 3 })
    end

    -- Living Key.
    local sandyNationRank  = GetNationRank(xi.nation.SANDORIA)
    local bastokNationRank = GetNationRank(xi.nation.BASTOK)
    local windyNationRank  = GetNationRank(xi.nation.WINDURST)
    if
        (windyNationRank == sandyNationRank and windyNationRank == bastokNationRank) or                       -- All 3 nations tied.
        (windyNationRank ~= sandyNationRank and windyNationRank ~= bastokNationRank and windyNationRank == 3) -- Nation not tied and nation last.
    then
        table.insert(stock, { xi.item.LIVING_KEY, 5308, 3 })
    end

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.UPIHKHACHLA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
