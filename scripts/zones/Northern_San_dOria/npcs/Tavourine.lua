-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Tavourine
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BRONZE_KNIFE,       164, 3, },
        { xi.item.KNIFE,             2425, 3, },
        { xi.item.BRONZE_ROD,         100, 3, },
        { xi.item.BRASS_ROD,          690, 3, },
        { xi.item.ROD,               2652, 1, },
        { xi.item.BRONZE_MACE,        188, 3, },
        { xi.item.MACE,              4848, 2, },
        { xi.item.BRONZE_AXE,         316, 3, },
        { xi.item.CLAYMORE,          2720, 3, },
        { xi.item.MYTHRIL_CLAYMORE, 42000, 1, },
        { xi.item.BRONZE_SPEAR,       880, 3, },
        { xi.item.BRASS_SPEAR,       5200, 3, },
        { xi.item.SPEAR,            17640, 3, },
        { xi.item.LANCE,            18420, 3, },
    }

    player:showText(npc, ID.text.TAVOURINE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
