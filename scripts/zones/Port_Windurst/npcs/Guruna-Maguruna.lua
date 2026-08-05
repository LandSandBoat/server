-----------------------------------
-- Area: Port Windurst
--  NPC: Guruna-Maguruna
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.HEMP_GORGET,     1080, 3 },
        { xi.item.BEETLE_GORGET,   4668, 1 },
        { xi.item.DOUBLET,         2745, 3 },
        { xi.item.ROBE,             240, 3 },
        { xi.item.LEATHER_VEST,     672, 3 },
        { xi.item.TUNIC,           1400, 3 },
        { xi.item.COTTON_DOUBLET, 13728, 2 },
        { xi.item.LINEN_ROBE,      3085, 3 },
        { xi.item.GLOVES,          1515, 3 },
        { xi.item.CUFFS,            132, 3 },
        { xi.item.LEATHER_GLOVES,   360, 3 },
        { xi.item.MITTS,            655, 3 },
        { xi.item.COTTON_GLOVES,   7440, 2 },
        { xi.item.LINEN_CUFFS,     1745, 3 },
        { xi.item.BONE_MASK,       3912, 2 },
        { xi.item.BEETLE_MASK,     7638, 1 },

    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.GURUNAMAGURUNA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
