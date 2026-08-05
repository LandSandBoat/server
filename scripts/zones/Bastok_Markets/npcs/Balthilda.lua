-----------------------------------
-- Area: Bastok Markets
--  NPC: Balthilda
-- Type: Merchant
-- !pos -300 -10 -161 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.POETS_CIRCLET, 2070, 3 },
        { xi.item.TUNIC,         1400, 3 },
        { xi.item.LINEN_ROBE,    3085, 3 },
        { xi.item.MITTS,          655, 3 },
        { xi.item.LINEN_CUFFS,   1745, 3 },
        { xi.item.SLACKS,         935, 3 },
        { xi.item.LINEN_SLOPS,   2520, 3 },
        { xi.item.SOLEA,          605, 3 },
        { xi.item.HOLLY_CLOGS,   1625, 3 },
        { xi.item.LEATHER_RING,  1250, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.BALTHILDA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
