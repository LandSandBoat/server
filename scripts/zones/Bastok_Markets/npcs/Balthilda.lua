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
        { xi.item.POETS_CIRCLET, 2173, 3 },
        { xi.item.TUNIC,         1470, 3 },
        { xi.item.LINEN_ROBE,    3239, 3 },
        { xi.item.MITTS,          687, 3 },
        { xi.item.LINEN_CUFFS,   1832, 3 },
        { xi.item.SLACKS,         981, 3 },
        { xi.item.LINEN_SLOPS,   2646, 3 },
        { xi.item.SOLEA,          635, 3 },
        { xi.item.HOLLY_CLOGS,   1706, 3 },
        { xi.item.LEATHER_RING,  1312, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.BALTHILDA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
