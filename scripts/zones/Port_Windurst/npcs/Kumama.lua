-----------------------------------
-- Area: Port Windurst
--  NPC: Kumama
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BRAIS,              2194, 3 },
        { xi.item.SLOPS,               199, 3 },
        { xi.item.LEATHER_TROUSERS,    557, 3 },
        { xi.item.SLACKS,              972, 3 },
        { xi.item.COTTON_BRAIS,      11232, 2 },
        { xi.item.LINEN_SLOPS,        2620, 3 },
        { xi.item.GAITERS,            1466, 3 },
        { xi.item.ASH_CLOGS,           128, 3 },
        { xi.item.LEATHER_HIGHBOOTS,   349, 3 },
        { xi.item.SOLEA,               629, 3 },
        { xi.item.COTTON_GAITERS,     7496, 2 },
        { xi.item.HOLLY_CLOGS,        1690, 3 },
        { xi.item.LAUAN_SHIELD,        124, 3 },
        { xi.item.MAPLE_SHIELD,        629, 3 },
        { xi.item.MAHOGANY_SHIELD,    5179, 1 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.KUMAMA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
