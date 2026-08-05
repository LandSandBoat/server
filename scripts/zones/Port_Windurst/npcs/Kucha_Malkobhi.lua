-----------------------------------
-- Area: Port Windurst
--  NPC: Kucha Malkobhi
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.TARUTARU_KAFTAN,   300 },
        { xi.item.TARUTARU_MITTS,    180 },
        { xi.item.TARUTARU_BRACCAE,  260 },
        { xi.item.TARUTARU_CLOMPS,   180 },
        { xi.item.MITHRAN_SEPARATES, 300 },
        { xi.item.MITHRAN_GAUNTLETS, 180 },
        { xi.item.MITHRAN_LOINCLOTH, 260 },
        { xi.item.MITHRAN_GAITERS,   180 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.KUCHAMALKOBHI_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
