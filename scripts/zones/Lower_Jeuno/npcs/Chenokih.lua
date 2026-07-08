-----------------------------------
-- Area: Lower Jeuno
--  NPC: Chenokih
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.HOSE,            24500 },
        { xi.item.LINEN_SLACKS,    22632 },
        { xi.item.WOOL_HOSE,       57600 },
        { xi.item.WOOL_SLOPS,      14756 },
        { xi.item.BLACK_SLACKS,     6900 },
        { xi.item.SOCKS,           16000 },
        { xi.item.SHOES,           14352 },
        { xi.item.WOOL_SOCKS,      35200 },
        { xi.item.CHESTNUT_SABOTS,  9180 },
        { xi.item.SANDALS,          4488 },
        { xi.item.BLACK_CAPE,      11088 },
        { xi.item.SCARLET_RIBBON,   1250 },
    }

    player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.ORTHONS_GARMENT_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
