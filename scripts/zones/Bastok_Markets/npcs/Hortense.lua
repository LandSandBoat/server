-----------------------------------
-- Area: Bastok Markets
--  NPC: Hortense
-- !pos -82.503 -4.849 -132.376 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_FOE_REQUIEM,         71, 3 },
        { xi.item.SCROLL_OF_FOE_REQUIEM_II,     490, 3 },
        { xi.item.SCROLL_OF_FOE_REQUIEM_III,   4400, 3 },
        { xi.item.SCROLL_OF_FOE_REQUIEM_IV,    7680, 3 },
        { xi.item.SCROLL_OF_FOE_REQUIEM_VII,  51300, 3 },
        { xi.item.SCROLL_OF_ARMYS_PAEON,         42, 3 },
        { xi.item.SCROLL_OF_ARMYS_PAEON_II,     357, 3 },
        { xi.item.SCROLL_OF_ARMYS_PAEON_III,   3600, 3 },
        { xi.item.SCROLL_OF_ARMYS_PAEON_IV,    6600, 3 },
        { xi.item.SCROLL_OF_ARMYS_PAEON_VI,   53200, 3 },
        { xi.item.SCROLL_OF_VALOR_MINUET,        25, 3 },
        { xi.item.SCROLL_OF_VALOR_MINUET_II,   1224, 3 },
        { xi.item.SCROLL_OF_VALOR_MINUET_III,  6160, 3 },
        { xi.item.SCROLL_OF_VALOR_MINUET_V,   58500, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.HORTENSE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
