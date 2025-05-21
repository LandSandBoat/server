-----------------------------------
-- Area: Rabao
--  NPC: Brave Ox
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_PROTECT_IV,    88400 },
        { xi.item.SCROLL_OF_PROTECTRA_IV,  84240 },
        { xi.item.SCROLL_OF_DISPEL,        72800 },
        { xi.item.SCROLL_OF_STUN,          36400 },
        { xi.item.SCROLL_OF_FLASH,         36400 },
        { xi.item.SCROLL_OF_RERAISE_III,  624000 },
        { xi.item.SCROLL_OF_BANISH_III,    89440 },
        { xi.item.SCROLL_OF_CURA,          22713 },
        { xi.item.SCROLL_OF_CURA_II,       99918 },
        { xi.item.SCROLL_OF_SACRIFICE,     70304 },
        { xi.item.SCROLL_OF_ESUNA,         73008 },
        { xi.item.SCROLL_OF_AUSPICE,       35006 },
        { xi.item.SCROLL_OF_CURE_VI,      159546 },
        { xi.item.SCROLL_OF_PROTECT_V,    120042 },
        { xi.item.SCROLL_OF_SHELL_V,      141382 },
        { xi.item.SCROLL_OF_CRUSADE,      162162 },
    }

    player:showText(npc, zones[xi.zone.RABAO].text.BRAVEOX_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
