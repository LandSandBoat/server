-----------------------------------
-- Area: Bastok Mines
--  NPC: Galzerio
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SILVER_BELT,       11171, 1 },
        { xi.item.SWORDBELT,         21780, 1 },
        { xi.item.LUGWORM,              12, 3 },
        { xi.item.LITTLE_WORM,           4, 2 },
        { xi.item.BAMBOO_FISHING_ROD,  535, 1 },
        { xi.item.YEW_FISHING_ROD,     236, 2 },
        { xi.item.WILLOW_FISHING_ROD,   71, 3 },
        { xi.item.ROBE,                240, 3 },
        { xi.item.CUFFS,               132, 3 },
        { xi.item.SLOPS,               192, 3 },
        { xi.item.ASH_CLOGS,           124, 3 },
        { xi.item.HEADGEAR,           1936, 3 },
        { xi.item.DOUBLET,            2745, 3 },
        { xi.item.GLOVES,             1515, 3 },
        { xi.item.BRAIS,              2110, 3 },
        { xi.item.GAITERS,            1410, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MINES].text.GELZERIO_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
