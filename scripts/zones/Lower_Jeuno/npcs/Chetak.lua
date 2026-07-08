-----------------------------------
-- Area: Lower Jeuno
--  NPC: Chetak
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.RED_CAP,       20000 },
        { xi.item.WOOL_CAP,      39270 },
        { xi.item.WOOL_HAT,      12138 },
        { xi.item.GAMBISON,      32500 },
        { xi.item.CLOAK,         33212 },
        { xi.item.WOOL_GAMBISON, 68640 },
        { xi.item.WOOL_ROBE,     18088 },
        { xi.item.BLACK_TUNIC,   10356 },
        { xi.item.BRACERS,       10080 },
        { xi.item.LINEN_MITTS,   15732 },
        { xi.item.WOOL_CUFFS,    10234 },
        { xi.item.WHITE_MITTS,    4830 },
    }

    player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.ORTHONS_GARMENT_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
