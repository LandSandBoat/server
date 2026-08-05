-----------------------------------
-- Area: Rabao
--  NPC: Brave Ox
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_PROTECT_IV,    85000 },
        { xi.item.SCROLL_OF_PROTECTRA_IV,  81000 },
        { xi.item.SCROLL_OF_DISPEL,        70000 },
        { xi.item.SCROLL_OF_STUN,          35000 },
        { xi.item.SCROLL_OF_FLASH,         35000 },
        { xi.item.SCROLL_OF_RERAISE_III,  600000 },
        { xi.item.SCROLL_OF_BANISH_III,    86000 },
        { xi.item.SCROLL_OF_CURA,          21840 },
        { xi.item.SCROLL_OF_CURA_II,       96075 },
        { xi.item.SCROLL_OF_SACRIFICE,     67600 },
        { xi.item.SCROLL_OF_ESUNA,         70200 },
        { xi.item.SCROLL_OF_AUSPICE,       33660 },
        { xi.item.SCROLL_OF_CURE_VI,      153410 },
        { xi.item.SCROLL_OF_PROTECT_V,    115425 },
        { xi.item.SCROLL_OF_SHELL_V,      135945 },
        { xi.item.SCROLL_OF_CRUSADE,      155925 },
    }

    player:showText(npc, zones[xi.zone.RABAO].text.BRAVEOX_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.SELBINA_RABAO)
end

return entity
