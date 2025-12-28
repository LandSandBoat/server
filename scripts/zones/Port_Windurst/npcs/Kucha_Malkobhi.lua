-----------------------------------
-- Area: Port Windurst
--  NPC: Kucha Malkobhi
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.TARUTARU_KAFTAN,   312 },
        { xi.item.TARUTARU_MITTS,    187 },
        { xi.item.TARUTARU_BRACCAE,  270 },
        { xi.item.TARUTARU_CLOMPS,   187 },
        { xi.item.MITHRAN_SEPARATES, 312 },
        { xi.item.MITHRAN_GAUNTLETS, 187 },
        { xi.item.MITHRAN_LOINCLOTH, 270 },
        { xi.item.MITHRAN_GAITERS,   187 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.KUCHAMALKOBHI_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
