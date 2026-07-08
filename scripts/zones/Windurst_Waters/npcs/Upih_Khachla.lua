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
        { xi.item.PINCH_OF_DRIED_MARJORAM,   49, 3 },
        { xi.item.CHAMOMILE,                135, 2 },
        { xi.item.WIJNRUIT,                 124, 1 },
        { xi.item.FLASK_OF_EYE_DROPS,      2698, 3 },
        { xi.item.ANTIDOTE,                 328, 3 },
        { xi.item.FLASK_OF_ECHO_DROPS,      832, 2 },
        { xi.item.POTION,                   946, 1 },
        { xi.item.ETHER,                   5025, 2 },
        { xi.item.GRENADE,                 1252, 1 },
        { xi.item.PINCH_OF_TWINKLE_POWDER,  400, 3 },
        { xi.item.ONZ_OF_DESALINATOR,      4576, 3 },
        { xi.item.ONZ_OF_SALINATOR,        4576, 3 },
        { xi.item.PICKAXE,                  208, 3 },
        { xi.item.SICKLE,                   312, 3 },
    }

    -- Thief's tools.
    if GetNationRank(player:getNation()) >= 2 then -- Player nation rank 2 or 3.
        table.insert(stock, { xi.item.SET_OF_THIEFS_TOOLS, 4158, 3 })
    end

    -- Living Key.
    local sandyNationRank  = GetNationRank(xi.nation.SANDORIA)
    local bastokNationRank = GetNationRank(xi.nation.BASTOK)
    local windyNationRank  = GetNationRank(xi.nation.WINDURST)
    if
        (windyNationRank == sandyNationRank and windyNationRank == bastokNationRank) or                       -- All 3 nations tied.
        (windyNationRank ~= sandyNationRank and windyNationRank ~= bastokNationRank and windyNationRank == 3) -- Nation not tied and nation last.
    then
        table.insert(stock, { xi.item.LIVING_KEY, 5520, 3 })
    end

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.UPIHKHACHLA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
