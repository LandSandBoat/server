-----------------------------------
-- Area: Port Windurst
--  NPC: Guruna-Maguruna
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.HEMP_GORGET,     1123, 3 },
        { xi.item.BEETLE_GORGET,   4854, 1 },
        { xi.item.DOUBLET,         2854, 3 },
        { xi.item.ROBE,             249, 3 },
        { xi.item.LEATHER_VEST,     698, 3 },
        { xi.item.TUNIC,           1456, 3 },
        { xi.item.COTTON_DOUBLET, 14277, 2 },
        { xi.item.LINEN_ROBE,      3208, 3 },
        { xi.item.GLOVES,          1575, 3 },
        { xi.item.CUFFS,            137, 3 },
        { xi.item.LEATHER_GLOVES,   374, 3 },
        { xi.item.MITTS,            681, 3 },
        { xi.item.COTTON_GLOVES,   7737, 2 },
        { xi.item.LINEN_CUFFS,     1814, 3 },
        { xi.item.BONE_MASK,       4068, 2 },
        { xi.item.BEETLE_MASK,     7943, 1 },

    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.GURUNAMAGURUNA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
