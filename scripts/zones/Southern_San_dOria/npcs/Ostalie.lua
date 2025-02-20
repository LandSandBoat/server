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
        xi.item.LEATHER_BELT,          442, 3,
        xi.item.LIZARD_BELT,          2808, 3,
        xi.item.SILVER_BELT,         11618, 1,
        xi.item.CIRCLET,               166, 3,
        xi.item.ROBE,                  249, 3,
        xi.item.CUFFS,                 137, 3,
        xi.item.SLOPS,                 199, 3,
        xi.item.FLASK_OF_EYE_DROPS,   2698, 3,
        xi.item.ANTIDOTE,              328, 3,
        xi.item.FLASK_OF_ECHO_DROPS,   832, 2,
        xi.item.POTION,                946, 1,
        xi.item.ETHER,                5025, 1,
        xi.item.PICKAXE,               208, 3,
        xi.item.HATCHET,               520, 3,
    }

    local rank = GetNationRank(xi.nation.SANDORIA)

    -- TODO: Check
    if rank ~= 1 then
        table.insert(stock, 1022)    -- Thief's Tools
        table.insert(stock, 3643)
        table.insert(stock, 3)
    elseif rank == 3 then
        table.insert(stock, 1023)    -- Living Key
        table.insert(stock, 5520)
        table.insert(stock, 3)
    end

    player:showText(npc, ID.text.OSTALIE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
