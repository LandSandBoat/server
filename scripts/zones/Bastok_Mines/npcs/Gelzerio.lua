-----------------------------------
-- Area: Bastok Mines
--  NPC: Galzerio
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.LUGWORM,              12, 3,
        xi.item.LITTLE_WORM,           4, 2,
        xi.item.BAMBOO_FISHING_ROD,  561, 1,
        xi.item.YEW_FISHING_ROD,     245, 2,
        xi.item.WILLOW_FISHING_ROD,   74, 3,
        xi.item.ROBE,                249, 3,
        xi.item.CUFFS,               137, 3,
        xi.item.SLOPS,               199, 3,
        xi.item.ASH_CLOGS,           128, 3,
        xi.item.HEADGEAR,           2013, 3,
        xi.item.DOUBLET,            2854, 3,
        xi.item.GLOVES,             1575, 3,
        xi.item.BRAIS,              2194, 3,
        xi.item.GAITERS,            1466, 3,
    }

    player:showText(npc, ID.text.GELZERIO_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
