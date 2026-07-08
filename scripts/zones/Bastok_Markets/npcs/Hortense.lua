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
        { xi.item.SCROLL_OF_FOE_REQUIEM,         75, 3 },
        { xi.item.SCROLL_OF_FOE_REQUIEM_II,     514, 3 },
        { xi.item.SCROLL_OF_FOE_REQUIEM_III,   4620, 3 },
        { xi.item.SCROLL_OF_FOE_REQUIEM_IV,    8064, 3 },
        { xi.item.SCROLL_OF_FOE_REQUIEM_VII,  53865, 3 },
        { xi.item.SCROLL_OF_ARMYS_PAEON,         44, 3 },
        { xi.item.SCROLL_OF_ARMYS_PAEON_II,     374, 3 },
        { xi.item.SCROLL_OF_ARMYS_PAEON_III,   3780, 3 },
        { xi.item.SCROLL_OF_ARMYS_PAEON_IV,    6930, 3 },
        { xi.item.SCROLL_OF_ARMYS_PAEON_VI,   55860, 3 },
        { xi.item.SCROLL_OF_VALOR_MINUET,        25, 3 },
        { xi.item.SCROLL_OF_VALOR_MINUET_II,   1285, 3 },
        { xi.item.SCROLL_OF_VALOR_MINUET_III,  6468, 3 },
        { xi.item.SCROLL_OF_VALOR_MINUET_V,   61425, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.HORTENSE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
