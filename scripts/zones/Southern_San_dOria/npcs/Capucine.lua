-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Capucine
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.POETS_CIRCLET, 2070, },
        { xi.item.TUNIC,         1400, },
        { xi.item.LINEN_ROBE,    3085, },
        { xi.item.MITTS,          655, },
        { xi.item.LINEN_CUFFS,   1745, },
        { xi.item.SLACKS,         935, },
        { xi.item.LINEN_SLOPS,   2520, },
        { xi.item.SOLEA,          605, },
        { xi.item.HOLLY_CLOGS,   1625, },
    }

    player:showText(npc, ID.text.CAPUCINE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
