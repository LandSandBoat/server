-----------------------------------
-- Area: Bastok Markets
--  NPC: Balthilda
-- Type: Merchant
-- !pos -300 -10 -161 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.POETS_CIRCLET, 2152, 3,
        xi.items.TUNIC,         1456, 3,
        xi.items.LINEN_ROBE,    3208, 3,
        xi.items.MITTS,          681, 3,
        xi.items.LINEN_CUFFS,   1814, 3,
        xi.items.SLACKS,         972, 3,
        xi.items.LINEN_SLOPS,   2620, 3,
        xi.items.SOLEA,          629, 3,
        xi.items.HOLLY_CLOGS,   1690, 3,
        xi.items.LEATHER_RING,  1300, 3,
    }

    player:showText(npc, ID.text.BALTHILDA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
