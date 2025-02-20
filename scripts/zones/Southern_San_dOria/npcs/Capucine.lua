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
        xi.item.POETS_CIRCLET, 2152,
        xi.item.TUNIC,         1456,
        xi.item.LINEN_ROBE,    3208,
        xi.item.MITTS,          681,
        xi.item.LINEN_CUFFS,   1814,
        xi.item.SLACKS,         972,
        xi.item.LINEN_SLOPS,   2620,
        xi.item.SOLEA,          629,
        xi.item.HOLLY_CLOGS,   1690,
    }

    player:showText(npc, ID.text.CAPUCINE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
