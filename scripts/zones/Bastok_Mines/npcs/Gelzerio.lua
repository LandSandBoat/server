-----------------------------------
-- Area: Bastok Mines
--  NPC: Galzerio
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LUGWORM,              12, 3 },
        { xi.item.LITTLE_WORM,           4, 2 },
        { xi.item.BAMBOO_FISHING_ROD,  561, 1 },
        { xi.item.YEW_FISHING_ROD,     247, 2 },
        { xi.item.WILLOW_FISHING_ROD,   75, 3 },
        { xi.item.ROBE,                252, 3 },
        { xi.item.CUFFS,               138, 3 },
        { xi.item.SLOPS,               201, 3 },
        { xi.item.ASH_CLOGS,           130, 3 },
        { xi.item.HEADGEAR,           2032, 3 },
        { xi.item.DOUBLET,            2882, 3 },
        { xi.item.GLOVES,             1590, 3 },
        { xi.item.BRAIS,              2215, 3 },
        { xi.item.GAITERS,            1480, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MINES].text.GELZERIO_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
