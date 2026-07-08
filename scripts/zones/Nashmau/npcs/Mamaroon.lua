-----------------------------------
-- Area: Nashmau
--  NPC: Mamaroon
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_STUN,          27000 },
        { xi.item.SCROLL_OF_ENFIRE,         5160 },
        { xi.item.SCROLL_OF_ENBLIZZARD,     4098 },
        { xi.item.SCROLL_OF_ENAERO,         2500 },
        { xi.item.SCROLL_OF_ENSTONE,        2030 },
        { xi.item.SCROLL_OF_ENTHUNDER,      1515 },
        { xi.item.SCROLL_OF_ENWATER,        7074 },
        { xi.item.SCROLL_OF_SHOCK_SPIKES,   9000 },
        { xi.item.WHITE_PUPPET_TURBAN,     29950 },
        { xi.item.BLACK_PUPPET_TURBAN,     29950 },
        { xi.item.SCROLL_OF_ENLIGHT,      100800 },
        { xi.item.SCROLL_OF_ENDARK,       100800 },
    }

    player:showText(npc, zones[xi.zone.NASHMAU].text.MAMAROON_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
