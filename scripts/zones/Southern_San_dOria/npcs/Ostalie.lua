-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ostalie
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LEATHER_BELT,          425, 3 },
        { xi.item.LIZARD_BELT,          2700, 3 },
        { xi.item.SILVER_BELT,         11172, 1 },
        { xi.item.CIRCLET,               160, 3 },
        { xi.item.ROBE,                  240, 3 },
        { xi.item.CUFFS,                 132, 3 },
        { xi.item.SLOPS,                 192, 3 },
        { xi.item.FLASK_OF_EYE_DROPS,   2595, 3 },
        { xi.item.ANTIDOTE,              316, 3 },
        { xi.item.FLASK_OF_ECHO_DROPS,   800, 2 },
        { xi.item.POTION,                910, 1 },
        { xi.item.ETHER,                4832, 1 },
        { xi.item.PICKAXE,               200, 3 },
        { xi.item.HATCHET,               500, 3 },
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
        (sandyNationRank == bastokNationRank and sandyNationRank == windyNationRank) or                       -- All 3 nations tied.
        (sandyNationRank ~= bastokNationRank and sandyNationRank ~= windyNationRank and sandyNationRank == 3) -- Nation not tied and nation last.
    then
        table.insert(stock, { xi.item.LIVING_KEY, 5308, 3 })
    end

    player:showText(npc, ID.text.OSTALIE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
